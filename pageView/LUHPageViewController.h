//
//  LUHPageViewController.h
//  pageView
//
//  Created by luhao on 15/10/27.
//  Copyright © 2015年 Hawe. All rights reserved.
//

#define kLUHPageViewControllerTitleHeight 30

#import <UIKit/UIKit.h>

typedef enum {
    LUHPageViewTitleStyleSegment,
    LUHPageViewTitleStyleUnderlineButton
}LUHPageViewTitleStyle;

#import <UIKit/UIKit.h>

@class LUHPageViewController;
@protocol LUHPageViewControllerDelegate <NSObject>
- (void)pageDidShow:(UIViewController *)viewController;
@end

@protocol LUHPageViewControllerSourceDate <NSObject>
@required
- (NSInteger)widthWithSingleTitle;
- (NSArray *)titlesForPage:(LUHPageViewController *)pageView;
- (NSArray *)contentViewControllersForPage:(LUHPageViewController *)pageView;
@end


@interface LUHPageViewController : UIViewController
@property (nonatomic, weak) id<LUHPageViewControllerSourceDate> sourceData;
@property (nonatomic, weak) id<LUHPageViewControllerDelegate> delegate;
@property (nonatomic) LUHPageViewTitleStyle titleStyle;
@property (nonatomic) BOOL scrollEnabled;
@property (nonatomic) NSInteger selectedTitleIndex;
@end
