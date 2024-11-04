//
//  AppDelegate.h
//  PalmReadingGuide
//
//  Created by MacBookPro on 9/20/17.
//  Copyright © 2017 MacBookPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate , SKProductsRequestDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SKProduct *product;
@end

