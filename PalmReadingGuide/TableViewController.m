//
//  TableViewController.m
//  PalmReadingGuide
//
//  Created by Raza on 23/08/2024.
//  Copyright © 2024 MacBookPro. All rights reserved.
//

#import "TableViewController.h"
#import "ViewController.h"
#import "PurchaseViewController.h"
#import "GoogleMobileAds/GoogleMobileAds.h"
#import "Constant.h"
#import "PalmReadingModel.h"
#import "PalmistryTableViewCell.h"
#import "PageContentViewController.h"
#import "PagingViewController.h"
@interface TableViewController ()<GADFullScreenContentDelegate> {
    BOOL flagForViewWillAppear;
}
@property(nonatomic, strong) NSMutableArray<PalmReadingModel *> *palmReadingData;
@property(nonatomic, strong) GADInterstitialAd *interstitial;
@property(nonatomic, assign) BOOL hasPresentedPurchaseViewController;

@end
static NSInteger clickCount = 0;
@implementation TableViewController
@synthesize arrName;
- (void)viewDidLoad {
    [super viewDidLoad];
    flagForViewWillAppear = YES;
//    NSLog(@"arrName: %@", self.arrName);
//    arrName = [[NSMutableArray alloc]initWithObjects:@"Life line",@"Heart Line",@"Head Line",@"Fame Line",@"Fate Line",@"Travel Line",@"Money Line",@"Marriage Line", nil];
    
    // Initialize the model array with PalmistryModel objects.
   self.palmReadingData = [[NSMutableArray alloc] initWithObjects:
                          [[PalmReadingModel alloc] initWithTitle:@"Life line" imageName:@"lifeb.png" descriptionText:@"The life line represent your vitality and the length of your life . This is the most important line on your hand and will always be present. The life line is easiest to recognize and help to determine where is your other line are"],
                          [[PalmReadingModel alloc] initWithTitle:@"Heart Line" imageName:@"heartb.png" descriptionText:@"The heart deals with all the emotions and event that centered around love. Weather it be your ability to love or be loved. In general the stronger and deeper the line the stronger and wormer your devotions. The heart line is the horizontal line above the head line."],
                          [[PalmReadingModel alloc] initWithTitle:@"Head Line" imageName:@"headb.png" descriptionText:@"Begin the second most important line , the head line deals with your beliefs, your philosophy your attitude on and how you approach life.it is a representation of your mentality and intelligence because it is so important .The head line most be present on the palm."],
                          [[PalmReadingModel alloc] initWithTitle:@"Fate Line" imageName:@"fateb.png" descriptionText:@"The fate line also known as line of destiny, tells the effect of society and worlds events have upon your life(thing that comes to you from outside). The stronger and deeper the line, the more strongly fate control your life."],
                        [[PalmReadingModel alloc] initWithTitle:@"Travel Line" imageName:@"travelb.png" descriptionText:@"The travel line are major indication the trip taken throughout your life that have had a presenting impact on your life. The travel line start from the edge of the palm at the heel, opposite the thumb and extends horizontally."],
                        [[PalmReadingModel alloc] initWithTitle:@"Money Line" imageName:@"moneyb.png" descriptionText:@"The money line don’t indicate material wealth, so much as they influence, in some hands, skills in acquiring cash and how it can be don .NOTE :if you are looking for a lines  that influence success, material wealth and security look at the line pertaining  to fame, health and fate)"],
                        [[PalmReadingModel alloc] initWithTitle:@"Marriage Line" imageName:@"marriageb.png" descriptionText:@"Marriage is indicated by little line or lines that are located jus below the base of the little finger. several light lines in this area will indicate romances. the line that is strong and clear in this area indicate marriage. the closer the line  are to the base of the little finger, the later in life these marriages will be"],
                        [[PalmReadingModel alloc] initWithTitle:@"Fate Line" imageName:@"fateb.png" descriptionText:@"The fate line also known as line of destiny, tells the effect of society and worlds events have upon your life(thing that comes to you from outside). The stronger and deeper the line, the more strongly fate control your life. "],
                          nil];
      self.tableView.delegate = self;
       self.tableView.dataSource = self;
    self.tableView.backgroundColor = UIColor.clearColor;
    [self.tableView reloadData];

}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
       [self.tableView reloadData];
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!self.hasPresentedPurchaseViewController) {
        [self checkAndShowPurchaseViewController];
    }
}
- (void)checkAndShowPurchaseViewController {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL isProUser = [defaults boolForKey:@"isProUser"];
    BOOL hasShownPurchaseViewController = [defaults boolForKey:@"HasShownPurchaseViewController"];
    
    if (!isProUser && !hasShownPurchaseViewController) {
        // Show the PurchaseViewController
        [self presentPurchaseViewController];

        [defaults setBool:YES forKey:@"HasShownPurchaseViewController"];
        [defaults synchronize];

        self.hasPresentedPurchaseViewController = YES;
    }
}

- (void)presentPurchaseViewController {
    PurchaseViewController *purchaseViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PurchaseViewController"];
       
       if (purchaseViewController) {
           purchaseViewController.modalPresentationStyle = UIModalPresentationFullScreen;
           purchaseViewController.onPurchaseCompletion = ^{
               [self.tableView reloadData]; // Reload table view after purchase
           };
           [self presentViewController:purchaseViewController animated:YES completion:nil];
       } else {
           NSLog(@"Error: Could not instantiate PurchaseViewController.");
       }
}

- (IBAction)purchaseBtn:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
       PurchaseViewController *purchaseVC = [storyboard instantiateViewControllerWithIdentifier:@"PurchaseViewController"];
       
       if (purchaseVC) {
           // Present the PurchaseViewController modally
           purchaseVC.modalPresentationStyle = UIModalPresentationFullScreen;
           [self presentViewController:purchaseVC animated:YES completion:nil];
       } else {
           NSLog(@"Failed to instantiate PurchaseViewController.");
       }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.palmReadingData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    PalmistryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

     
    PalmReadingModel *model = self.palmReadingData[indexPath.row];

      
    
      cell.palmLable.text = model.title;
      cell.imageName.image = [UIImage imageNamed:model.imageName];
      cell.palmTextView.text = model.descriptionText;
      
      return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    PalmReadingModel *selectedModel = [self.palmReadingData objectAtIndex:indexPath.row];
        NSString *selectedLine = selectedModel.title;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
       PagingViewController *pagingViewController = [storyboard instantiateViewControllerWithIdentifier:@"PagingViewController"];
    pagingViewController.selectedLine = selectedLine;
    pagingViewController.selectedIndex = indexPath.row;
    pagingViewController.modalPresentationStyle = UIModalPresentationFullScreen;
       [self presentViewController:pagingViewController animated:YES completion:nil];
}

@end
