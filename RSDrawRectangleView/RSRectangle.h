//
//  RSRectangle.h
//  RSDrawRectangleView
//
//  Created by Raysharp666 on 2020/11/12.
//  Copyright © 2020 LyongY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSRectangle : UIView

@property (nonatomic, assign) CGFloat x; // 0.0 ~ 1.0
@property (nonatomic, assign) CGFloat y; // 0.0 ~ 1.0
@property (nonatomic, assign) CGFloat width; // 0.0 ~ (1.0 - x)
@property (nonatomic, assign) CGFloat height; // 0.0 ~ (1.0 - y)

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;
- (instancetype)initWithParent:(UIView *)view frame:(CGRect)frame;
- (void)updateFrame;
@end

NS_ASSUME_NONNULL_END
