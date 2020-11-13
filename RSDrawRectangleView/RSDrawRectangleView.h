//
//  RSDrawRectangleView.h
//  RSDrawRectangleView
//
//  Created by Raysharp666 on 2020/11/12.
//  Copyright © 2020 LyongY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSRectangleData.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSDrawRectangleView : UIView

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;
- (instancetype)initWithMaxCount:(NSInteger)maxCount colors:(NSArray<UIColor *> *)colors;

- (void)addRectangle:(RSRectangleData *)rectangle;

- (void)addRectangles:(NSArray<RSRectangleData *> *)rectangles;

- (void)deleteAll;

- (NSArray<RSRectangleData *> *)rectangles;

@end

NS_ASSUME_NONNULL_END
