//
//  RSDrawRectangleView.m
//  RSDrawRectangleView
//
//  Created by Raysharp666 on 2020/11/12.
//  Copyright © 2020 LyongY. All rights reserved.
//

#import "RSDrawRectangleView.h"
#import "RSRectangle.h"

@interface RSDrawRectangleView() {
    NSInteger _maxCount;
    NSMutableArray *_colors;
    NSMutableArray<RSRectangle *> *_rectangles;
    RSRectangle *_tempRectangle;
    CGPoint _beginPoint;
}

@end

@implementation RSDrawRectangleView

- (instancetype)initWithMaxCount:(NSInteger)maxCount colors:(NSArray<UIColor *> *)colors {
    self = [super init];
    if (self) {
        _rectangles = [NSMutableArray array];
        _maxCount = maxCount;
        _colors = colors.mutableCopy;
    }
    return self;
}

- (void)addRectangle:(RSRectangleData *)rectangleData {
    if (_rectangles.count >= _maxCount) {
        return;
    }
    UIColor *drawColor = nil;
    if (_colors.count > _rectangles.count) {
        drawColor = _colors[_rectangles.count];
    }
    RSRectangle *item = [[RSRectangle alloc] initWithParent:self frame:rectangleData];
    item.rectangle.drawColor = drawColor ?: item.rectangle.drawColor;
    [_rectangles addObject:item];
}

- (void)addRectangles:(NSArray<RSRectangleData *> *)rectangles {
    for (RSRectangleData *item in rectangles) {
        [self addRectangle:item];
    }
}

- (void)deleteAll {
    for (UIView *view in _rectangles) {
        [view removeFromSuperview];
    }
    [_rectangles removeAllObjects];
}

- (NSArray<RSRectangleData *> *)rectangles {
    NSMutableArray<RSRectangleData *> *arr = [NSMutableArray array];
    for (RSRectangle *item in _rectangles) {
        [arr addObject:item.rectangle.clone];
    }
    return arr;
}

#pragma mark - 交互
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_rectangles.count < _maxCount) {
        _beginPoint = [touches.anyObject locationInView:self];
        RSRectangleData *tempData = [[RSRectangleData alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [self addRectangle:tempData];
        _tempRectangle = _rectangles.lastObject;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!_tempRectangle) {
        return;
    }
    CGPoint point = [touches.anyObject locationInView:self];
    CGFloat offsetX = point.x - _beginPoint.x;
    CGFloat offsetY = point.y - _beginPoint.y;
    CGFloat x, y, width, height;
    if (offsetX > 0) {
        x = _beginPoint.x;
        width = offsetX;
    } else {
        x = _beginPoint.x + offsetX;
        width = -offsetX;
    }
    
    if (offsetY > 0) {
        y = _beginPoint.y;
        height = offsetY;
    } else {
        y = _beginPoint.y + offsetY;
        height = -offsetY;
    }
    
    _tempRectangle.rectangle.x = x /= self.bounds.size.width;
    _tempRectangle.rectangle.y = y /= self.bounds.size.height;
    _tempRectangle.rectangle.width = width /= self.bounds.size.width;
    _tempRectangle.rectangle.height = height /= self.bounds.size.height;
    [_tempRectangle updateFrame];
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _tempRectangle = nil;
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _tempRectangle = nil;
    [self setNeedsDisplay];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    for (RSRectangle *item in _rectangles) {
        [item updateFrame];
    }
}

@end
