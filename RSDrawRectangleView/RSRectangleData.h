//
//  RSRectangleData.h
//  RSDrawRectangleView
//
//  Created by Raysharp666 on 2020/11/13.
//  Copyright © 2020 LyongY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSRectangleData : NSObject
@property (nonatomic, assign) CGFloat x; // 0.0 ~ 1.0
@property (nonatomic, assign) CGFloat y; // 0.0 ~ 1.0
@property (nonatomic, assign) CGFloat width; // 0.0 ~ (1.0 - x)
@property (nonatomic, assign) CGFloat height; // 0.0 ~ (1.0 - y)
@property (nonatomic, strong) UIColor *drawColor;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)clone;
@end

NS_ASSUME_NONNULL_END
