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
}

@end

@implementation RSDrawRectangleView

- (instancetype)initWithMaxCount:(NSInteger)maxCount colors:(NSArray<UIColor *> *)colors {
    self = [super init];
    if (self) {
        _maxCount = maxCount;
        _colors = colors.mutableCopy;
    }
    return self;
}

- (void)addRectangle:(RSRectangleData *)rectangleData {
    [_rectangles addObject:[[RSRectangle alloc] initWithParent:self frame:rectangleData]];
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
    return _rectangles.mutableCopy;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
