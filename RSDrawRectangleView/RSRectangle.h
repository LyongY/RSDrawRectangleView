//
//  RSRectangle.h
//  RSDrawRectangleView
//
//  Created by Raysharp666 on 2020/11/12.
//  Copyright © 2020 LyongY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSRectangleData.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSRectangle : UIView
@property (nonatomic, strong) RSRectangleData *rectangle;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;
- (instancetype)initWithParent:(UIView *)view frame:(RSRectangleData *)rectangle;
- (void)updateFrame;
@end

NS_ASSUME_NONNULL_END
