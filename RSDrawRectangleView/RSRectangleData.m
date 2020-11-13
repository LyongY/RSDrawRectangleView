//
//  RSRectangleData.m
//  RSDrawRectangleView
//
//  Created by Raysharp666 on 2020/11/13.
//  Copyright © 2020 LyongY. All rights reserved.
//

#import "RSRectangleData.h"

@implementation RSRectangleData

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        CGFloat x, y, width, height;
        x = frame.origin.x;
        y = frame.origin.y;
        width = frame.size.width;
        height = frame.size.height;
        if (x < 0) {
            x = 0;
        } else if (x > 1) {
            x = 1;
        }
        
        if (y < 0) {
            y = 0;
        } else if (y > 1) {
            y = 1;
        }
        
        if (x + width > 1) {
            width = 1 - x;
        }
        
        if (y + height > 1) {
            height = 1 - y;
        }
        
        _x = x;
        _y = y;
        _width = width;
        _height = height;
        _drawColor = [UIColor colorWithRed:arc4random()%255/255. green:arc4random()%255/255. blue:arc4random()%255/255. alpha:0.5];
    }
    return self;
}

- (instancetype)clone {
    RSRectangleData *item = [[RSRectangleData alloc] initWithFrame:CGRectMake(_x, _y, _width, _height)];
    item.drawColor = _drawColor;
    return item;
}

//- (void)setX:(CGFloat)x {
//    if (x < 0) {
//        x = 0;
//    }
//    if (x > 1) {
//        x = 1;
//    }
//    if (x + _width > 1) {
//        x = 1 - _width;
//    }
//    _x = x;
//}
//
//- (void)setY:(CGFloat)y {
//    if (y < 0) {
//        y = 0;
//    }
//    if (y > 1) {
//        y = 1;
//    }
//    if (y + _height > 1) {
//        y = 1 - _height;
//    }
//    _y = y;
//}
//
//- (void)setWidth:(CGFloat)width {
//    CGFloat maxWidth = 1 - _x;
//    if (width > maxWidth) {
//        width = maxWidth;
//    }
//    _width = width;
//}
//
//- (void)setHeight:(CGFloat)height {
//    CGFloat maxHeight = 1 - _y;
//    if (height > maxHeight) {
//        height = maxHeight;
//    }
//    _height = height;
//}


@end
