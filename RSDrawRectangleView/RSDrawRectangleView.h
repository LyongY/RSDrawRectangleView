//
//  RSDrawRectangleView.h
//  RSDrawRectangleView
//
//  Created by Raysharp666 on 2020/11/12.
//  Copyright © 2020 LyongY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSRectangle.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSDrawRectangleView : UIView

- (instancetype)initWithMaxCount:(NSInteger)maxCount colors:(NSArray<UIColor *> *)colors;

- (void)addRectangle:(RSRectangle *)rectangle;

- (void)addRectangles:(NSArray<RSRectangle *> *)rectangles;

- (void)deleteAll;

- (NSArray<RSRectangle *> *)rectangles;

@end

NS_ASSUME_NONNULL_END
