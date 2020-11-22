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
@property (nonatomic, copy) void(^didClickBlock)(RSRectangle *item);
@end

@implementation RSRectangle

- (instancetype)initWithParent:(UIView *)view frame:(RSRectangleData *)rectangle didClick:(nonnull void (^)(RSRectangle * _Nonnull))completion {
    self = [super init];
    if (self) {
        _didClickBlock = completion;
        _extensionLength = 20;
        self.backgroundColor = UIColor.clearColor;
        [view addSubview:self];
        self.rectangle = rectangle.clone;
        [self updateFrame];
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    [self setNeedsDisplay];
}

- (void)updateFrame {
    CGSize size = self.superview.bounds.size;
    CGFloat width = size.width;
    CGFloat height = size.height;
    self.frame = CGRectMake(_rectangle.x * width - _extensionLength, _rectangle.y * height - _extensionLength, _rectangle.width * width + _extensionLength * 2, _rectangle.height * height + _extensionLength * 2);
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    // 填充色
    CGRect showRect = CGRectMake(rect.origin.x + _extensionLength, rect.origin.y + _extensionLength, rect.size.width - _extensionLength * 2, rect.size.height - _extensionLength * 2);
    [_rectangle.drawColor set];
    UIBezierPath *real = [UIBezierPath bezierPathWithRect:showRect];
    [real fill];
    
    // 边框颜色
    UIColor *boarderColor = self.selected ? (_rectangle.selectedColor ?: _rectangle.drawColor) : _rectangle.drawColor;
    CGFloat red = 0, green = 0, blue = 0, alpha = 0, white = 0;
    if ([boarderColor getRed:&red green:&green blue:&blue alpha:&alpha]) {
        [[UIColor colorWithRed:red * 0.7 green:green * 0.7 blue:blue * 0.7 alpha:1] set];
    } else {
        [boarderColor getWhite:&white alpha:&alpha];
        [[UIColor colorWithWhite:white * 0.7 alpha:1] set];
    }
    
    // 边框
    UIBezierPath *border = [UIBezierPath bezierPathWithRect:showRect];
    border.lineWidth = 1;
    [border stroke];
    
    // 四点
    CGFloat length = 6;
    UIBezierPath *topLeft = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(showRect.origin.x - length / 2, showRect.origin.y - length / 2, length, length)];
    UIBezierPath *topRight = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(showRect.origin.x + showRect.size.width - length / 2, showRect.origin.y - length / 2, length, length)];
    UIBezierPath *bottomLeft = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(showRect.origin.x - length / 2, showRect.origin.y + showRect.size.height - length / 2, length, length)];
    UIBezierPath *bottomRight = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(showRect.origin.x + showRect.size.width - length / 2, showRect.origin.y + showRect.size.height- length / 2, length, length)];
    [topLeft fill];
    [topRight fill];
    [bottomLeft fill];
    [bottomRight fill];
    

}

#pragma mark - Touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.superview bringSubviewToFront:self];
    _didClickBlock(self);
    _beginPoint = [touches.anyObject locationInView:self.superview];
    _beginRect = CGRectMake(_rectangle.x, _rectangle.y, _rectangle.width, _rectangle.height);
    CGPoint point = [touches.anyObject locationInView:self];
    _state = [self stateWithPoint:point];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    BOOL changeLeft = _state == RSRectangleStateLeft || _state == RSRectangleStateBottomLeft || _state == RSRectangleStateTopLeft;
    BOOL changeTop = _state == RSRectangleStateTop || _state == RSRectangleStateTopRight || _state == RSRectangleStateTopLeft;
    BOOL changeRight = _state == RSRectangleStateRight || _state == RSRectangleStateBottomRight || _state == RSRectangleStateTopRight;
    BOOL changeBottom = _state == RSRectangleStateBottom || _state == RSRectangleStateBottomLeft || _state == RSRectangleStateBottomRight;

    CGPoint point = [touches.anyObject locationInView:self.superview];
    
    CGFloat x = _beginRect.origin.x;
    CGFloat y = _beginRect.origin.y;
    CGFloat width = _beginRect.size.width;
    CGFloat height = _beginRect.size.height;
    
    if (_state == RSRectangleStateNone) {
        CGFloat offsetX = (point.x - _beginPoint.x) / self.superview.bounds.size.width;
        CGFloat offsetY = (point.y - _beginPoint.y) / self.superview.bounds.size.height;
        x += offsetX;
        y += offsetY;
        x = x < 0 ? 0 : x;
        y = y < 0 ? 0 : y;
        x = x + width > 1 ? 1 - width : x;
        y = y + height > 1 ? 1 - height : y;
    }

    if (changeLeft) {
        CGFloat offset = (point.x - _beginPoint.x) / self.superview.bounds.size.width;
        if (offset < _beginRect.size.width) { // 在左
            x = _beginRect.origin.x + offset;
            if (x < 0) {
                x = 0;
            }
            if (x == 0) {
                width = _beginRect.size.width + _beginRect.origin.x;
            } else {
                width = _beginRect.size.width - offset;
            }
        } else { // 跨右
            x = _beginRect.origin.x + _beginRect.size.width;
            width = offset - _beginRect.size.width;
            if (x + width > 1) {
                width = 1 - x;
            }
        }
    }
    
    if (changeRight) {
        CGFloat offset = (point.x - _beginPoint.x) / self.superview.bounds.size.width;
        if (offset > -_beginRect.size.width) { // 在右
            x = _beginRect.origin.x;
            width = offset + _beginRect.size.width;
            if (x + width > 1) {
                width = 1 - x;
            }
        } else { // 跨左
            x = _beginRect.origin.x + _beginRect.size.width + offset;
            if (x < 0) {
                x = 0;
            }
            if (x == 0) {
                width = _beginRect.origin.x;
            } else {
                width =  -offset - _beginRect.size.width;
            }
        }
    }
    
    if (changeTop) {
        CGFloat offset = (point.y - _beginPoint.y) / self.superview.bounds.size.height;
        if (offset < _beginRect.size.height) { // 在上
            y = _beginRect.origin.y + offset;
            if (y < 0) {
                y = 0;
            }
            if (y == 0) {
                height = _beginRect.size.height + _beginRect.origin.y;
            } else {
                height = _beginRect.size.height - offset;
            }
        } else { // 跨下
            y = _beginRect.origin.y + _beginRect.size.height;
            height = offset - _beginRect.size.height;
            if (y + height > 1) {
                height = 1 - y;
            }
        }
    }
    
    if (changeBottom) {
        CGFloat offset = (point.y - _beginPoint.y) / self.superview.bounds.size.height;
        if (offset > -_beginRect.size.height) { // 在下
            y = _beginRect.origin.y;
            height = offset + _beginRect.size.height;
            if (y + height > 1) {
                height = 1 - y;
            }
        } else { // 跨上
            y = _beginRect.origin.y + _beginRect.size.height + offset;
            if (y < 0) {
                y = 0;
            }
            if (y == 0) {
                height = _beginRect.origin.y;
            } else {
                height =  -offset - _beginRect.size.height;
            }
        }
    }

    _rectangle.x = x;
    _rectangle.y = y;
    _rectangle.width = width;
    _rectangle.height = height;
    [self updateFrame];
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
