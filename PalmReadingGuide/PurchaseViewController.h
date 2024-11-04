//
//  PurchaseViewController.h
//  PalmReadingGuide
//
//  Created by Raza on 23/08/2024.
//  Copyright © 2024 MacBookPro. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^PurchaseCompletionHandler)(void);
@interface PurchaseViewController : UIViewController
@property (nonatomic, copy) PurchaseCompletionHandler onPurchaseCompletion;
@end

NS_ASSUME_NONNULL_END
