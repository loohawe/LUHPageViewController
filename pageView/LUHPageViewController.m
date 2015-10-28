//
//  LUHPageViewController.m
//  pageView
//
//  Created by luhao on 15/10/27.
//  Copyright © 2015年 Hawe. All rights reserved.
//

#import "LUHPageViewController.h"
#import "LUHUnderLineButtonView.h"

@interface LUHPageViewController () <UIScrollViewDelegate>
{
    UISegmentedControl *_segmentControl;
    LUHUnderLineButtonView *_underLineButtonView;
    NSArray *_contentsView;
}
@property (nonatomic) UIScrollView *scrollView;
@end

@implementation LUHPageViewController
@synthesize titleStyle = _titleStyle;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollView];
    [self addTitle];
    [self addContentViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSArray *contents = [self.sourceData contentViewControllersForPage:self];
    for (UIViewController *page in contents) {
        [page removeFromParentViewController];
    }
}

- (void)addTitle {
    NSArray *titles = [self.sourceData titlesForPage:self];
    NSInteger titlesWidth = [self.sourceData widthWithSingleTitle];
    
    if (self.titleStyle == LUHPageViewTitleStyleSegment) {
        _segmentControl = [[UISegmentedControl alloc] initWithItems:titles];
        _segmentControl.selectedSegmentIndex = 0;
        _segmentControl.frame = CGRectMake(0, 0, titles.count * titlesWidth, kLUHPageViewControllerTitleHeight);
        [_segmentControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
        
        [self.navigationItem setTitleView:_segmentControl];
    } else if (self.titleStyle == LUHPageViewTitleStyleUnderlineButton) {
        _underLineButtonView = [[LUHUnderLineButtonView alloc] initWithItems:titles];
        _underLineButtonView.frame = CGRectMake(0, 0, titles.count * titlesWidth, kLUHPageViewControllerTitleHeight);
        [_underLineButtonView addTarget:self action:@selector(underLineButtonAction:)];
        
        [self.navigationItem setTitleView:_underLineButtonView];
    }
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:.7 green:.7 blue:.8 alpha:1];
}


- (void)addContentViewController
{
    NSArray *contents = [self.sourceData contentViewControllersForPage:self];
    _contentsView = [NSArray arrayWithArray:contents];
    int i = 0;
    for (UIViewController *page in contents) {
        [self addChildViewController:page];
        page.view.frame = CGRectMake(CGRectGetWidth(self.view.frame)*i,
                                     0, CGRectGetWidth(self.view.frame),
                                     CGRectGetHeight(self.view.frame));
        [self.scrollView addSubview:page.view];
        i++;
    }
}

#pragma mark - action
- (void)segmentAction:(UISegmentedControl *)sender
{
    NSInteger index = sender.selectedSegmentIndex;
    [self scrollScrollViewTo:index];
}

- (void)underLineButtonAction:(UIButton *)button
{
    NSInteger index = button.tag-1000;
    [self scrollScrollViewTo:index];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger pages = offsetX/CGRectGetWidth(self.view.frame);
    [self selectTilteWith:pages];
    [self didShowPageIndex:pages];
}

#pragma mark - private
- (void)didShowPageIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(pageDidShow:)]) {
        [self.delegate pageDidShow:_contentsView[index]];
    }
}

- (void)selectTilteWith:(NSInteger)index
{
    if (self.titleStyle == LUHPageViewTitleStyleSegment) {
        _segmentControl.selectedSegmentIndex = index;
    }
    if (self.titleStyle == LUHPageViewTitleStyleUnderlineButton) {
        _underLineButtonView.selectedIndex = index;
    }
}

- (void)scrollScrollViewTo:(NSInteger)index
{
    CGFloat offsetX = CGRectGetWidth(self.view.frame)*index;
    CGPoint point = CGPointMake(offsetX, -64);
    [self.scrollView setContentOffset:point animated:YES];
    
    [self didShowPageIndex:index];
}



#pragma mark - get and set
- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame),
                                       264);
        NSArray *titles = [self.sourceData titlesForPage:self];
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame)*titles.count,
                                             0);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = YES;
        _scrollView.alwaysBounceVertical = NO;
        _scrollView.directionalLockEnabled = YES;
        _scrollView.scrollEnabled = self.scrollEnabled;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;

    }
    return _scrollView;
}

- (void)setSelectedTitleIndex:(NSInteger)selectedTitleIndex
{
    if (_selectedTitleIndex == selectedTitleIndex) return;
    _selectedTitleIndex = selectedTitleIndex;
    [self selectTilteWith:selectedTitleIndex];
}

- (LUHPageViewTitleStyle)titleStyle
{
    return (_titleStyle == 0) ? LUHPageViewTitleStyleSegment:_titleStyle;
}

- (void)setTitleStyle:(LUHPageViewTitleStyle)titleStyle
{
    if (_titleStyle == titleStyle) return;
    _titleStyle = titleStyle;
    [self addTitle];
}

@end
