//
//  HCOneNumView.m
//  HCScrollNumLabel
//
//  Created by 韩冲 on 2019/1/3.
//  Copyright © 2019年 tmachc. All rights reserved.
//

#import "HCOneNumView.h"

@interface HCOneNumView ()

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *color;

@end

@implementation HCOneNumView

- (instancetype)initWithFont:(UIFont *)font color:(UIColor *)color
{
    self = [super init];
    if (self) {
        _font = font;
        _color = color;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    NSDictionary *attr = @{
                           NSFontAttributeName: _font,
                           NSForegroundColorAttributeName: _color
                           };
    for (int i = 0; i < 20; i ++) {
        NSString *str = [NSString stringWithFormat:@"%d", (19 - i) % 10];
        CGSize size = [str sizeWithAttributes:attr];
        CGRect rect = CGRectMake((_font.pointSize * CharWidthScale - size.width)/2, i * (_font.pointSize + 5), _font.pointSize * CharWidthScale, _font.pointSize);
        [str drawInRect:rect withAttributes:attr];
    }
}

@end
