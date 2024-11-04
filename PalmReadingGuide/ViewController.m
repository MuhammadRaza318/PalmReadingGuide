

#import "ViewController.h"
#import "MainCollectionViewCell.h"
#import "PagingViewController.h"
#import "Constant.h"
#import "SingletonClass.h"
#import "PurchaseViewController.h"

@interface ViewController () <GADFullScreenContentDelegate> {
    NSMutableArray* lineTypeImageArray,*lineTypeDefinationArray,*titalArray;
    NSArray* tempArray;
    SingletonClass* singletonObject;
    NSString* title;
    BOOL flagForViewWillAppear;
}
@property(nonatomic, strong) GADInterstitialAd *interstitial;
@property(nonatomic, assign) BOOL hasPresentedPurchaseViewController;

@end
static NSInteger clickCount = 0;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    singletonObject=[SingletonClass SingletonClass];
    flagForViewWillAppear  = YES;

    [self setupArray];

    [self loadBannerAdds];

       NSInteger index = [titalArray indexOfObject:self.selectedLine];
       
    if (index != NSNotFound) {
   
        NSString *filteredTitle = titalArray[index];
        NSString *filteredDefination = lineTypeDefinationArray[index];
        NSString *filteredImageName = lineTypeImageArray[index];
        self.filteredTitles = @[filteredTitle];
        self.filteredDefinitions = @[filteredDefination];
        self.filteredImages = @[filteredImageName];         [self.myCollectionView reloadData];
    }

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
  //  [NSTimer scheduledTimerWithTimeInterval:120 target:self selector:@selector(loadBannerAdds) userInfo:nil repeats:YES];
    
    [self loadAds];
    [self loadBannerAdds];
    [self.VBannerView removeFromSuperview];
//    [UnityAds initialize:UnityID testMode:true initializationDelegate:self];
//    [UnityAds addDelegate:self];
//   [self loadVideoAd];
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
-(void)setupArray{
    //NSMutableArray *lifeArray=[[NSMutableArray alloc] init];
    
   
    titalArray=[[NSMutableArray alloc] init];

    
    titalArray=[@[@"Life line",@"Heart Line",@"Head Line",@"Fame Line",@"Fate Line",@"Travel Line",@"Money Line",@"Marriage Line"]mutableCopy];
    lineTypeImageArray=[[NSMutableArray alloc] initWithObjects:@"lifeb.png",@"heartb.png",@"headb.png", @"fameb.png",@"fateb.png",@"travelb.png",@"moneyb.png",@"marriageb.png",nil];
    lineTypeDefinationArray=[[NSMutableArray alloc] initWithObjects:
                             @"The life line represent your vitality and the length of your life . This is the most important line on your hand and will always be present. The life line is easiest to recognize and help to determine where is your other line are .Generally if the line swoops down to about an inch above the base of the palm it shows a life expectancy of about 70 year for woman and 60-65 for the men. This line begins on the edge of the palm , between the index finger and the thumb.it extends across the middle of the palm and wraps around the base of the thumb.",
                             @"The heart deals with all the emotions and event that centered around love. Weather it be your ability to love or be loved. In general the stronger and deeper the line the stronger and wormer your devotions. The heart line is the horizontal line above the head line. It begins either beneath either the index finger or middle finger and extends across to the edge of the palm on the side of the little finger.",
                             @"Begin the second most important line , the head line deals with your beliefs, your philosophy your attitude on and how you approach life.it is a representation of your mentality and intelligence because it is so important .The head line most be present on the palm. The head line begins just above the life line on side of the palm between the thumb and index finger and span horizontally across the palm.",
                             @"The line of the fame reinforce the line of the fate. sometime this line may be missing on the palm, in this case one future came must be looked for in other areas of the palm. The line of the fame influence the social reword of success. Those who lake this line may still be successful. But may will do without public acclaim. this line start at the base of hand, and moves its way up to bellow the ring finger, running parallel to the line of fate.",
                             @"The fate line also known as line of destiny, tells the effect of society and worlds events have upon your life(thing that comes to you from outside). The stronger and deeper the line, the more strongly fate control your life. If the line has many breaks or changes of direction, it means that you are prone to many changes in your life from circumstances you can’t control.",
                             @"The travel line are major indication the trip taken throughout your life that have had a presenting impact on your life. The travel line start from the edge of the palm at the heel, opposite the thumb and extends horizontally.",
                             @"The money line don’t indicate material wealth, so much as they influence, in some hands, skills in acquiring cash and how it can be don .NOTE :if you are looking for a lines  that influence success, material wealth and security look at the line pertaining  to fame, health and fate)",
                             @"Marriage is indicated by little line or lines that are located jus below the base of the little finger. several light lines in this area will indicate romances. the line that is strong and clear in this area indicate marriage. the closer the line  are to the base of the little finger, the later in life these marriages will be.",nil];
    
    
    
   
}

- (IBAction)backBtnPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)purchaseBtnPressed:(id)sender {
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
//    return [lineTypeDefinationArray count];
    return self.filteredTitles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static  NSString *identifier =@"MainCollectionViewCell";;
    BOOL nibMyCellloaded = NO;
    if(!nibMyCellloaded)
    {
        
        [collectionView registerNib:[UINib nibWithNibName:@"MainCollectionViewCell" bundle: nil] forCellWithReuseIdentifier:identifier];
        nibMyCellloaded = YES;
    }
    
    MainCollectionViewCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
//
//   NSLog(@"image array %lu", (unsigned long)[lineTypeImageArray count]);
//    NSLog(@"%lu line type ", (unsigned long)[lineTypeDefinationArray count]);
//    NSLog(@"%lu title aray", (unsigned long)[titalArray count]);
//    NSString* str=titalArray[indexPath.row];
//    NSLog(@"%@", str);
//    myCell.lbLineType.text=titalArray[indexPath.row];
//    myCell.ivLineImage.image=[UIImage imageNamed:lineTypeImageArray[indexPath.row]];
//    myCell.tvLineDetail.text=lineTypeDefinationArray[indexPath.row];
    //title=myCell.lbLineType.text;
   
    
    myCell.lbLineType.text = self.filteredTitles[indexPath.row];
      myCell.ivLineImage.image = [UIImage imageNamed:self.filteredImages[indexPath.row]];
      myCell.tvLineDetail.text = self.filteredDefinitions[indexPath.row];
      
      return myCell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self loadAds];
    PagingViewController* VC=[self.storyboard instantiateViewControllerWithIdentifier:@"PagingViewController"];
    [VC setModalPresentationStyle: UIModalPresentationFullScreen];
    VC.titleString = self.filteredTitles[indexPath.row];
    NSLog(@"%ld", (long)indexPath.row);
    [self presentViewController:VC animated:YES completion:nil];
    
}

- (CGSize)collectionView:(UICollectionView* )collectionView layout:(UICollectionViewLayout* )collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat screenhight = self.myCollectionView.frame.size.height;
    float cellWidth = self.view.frame.size.width;
    
    CGSize size = CGSizeMake(cellWidth, screenhight);
    return size;
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
        singletonObject.clickCounter = ++singletonObject.clickCounter;
    }
}
-(void)updateCounter1{
    if (singletonObject.clickCounter==noOfTotalCount) {
        singletonObject.clickCounter=0;
        [self showVideoAd];
    }
}
#pragma mark- Initialization Delegate
- (void)initializationComplete {
    // Perform logic for ads initialization succeeded.
}

- (void)initializationFailed:(UnityAdsInitializationError)error withMessage:(NSString *)message {
    // Perform logic for ads initialization failed.
}

// Implement the ads listener callback methods:
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
