//
//  RSDrawRectangleView.m
//  RSDrawRectangleView
//
//  Created by Raysharp666 on 2020/11/12.
//  Copyright © 2020 LyongY. All rights reserved.
//

#import "RSDrawRectangleView.h"

@interface RSDrawRectangleView() {
    NSInteger _maxCount;
    NSMutableArray *_colors;
    NSMutableArray *_rectangles;
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

- (void)addRectangle:(RSRectangle *)rectangle {
    [_rectangles addObject:rectangle];
    [self setNeedsDisplay];
}

- (void)addRectangles:(NSArray<RSRectangle *> *)rectangles {
    for (RSRectangle *item in rectangles) {
        [self addRectangle:item];
    }
}

- (void)deleteAll {
    [_rectangles removeAllObjects];
    [self setNeedsDisplay];
}

- (NSArray<RSRectangle *> *)rectangles {
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
