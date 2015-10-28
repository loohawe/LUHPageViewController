//
//  ViewController.m
//  pageView
//
//  Created by luhao on 15/10/27.
//  Copyright © 2015年 Hawe. All rights reserved.
//

#define debugMethod() NSLog(@"%s", __func__)

#import "ViewController.h"
#import "AAViewController.h"
#import "BBViewController.h"
#import "LUHUnderLineButtonView.h"

@interface ViewController () <LUHPageViewControllerSourceDate>

@end

@implementation ViewController

- (void)viewDidLoad {
    self.titleStyle = LUHPageViewTitleStyleSegment;
    self.scrollEnabled = YES;
    self.selectedTitleIndex = 0;
    self.sourceData = self;
    [super viewDidLoad];
    
    UIButton *changeMode = [[UIButton alloc] initWithFrame:CGRectMake(50, 314, 267, 60)];
    [changeMode setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [changeMode setTitle:@"改变导航栏标题显示类型" forState:UIControlStateNormal];
    [changeMode addTarget:self action:@selector(changeModeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeMode];
}

- (void)changeModeAction:(id)sender
{
    self.titleStyle = self.titleStyle == LUHPageViewTitleStyleSegment ? LUHPageViewTitleStyleUnderlineButton :
    LUHPageViewTitleStyleSegment;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)underLineAction:(UIButton *)button {
    NSLog(@"%ld", (long)button.tag);
}

#pragma mark - LUHPageViewControllerSourceDate
- (NSInteger)widthWithSingleTitle
{
    return 50;
}

- (NSArray *)titlesForPage:(LUHPageViewController *)pageView
{
    return @[@"AA", @"BB", @"CC", @"DD", @"EE"];
}
- (NSArray *)contentViewControllersForPage:(LUHPageViewController *)pageView
{
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 176, 100)];
    label1.backgroundColor = [UIColor clearColor];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = @"AA";
    label1.textColor = [UIColor blackColor];
    AAViewController *aa = [[AAViewController alloc] init];
    aa.view.backgroundColor = [UIColor grayColor];
    [aa.view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 176, 100)];
    label2.backgroundColor = [UIColor clearColor];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = @"BB";
    label2.textColor = [UIColor blackColor];
    BBViewController *bb = [[BBViewController alloc] init];
    bb.view.backgroundColor = [UIColor blueColor];
    [bb.view addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 176, 100)];
    label3.backgroundColor = [UIColor clearColor];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.text = @"CC";
    label3.textColor = [UIColor blackColor];
    AAViewController *cc = [[AAViewController alloc] init];
    cc.view.backgroundColor = [UIColor redColor];
    [cc.view addSubview:label3];
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 176, 100)];
    label4.backgroundColor = [UIColor clearColor];
    label4.textAlignment = NSTextAlignmentCenter;
    label4.text = @"DD";
    label4.textColor = [UIColor blackColor];
    BBViewController *dd = [[BBViewController alloc] init];
    dd.view.backgroundColor = [UIColor orangeColor];
    [dd.view addSubview:label4];
    
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 176, 100)];
    label5.backgroundColor = [UIColor clearColor];
    label5.textAlignment = NSTextAlignmentCenter;
    label5.text = @"EE";
    label5.textColor = [UIColor blackColor];
    AAViewController *ee = [[AAViewController alloc] init];
    ee.view.backgroundColor = [UIColor yellowColor];
    [ee.view addSubview:label5];
    
    return @[aa, bb, cc, dd, ee];
}

@end
