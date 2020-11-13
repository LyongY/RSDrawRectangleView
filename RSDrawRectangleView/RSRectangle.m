//
//  RSRectangle.m
//  RSDrawRectangleView
//
//  Created by Raysharp666 on 2020/11/12.
//  Copyright © 2020 LyongY. All rights reserved.
//

#import "RSRectangle.h"

typedef NS_ENUM(NSUInteger, RSRectangleState) {
    RSRectangleStateNone,
    RSRectangleStateTopLeft,
    RSRectangleStateTop,
    RSRectangleStateTopRight,
    RSRectangleStateRight,
    RSRectangleStateBottomRight,
    RSRectangleStateBottom,
    RSRectangleStateBottomLeft,
    RSRectangleStateLeft,
};

@interface RSRectangle()
@property (nonatomic, assign) CGFloat extensionLength;
@property (nonatomic, assign) RSRectangleState state;
@property (nonatomic, assign) CGPoint beginPoint; // 开始点击时的点
@property (nonatomic, assign) CGRect beginRect; // 开始更改前的rect 0~1
@end

@implementation RSRectangle

- (instancetype)initWithParent:(UIView *)view frame:(CGRect)frame {
    self = [super init];
    if (self) {
        _extensionLength = 20;
        self.backgroundColor = UIColor.clearColor;
        [view addSubview:self];
        self.x = frame.origin.x;
        self.y = frame.origin.y;
        self.width = frame.size.width;
        self.height = frame.size.height;
    }
    return self;
}

- (void)setX:(CGFloat)x {
    if (x < 0) {
        x = 0;
    }
    if (x > 1) {
        x = 1;
    }
    if (x + _width > 1) {
        x = 1 - _width;
    }
    _x = x;
    [self updateFrame];
}

- (void)setY:(CGFloat)y {
    if (y < 0) {
        y = 0;
    }
    if (y > 1) {
        y = 1;
    }
    if (y + _height > 1) {
        y = 1 - _height;
    }
    _y = y;
    [self updateFrame];
}

- (void)setWidth:(CGFloat)width {
    CGFloat maxWidth = 1 - _x;
    if (width > maxWidth) {
        width = maxWidth;
    }
    _width = width;
    [self updateFrame];
}

- (void)setHeight:(CGFloat)height {
    CGFloat maxHeight = 1 - _y;
    if (height > maxHeight) {
        height = maxHeight;
    }
    _height = height;
    [self updateFrame];
}

- (void)updateFrame {
    CGSize size = self.superview.bounds.size;
    CGFloat width = size.width;
    CGFloat height = size.height;
    self.frame = CGRectMake(_x * width - _extensionLength, _y * height - _extensionLength, _width * width + _extensionLength * 2, _height * height + _extensionLength * 2);
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [UIColor.lightGrayColor set];
    UIBezierPath *full = [UIBezierPath bezierPathWithRect:rect];
    [full stroke];
    
    [UIColor.blackColor set];
    UIBezierPath *real = [UIBezierPath bezierPathWithRect:CGRectMake(rect.origin.x + _extensionLength, rect.origin.y + _extensionLength, rect.size.width - _extensionLength * 2, rect.size.height - _extensionLength * 2)];
    [real stroke];
}

#pragma mark - Touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _beginPoint = [touches.anyObject locationInView:self.superview];
    _beginRect = CGRectMake(_x, _y, _width, _height);
    CGPoint point = [touches.anyObject locationInView:self];
    _state = [self stateWithPoint:point];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    BOOL changeLeft = _state == RSRectangleStateLeft || _state == RSRectangleStateBottomLeft || _state == RSRectangleStateTopLeft;
    BOOL changeTop = _state == RSRectangleStateTop || _state == RSRectangleStateTopRight || _state == RSRectangleStateTopLeft;
    BOOL changeRight = _state == RSRectangleStateRight || _state == RSRectangleStateBottomRight || _state == RSRectangleStateTopRight;
    BOOL changeBottom = _state == RSRectangleStateBottom || _state == RSRectangleStateBottomLeft || _state == RSRectangleStateBottomRight;
    if (_state == RSRectangleStateNone) {
        changeLeft = changeTop = changeRight = changeBottom = YES;
    }
    CGPoint point = [touches.anyObject locationInView:self.superview];
    
    if (changeLeft) {
        CGFloat offseet = (point.x - _beginPoint.x) / self.superview.bounds.size.width;
        CGFloat x = 0;
        CGFloat width = 0;
        if (offseet < _beginRect.size.width) { // 在左
            x = _beginRect.origin.x + offseet;
            if (x < 0) {
                x = 0;
            }
            if (x == 0) {
                width = _beginRect.size.width + _beginRect.origin.x;
            } else {
                width = _beginRect.size.width - offseet;
            }
        } else { // 跨右
            x = _beginRect.origin.x + _beginRect.size.width;
            width = offseet - _beginRect.size.width;
            if (x + width > 1) {
                width = 1 - x;
            }
        }
        _x = x;
        _width = width;
        [self updateFrame];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _state = RSRectangleStateNone;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _state = RSRectangleStateNone;
}

#pragma mark - Help
- (RSRectangleState)stateWithPoint:(CGPoint)point {
    BOOL bLeft = point.x < _extensionLength * 2;
    BOOL bTop = point.y < _extensionLength * 2;
    BOOL bRight = (point.x > self.frame.size.width - _extensionLength * 2);
    BOOL bBottom = (point.y > self.frame.size.height - _extensionLength * 2);
    if (bLeft && bTop) {
        return RSRectangleStateTopLeft;
    } else if (bRight && bTop) {
        return RSRectangleStateTopRight;
    } else if (bRight && bBottom) {
        return RSRectangleStateBottomRight;
    } else if (bLeft && bBottom) {
        return RSRectangleStateBottomLeft;
    } else if (bTop) {
        return RSRectangleStateTop;
    } else if (bRight) {
        return RSRectangleStateRight;
    } else if (bBottom) {
        return RSRectangleStateBottom;
    } else if (bLeft) {
        return RSRectangleStateLeft;
    } else {
        return RSRectangleStateNone;
    }
}

@end
