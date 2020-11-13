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
        _x = frame.origin.x;
        _y = frame.origin.y;
        _width = frame.size.width;
        _height = frame.size.height;
    }
    return self;
}

- (instancetype)clone {
    return [[RSRectangleData alloc] initWithFrame:CGRectMake(_x, _y, _width, _height)];
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
