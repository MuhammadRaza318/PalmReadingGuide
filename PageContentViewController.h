//
//  PageContentViewController.h
//  PalmReadingGuide
//
//  Created by MacBookPro on 9/21/17.
//  Copyright © 2017 MacBookPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UnityAds/UnityAds.h>
@import GoogleMobileAds;

@interface PageContentViewController : UIViewController<UnityAdsDelegate, UnityAdsLoadDelegate, UnityAdsShowDelegate , GADBannerViewDelegate>
@property NSUInteger pageIndex;
@property NSString *detailText;
@property NSString *imageFile;
@property (nonatomic, assign) NSUInteger totalNumberOfImages;
@property (weak, nonatomic) IBOutlet UIImageView *ivLineImage;
@property (weak, nonatomic) IBOutlet UITextView *tvlLineDetail;
@property (weak, nonatomic) IBOutlet GADBannerView *VBannerView;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property NSString* titleText;
@property (strong, nonatomic) IBOutlet UIImageView *rightImage;
@property (strong, nonatomic) IBOutlet UIImageView *leftImage;

//@property (strong, nonatomic) UADSBannerView *bottomBannerView;
//@property(nonatomic,strong)GADInterstitial* interstitial;
- (IBAction)backButtonPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *numberOfImage;

@end
