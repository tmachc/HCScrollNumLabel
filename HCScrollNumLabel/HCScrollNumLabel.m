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

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.clipsToBounds = true;
        _width = 0;
        _height = 0;
    }
    return self;
}

- (instancetype)initWithText:(NSString *)text font:(UIFont *)font color:(UIColor *)color
{
    self = [super init];
    if (self) {
        [self setText:text font:font color:color];
    }
    return self;
}

- (void)setText:(NSString *)text font:(UIFont *)font color:(UIColor *)color
{
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

- (void)initView
{
    if (!_text || !_font || !_color) {
        return;
    }
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
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
//    WS(ws); // 更新自身约束
//    [self mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(ws.width);
//        make.height.mas_equalTo(ws.height);
//    }];
    [self layoutIfNeeded];
}

- (void)reset
{
    for (NSInteger i = 0; i < self.sepStrArr.count; i ++) {
        NSInteger index = self.sepStrArr.count - i - 1;
        if (![self.sepStrArr[index] isEqualToString:@"."]) {
            UIView *view = [self viewWithTag:9800 + (index)];
            CGRect rect = view.frame;
            rect.origin.y = (self.font.pointSize + 5) * -19;
            view.frame = rect;
        }
    }
}

- (void)startAnimate
{
    for (NSInteger i = 0; i < self.sepStrArr.count; i ++) {
        NSInteger index = self.sepStrArr.count - i - 1;
        if (![self.sepStrArr[index] isEqualToString:@"."]) {
            UIView *view = [self viewWithTag:9800 + (index)];
            [UIView animateWithDuration:1.5 delay:i * 0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                CGRect rect = view.frame;
                rect.origin.y = (self.font.pointSize + 5) * ([self.sepStrArr[index] intValue] - 9);
                view.frame = rect;
            } completion:^(BOOL finished) {
            }];
        }
    }
}

@end
