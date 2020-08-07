//
//  ViewController.m
//  UseHotLibs
//
//  Created by yuqin on 2020/8/6.
//  Copyright © 2020 JJS. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>

@interface ViewController ()
@property(nonatomic, strong) UIView *superView;
@property(nonatomic, strong) UIView *bottomView;
@property(nonatomic, strong) MASConstraint *bottom;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
}

- (void)setupViews {
    [self multipliedView];
}

- (void)multipliedView {
    UIView *blueView = [UIView new];
    blueView.backgroundColor = UIColor.blueColor;
    [self.view addSubview:blueView];
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.height.mas_equalTo(self.view.mas_width).multipliedBy(0.5);
    }];
}

/*
* 固定item的宽度, 间距动态变化
*/
- (void)fixedWidthItems {
    NSMutableArray *views = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        UILabel *label = [UILabel new];
        label.text = [NSString stringWithFormat:@"%d", i];
        label.textColor = UIColor.blackColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = UIColor.greenColor;
        [self.view addSubview:label];
        [views addObject:label];
    }
    [views mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view);
        make.height.mas_equalTo(@100);
    }];
    [views mas_distributeViewsAlongAxis:MASAxisTypeHorizontal
                    withFixedItemLength:80 leadSpacing:50 tailSpacing:50];

}

/*
 * 固定间距，item的宽度动态变化
 */
- (void)fixedSpaceItems {
    NSMutableArray *views = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        UILabel *label = [UILabel new];
        label.text = [NSString stringWithFormat:@"%d", i];
        label.textColor = UIColor.blackColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = UIColor.greenColor;
        [self.view addSubview:label];
        [views addObject:label];
    }
    [views mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view);
        make.height.mas_equalTo(@100);
    }];
    [views mas_distributeViewsAlongAxis:MASAxisTypeHorizontal
                       withFixedSpacing:20
                            leadSpacing:20
                            tailSpacing:20];
}

/*
 * 使用Masonry撑大view
 */
- (void)setupExpandView {
    self.superView = [UIView new];
    self.superView.backgroundColor = UIColor.greenColor;
    [self.view addSubview:self.superView];
    [self.superView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(100);
    }];
    
    UIView *blueView = [UIView new];
    blueView.backgroundColor = UIColor.blueColor;
    [self.view addSubview:blueView];
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.superView);
        make.top.mas_equalTo(self.superView.mas_bottom).offset(20);
        make.height.equalTo(@100);
    }];
    
    UIButton *button = [UIButton new];
    [button setTitle:@"Add label" forState:UIControlStateNormal];
    button.backgroundColor = UIColor.orangeColor;
    [button addTarget:self action:@selector(tapButton) forControlEvents:UIControlEventTouchUpInside];
    [self.superView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(10);
        self.bottom = make.bottom.mas_equalTo(-10);
        make.height.equalTo(@100);
    }];
    self.bottomView = button;

}

- (void)tapButton {
    [self.bottom uninstall];
    
    UILabel *label = [UILabel new];
    label.text = @"label";
    label.textColor = UIColor.whiteColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = UIColor.orangeColor;
    [self.superView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomView.mas_bottom).offset(10);
        make.left.right.mas_equalTo(self.bottomView);
        self.bottom = make.bottom.mas_equalTo(-10);
        make.height.equalTo(@100);
    }];
    self.bottomView = label;
}
@end
