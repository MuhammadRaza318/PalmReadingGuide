//
//  PurchaseViewController.m
//  PalmReadingGuide
//
//  Created by Raza on 23/08/2024.
//  Copyright © 2024 MacBookPro. All rights reserved.
//


#import "PurchaseViewController.h"
#import <StoreKit/StoreKit.h>
#import "AppDelegate.h"
@interface PurchaseViewController () <SKProductsRequestDelegate, SKPaymentTransactionObserver>

@property (nonatomic, strong) SKProduct *product;
@property (nonatomic, weak) IBOutlet UILabel *priceLabel;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@end
@implementation PurchaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    self.activityIndicator.hidesWhenStopped = YES;
    self.activityIndicator.color = UIColor.whiteColor;
    self.activityIndicator.hidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updatePriceLabel)
                                                     name:@"ProductPriceUpdated"
                                                   object:nil];
        [self updatePriceLabel];
    
    self.priceLabel.layer.cornerRadius = 10;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)purchaseProductWithProductIdentifier:(NSString *)productIdentifier {
    if ([SKPaymentQueue canMakePayments]) {
        self.activityIndicator.hidden = NO;
        [self.activityIndicator startAnimating];
        SKProductsRequest *productRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:productIdentifier]];
        productRequest.delegate = self;
        [productRequest start];
   
    } else {
        NSLog(@"In-app purchases are disabled on this device.");
        [self.activityIndicator stopAnimating];
        self.activityIndicator.hidden = YES;
    }
}
- (void)updatePriceLabel {
    dispatch_async(dispatch_get_main_queue(), ^{
        // Update price label when notification is received
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        if (appDelegate.product) {
            SKProduct *product = appDelegate.product;
            if (product) {
                NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                formatter.numberStyle = NSNumberFormatterCurrencyStyle;
                formatter.locale = product.priceLocale;
                self.priceLabel.text = [formatter stringFromNumber:product.price];
            }
        }
    });
}


- (void)initiatePurchase {
    if (self.product) {
        if (self.product) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // Update UI elements on the main thread
                self.activityIndicator.hidden = YES;
                [self.activityIndicator stopAnimating];
            });
            
            SKPayment *payment = [SKPayment paymentWithProduct:self.product];
            [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
            [[SKPaymentQueue defaultQueue] addPayment:payment];
        }
    }
}

- (IBAction)purchaseBtnTapped:(id)sender {
//    [self initiatePurchase];
    
    NSString *productIdentifier = @"removeadsPalmReading";
    [self purchaseProductWithProductIdentifier:productIdentifier];
}

- (IBAction)restoreBtn:(id)sender {
    NSString *productIdentifier = @"removeadsPalmReading";
    [self purchaseProductWithProductIdentifier:productIdentifier];
}

- (IBAction)cancelBtnTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - SKProductsRequestDelegate

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    if (response.products.count > 0) {
        NSLog(@"Product is available");
        self.product = response.products.firstObject;
        // Now that we have the product information, we can initiate the purchase process
        [self initiatePurchase];
    } else {
        [self.activityIndicator  stopAnimating];
        self.activityIndicator.hidden = YES;

        NSLog(@"Product is not available");
    }
}
#pragma mark - SKPaymentTransactionObserver
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
    NSLog(@"Updated transactions called with %lu transactions", (unsigned long)transactions.count);
    BOOL shouldHandleSuccessfulPurchase = NO;
    for (SKPaymentTransaction *transaction in transactions) {
        NSLog(@"Processing transaction with state: %ld", (long)transaction.transactionState);
        switch (transaction.transactionState) {
                 case SKPaymentTransactionStatePurchased:
                NSLog(@"Purchase successful!");
                               shouldHandleSuccessfulPurchase = YES;
                               [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isProUser"];
                               BOOL syncSuccess = [[NSUserDefaults standardUserDefaults] synchronize];
                               NSLog(@"User defaults updated with isProUser = YES: %@", syncSuccess ? @"Success" : @"Failed");
                               [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                               break;
                       
            case SKPaymentTransactionStateFailed:
                          NSLog(@"Purchase failed with error: %@", transaction.error.localizedDescription);
                          // Handle failed purchase here
                          [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                          break;

                      case SKPaymentTransactionStateRestored:
                          NSLog(@"Purchase restored");
                        shouldHandleSuccessfulPurchase = YES;
                          [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                          break;
                          
                      case SKPaymentTransactionStateDeferred:
                          NSLog(@"Purchase deferred");
                          // Handle deferred purchase here
                          break;

                      case SKPaymentTransactionStatePurchasing:
                          NSLog(@"Purchasing");
                          // Handle purchasing state here
                          break;
        }
    }
    
if (shouldHandleSuccessfulPurchase) {
           [self handleSuccessfulPurchase];
   }
}

- (void)handleSuccessfulPurchase {
//    NSLog(@"handleSuccessfulPurchase called");
//        
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isProUser"];
//        BOOL syncSuccess = [[NSUserDefaults standardUserDefaults] synchronize];
//        NSLog(@"User defaults updated with isProUser = YES: %@", syncSuccess ? @"Success" : @"Failed");
//        
//        // Check if the value is actually saved
//        BOOL isProUser = [[NSUserDefaults standardUserDefaults] boolForKey:@"isProUser"];
//        NSLog(@"isProUser value in user defaults: %d", isProUser);
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"Stopping activity indicator and preparing to show alert");
//            
//            [self.activityIndicator stopAnimating];
//            self.activityIndicator.hidden = YES;
//            
//            if (self.presentingViewController) {
//                [self dismissViewControllerAnimated:YES completion:^{
//                    NSLog(@"ViewController dismissed, showing success alert");
//                    [self showPurchaseSuccessAlert];
//                    if (self.onPurchaseCompletion) {
//                        self.onPurchaseCompletion(); // Call the callback
//                    }
//                }];
//            } else {
//                NSLog(@"No presentingViewController, showing success alert directly");
//                [self showPurchaseSuccessAlert];
//                if (self.onPurchaseCompletion) {
//                    self.onPurchaseCompletion(); // Call the callback
//                }
//            }
//        });
    
    NSLog(@"handleSuccessfulPurchase called");
       
       [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isProUser"];
       BOOL syncSuccess = [[NSUserDefaults standardUserDefaults] synchronize];
       NSLog(@"User defaults updated with isProUser = YES: %@", syncSuccess ? @"Success" : @"Failed");

       dispatch_async(dispatch_get_main_queue(), ^{
           [self.activityIndicator stopAnimating];
           self.activityIndicator.hidden = YES;

           [self dismissViewControllerAnimated:YES completion:^{
               if (self.onPurchaseCompletion) {
                   self.onPurchaseCompletion(); // Call the callback
               }
           }];
       });
}


- (void)showPurchaseSuccessAlert {
    PurchaseViewController *purchaseViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PurchaseViewController"];
        
        if (purchaseViewController) {
            purchaseViewController.modalPresentationStyle = UIModalPresentationFullScreen;
            __weak typeof(self) weakSelf = self;
            purchaseViewController.onPurchaseCompletion = ^{
//                [self ]; 
            };
            [self presentViewController:purchaseViewController animated:YES completion:nil];
        } else {
            NSLog(@"Error: Could not instantiate PurchaseViewController.");
        }
}
@end


