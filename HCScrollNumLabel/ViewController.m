//
//  ViewController.m
//  HCScrollNumLabel
//
//  Created by 韩冲 on 2019/1/3.
//  Copyright © 2019年 tmachc. All rights reserved.
//

#import "ViewController.h"
#import "HCScrollNumLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    HCScrollNumLabel *lab = [[HCScrollNumLabel alloc] initWithText:@"32.1298" font:[UIFont systemFontOfSize:30] color:[UIColor redColor]];
    lab.frame = CGRectMake(30, 200, lab.width,lab.height);
    lab.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:lab];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [lab startAnimate];
    });
}


@end
