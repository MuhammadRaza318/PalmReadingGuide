//
//  TableViewController.h
//  PalmReadingGuide
//
//  Created by Raza on 23/08/2024.
//  Copyright © 2024 MacBookPro. All rights reserved.
//
@import GoogleMobileAds;
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewController : UIViewController < GADBannerViewDelegate , UITableViewDelegate , UITableViewDataSource>
@property(strong, nonatomic)NSMutableArray *arrName;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet GADBannerView *VBannerView;


@end

NS_ASSUME_NONNULL_END
