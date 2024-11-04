//
//  ViewController.h
//  PalmReadingGuide
//
//  Created by MacBookPro on 9/20/17.
//  Copyright © 2017 MacBookPro. All rights reserved.
//
@import GoogleMobileAds;
#import <UIKit/UIKit.h>
#import <UnityAds/UnityAds.h>
@interface ViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UnityAdsInitializationDelegate, UnityAdsDelegate, UnityAdsLoadDelegate, UnityAdsShowDelegate , GADBannerViewDelegate>
@property (nonatomic, strong) NSString *selectedLine;
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *lbTilal;

//@property (strong, nonatomic) UADSBannerView *bottomBannerView;
@property (weak, nonatomic) IBOutlet GADBannerView *VBannerView;
//@property(nonatomic,strong)GADInterstitial* interstitial;

@property (nonatomic, strong) NSArray *filteredTitles;
@property (nonatomic, strong) NSArray *filteredDefinitions;
@property (nonatomic, strong) NSArray *filteredImages;

@end

