//
//  HCScrollNumLabel.m
//  HCScrollNumLabel
//
//  Created by 韩冲 on 2019/1/3.
//  Copyright © 2019年 tmachc. All rights reserved.
//

#import "HCScrollNumLabel.h"
#import "HCOneNumView.h"

@interface HCScrollNumLabel ()

@property (nonatomic, readwrite) CGFloat width;
@property (nonatomic, readwrite) CGFloat height;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSArray <NSString *> *sepStrArr;
@property (nonatomic, copy) NSArray <UIView *> *sepViewArr;
@property (nonatomic, copy) UIFont *font;
@property (nonatomic, copy) UIColor *color;

@end

@implementation HCScrollNumLabel

- (instancetype)initWithText:(NSString *)text font:(UIFont *)font color:(UIColor *)color
{
    self = [super init];
    if (self) {
        self.clipsToBounds = true;
        _text = text;
        _font = font;
        _color = color;
        _height = font.pointSize * 1.2;
        NSMutableArray *marr = [NSMutableArray arrayWithCapacity:_text.length];
        for (NSInteger i = 0; i < _text.length; i ++) {
            [marr addObject:[_text substringWithRange:NSMakeRange(i, 1)]];
        }
        _sepStrArr = [marr copy];
        [self initView];
    }
    return self;
}

- (void)initView
{
    CGFloat pointWidth = _font.pointSize * CharWidthScale - _font.pointSize * 0.3;
    int pointNum = 0;
    for (int i = 0; i < self.sepStrArr.count; i ++) {
        if ([self.sepStrArr[i] isEqualToString:@"."]) {
            UILabel *labPoint = [[UILabel alloc] init];
            labPoint.text = @".";
            labPoint.textColor = _color;
            labPoint.font = _font;
            labPoint.textAlignment = NSTextAlignmentCenter;
            labPoint.frame = CGRectMake(i * _font.pointSize * CharWidthScale - pointWidth * pointNum, 0, _font.pointSize * 0.3, _font.pointSize * 1.2);
            labPoint.tag = 9800 + i;
            [self addSubview:labPoint];
            pointNum ++;
        }
        else {
            HCOneNumView *view = [[HCOneNumView alloc] initWithFont:_font color:_color];
            view.frame = CGRectMake(i * _font.pointSize * CharWidthScale - pointWidth * pointNum, (_font.pointSize + 5) * -19, _font.pointSize * CharWidthScale, (_font.pointSize + 5) * 20);
            view.tag = 9800 + i;
            [self addSubview:view];
            _width = (i + 1) * _font.pointSize * CharWidthScale - pointWidth * pointNum;
        }
    }
}

- (void)startAnimate
{
    for (NSInteger i = 0; i < self.sepStrArr.count; i ++) {
        NSInteger index = self.sepStrArr.count - i - 1;
        if (![self.sepStrArr[index] isEqualToString:@"."]) {
            UIView *view = [self viewWithTag:9800 + (index)];
            [UIView animateWithDuration:1.5 delay:i * 0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                CGRect rect = view.frame;
                rect.origin.y = (self.font.pointSize + 5) * ([self.sepStrArr[index] intValue] - 9);
                view.frame = rect;
            } completion:^(BOOL finished) {
            }];
        }
    }
}

@end
