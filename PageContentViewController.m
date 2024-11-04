//
//  PageContentViewController.m
//  PalmReadingGuide
//
//  Created by MacBookPro on 9/21/17.
//  Copyright © 2017 MacBookPro. All rights reserved.
//

#import "PageContentViewController.h"
#import "Constant.h"
#import "SingletonClass.h"
#import "PagingViewController.h"
@interface PageContentViewController ()  <GADFullScreenContentDelegate> {
    SingletonClass* singletonObject;
    BOOL flagForViewWillAppear;
    
}

@property(nonatomic, strong) GADInterstitialAd *interstitial;
@end
static NSInteger clickCount = 0;
@implementation PageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    flagForViewWillAppear  = YES;
    singletonObject=[SingletonClass SingletonClass];
    [self setupArrays];
//    self.ivLineImage.image = [UIImage imageNamed:self.imageFile];
//    self.tvlLineDetail.text = self.detailText;
    self.lbTitle.text=_titleText;
   
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
       self.ivLineImage.userInteractionEnabled = YES;
       [self.ivLineImage addGestureRecognizer:tapGesture];
    
   // [self setupConstraints];
    self.numberOfImage.textAlignment = NSTextAlignmentCenter;
    self.numberOfImage.text = [NSString stringWithFormat:@"Page %lu of %lu", (unsigned long)(self.pageIndex + 1), (unsigned long)self.totalNumberOfImages];
        
        // Update other UI components with image and text
        self.ivLineImage.image = [UIImage imageNamed:self.imageFile];
        self.tvlLineDetail.text = self.detailText;
    
}


- (void)setupConstraints {
    // Disable autoresizing mask translation
    self.leftImage.translatesAutoresizingMaskIntoConstraints = NO;
    self.rightImage.translatesAutoresizingMaskIntoConstraints = NO;

    // Center `leftImage` and `rightImage` vertically relative to `ivLineImage`
    NSLayoutConstraint *leftImageCenterYConstraint = [NSLayoutConstraint constraintWithItem:self.leftImage
    attribute:NSLayoutAttributeCenterY
    relatedBy:NSLayoutRelationEqual
    toItem:self.ivLineImage
    attribute:NSLayoutAttributeCenterY
    multiplier:1.0
    constant:0.0];
    NSLayoutConstraint *rightImageCenterYConstraint = [NSLayoutConstraint constraintWithItem:self.rightImage
    attribute:NSLayoutAttributeCenterY
    relatedBy:NSLayoutRelationEqual
    toItem:self.ivLineImage
    attribute:NSLayoutAttributeCenterY
     multiplier:1.0
     constant:0.0];

    // Leading constraint for `leftImage` with respect to `ivLineImage`
    NSLayoutConstraint *leftImageLeadingConstraint = [NSLayoutConstraint constraintWithItem:self.leftImage
        attribute:NSLayoutAttributeLeading
        relatedBy:NSLayoutRelationEqual
        toItem:self.ivLineImage
       attribute:NSLayoutAttributeLeading
        multiplier:1.0
      constant:-52.0];

    // Trailing constraint for `rightImage` with respect to `ivLineImage`
    NSLayoutConstraint *rightImageTrailingConstraint = [NSLayoutConstraint constraintWithItem:self.rightImage
      attribute:NSLayoutAttributeTrailing
    relatedBy:NSLayoutRelationEqual
    toItem:self.ivLineImage
    attribute:NSLayoutAttributeTrailing
        multiplier:1.0
    constant:52.0];

    // Add constraints to the view
    [self.view addConstraints:@[leftImageCenterYConstraint,
                                 rightImageCenterYConstraint,
                                 leftImageLeadingConstraint,
                                 rightImageTrailingConstraint]];
}
- (void)imageTapped:(UITapGestureRecognizer *)gestureRecognizer {
    NSLog(@"ivLineImage tapped");
    [self loadAds];
}
-(void)viewWillAppear:(BOOL)animated{
    [self updateCounter1];
    if (flagForViewWillAppear) {
        
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isProUser"]){
            [self loadBannerAdds];
           [self loadAds];
         
        } else {
            
            [self removeAds];
            
        }
    }
}
- (void)removeAds {

    [self loadAds];
    [self loadBannerAdds];
//    [self.VBannerView removeFromSuperview];
    self.VBannerView.hidden = YES;
}

- (void)loadAds {
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isProUser"]) {
        NSLog(@"User has purchased the ad-free version. Not loading interstitial ads.");
        return;
    }

    // Check if button has been clicked 4 times
    clickCount++;
    if (clickCount >= 4) {
        GADRequest *request = [GADRequest request];
        [GADInterstitialAd loadWithAdUnitID: interstitialID
                                    request:request
                          completionHandler:^(GADInterstitialAd *ad, NSError *error) {
            if (error) {
                NSLog(@"Failed to load interstitial ad with error: %@", [error localizedDescription]);
                return;
            }
            self.interstitial = ad;
            self.interstitial.fullScreenContentDelegate = self;
            
            // Reset clickCount for next set of clicks
            clickCount = 0;
            
            // Present the loaded interstitial ad
            [self.interstitial presentFromRootViewController:self];
        }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupArrays{
   
}
-(void)loadBannerAdds{
    self.VBannerView.adUnitID =bannerID;
    self.VBannerView.delegate = self;
    self.VBannerView.rootViewController = self;
    GADRequest *request = [GADRequest request];
    [self.VBannerView loadRequest:request];
}

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    NSLog(@"add displayed");

}
- (void)bannerView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(NSError *)error {

    NSLog(@"add not displayed");

}



-(void)checkCounter{
    if(singletonObject.clickCounter==noOfTotalCount){
        singletonObject.clickCounter=0;
        
        [self showVideoAd];
    }
    else{
        singletonObject.clickCounter=++singletonObject.clickCounter;;
    }
}
-(void)updateCounter1{
    if (singletonObject.clickCounter==noOfTotalCount) {
        singletonObject.clickCounter=0;
        [self showVideoAd];
    }
}
- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark- Initialization Delegate


- (void)unityAdsReady:(NSString *)placementId {

}

- (void)unityAdsDidStart:(NSString *)placementId {
    // Perform logic for a user starting an ad.
}

- (void)unityAdsDidFinish:(NSString *)placementId
withFinishState:(UnityAdsFinishState)state {
    // Perform logic for a user finishing an ad.
}

- (void)unityAdsDidError:(UnityAdsError)error withMessage:(NSString *)message {
    // Perform logic for a Unity Ads service error.
}

#pragma mark- Load and Show Delegate

- (void)loadVideoAd {
    [UnityAds load:@"video" loadDelegate:self];
}

- (void)showVideoAd {
    [UnityAds show:self placementId:@"video" showDelegate: self];
}

- (void)unityAdsAdLoaded:(NSString *)placementId{
    NSLog(@"Ad loaded for Ad Unit or Placement: %@", placementId);
    
}
- (void)unityAdsAdFailedToLoad:(NSString *)placementId
                     withError:(UnityAdsLoadError)error
                   withMessage:(NSString *)message{
    [self loadVideoAd];
}
- (void)unityAdsShowFailed:(NSString *)placementId
                 withError:(UnityAdsShowError)error
               withMessage:(NSString *)message{
    
}
- (void)unityAdsShowStart:(NSString *)placementId{
    
}
- (void)unityAdsShowClick:(NSString *)placementId{
    
}
- (void)unityAdsShowComplete:(NSString *)placementId
             withFinishState:(UnityAdsShowCompletionState)state{
    [self loadVideoAd];
}


@end
