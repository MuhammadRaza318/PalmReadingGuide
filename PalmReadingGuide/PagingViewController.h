//
//  PagingViewController.h
//  PalmReadingGuide
//
//  Created by MacBookPro on 9/21/17.
//  Copyright © 2017 MacBookPro. All rights reserved.
//

#import <UIKit/UIKit.h>
//@import GoogleMobileAds;

@interface PagingViewController : UIViewController<UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;

//@property (strong, nonatomic) NSArray *pageTitles;
//
//@property (strong, nonatomic) NSArray *pageImages;
@property (nonatomic, strong) NSString *selectedLine;
@property NSInteger selectedIndex;
@property NSString* titleString;


@end
