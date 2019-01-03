//
//  HCScrollNumLabel.h
//  HCScrollNumLabel
//
//  Created by 韩冲 on 2019/1/3.
//  Copyright © 2019年 tmachc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCOneNumView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HCScrollNumLabel : UIView

@property (nonatomic, readonly) CGFloat width;
@property (nonatomic, readonly) CGFloat height;

- (instancetype)initWithText:(NSString *)text font:(UIFont *)font color:(UIColor *)color;
- (void)startAnimate;

@end

NS_ASSUME_NONNULL_END
