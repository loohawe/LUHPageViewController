# LUHPageViewController
实现如下效果:
![pageView](https://github.com/Koneey/LUHPageViewController/blob/master/gif/pageView.gif)

#分析
通过传入标题**数组**, 视图控制器**数组**初始化 UIScrollView, 实现翻页.
通过 ViewController的 addChildrenViewCrotroller 来让各个自视图控制器控制子视图. 

#实现

###代理方法
类似系统 UITableView 的实现方式, 定义数据源,与代理方法

* id<LUHPageViewControllerSourceDate> sourceData
```
@protocol LUHPageViewControllerSourceDate <NSObject>
@required
-(NSInteger)widthWithSingleTitle;
-(NSArray *)titlesForPage:(LUHPageViewController *)pageView;
-(NSArray *)contentViewControllersForPage:(LUHPageViewController *)pageView;
@end
```

* id<LUHPageViewControllerDelegate> delegate
```
@protocol LUHPageViewControllerDelegate <NSObject>
-(void)pageDidShow:(UIViewController *)viewController;
@end
```

##主要实现逻辑
设置标题
```
-(void)addTitle {
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
```

设置 scrollView
```
-(void)addContentViewController
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
```

附 [源代码](https://github.com/Koneey/LUHPageViewController)
