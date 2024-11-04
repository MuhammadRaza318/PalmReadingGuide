//
//  PagingViewController.m
//  PalmReadingGuide
//
//  Created by MacBookPro on 9/21/17.
//  Copyright © 2017 MacBookPro. All rights reserved.
//

#import "PagingViewController.h"
#import "PageContentViewController.h"
#import "TableViewController.h"

@interface PagingViewController (){
    NSMutableDictionary* ImageDictionry,* textDictionery;
    NSMutableArray *imageArray,*textArray;
    
    
}

@end

@implementation PagingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setuArrays];
    self.titleString = self.selectedLine;
    
    imageArray=[[NSMutableArray alloc] init];
    textArray=[[NSMutableArray alloc] init];
    
    imageArray=[ImageDictionry objectForKey:[NSString stringWithFormat:@"%ld", (long)_selectedIndex]];
    
    textArray=[textDictionery objectForKey:[NSString stringWithFormat:@"%ld", (long)_selectedIndex]];
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [textArray count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}



- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([textArray count] == 0) || (index >= [textArray count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.imageFile = imageArray[index];
    pageContentViewController.detailText = textArray[index];
    pageContentViewController.pageIndex = index;
    pageContentViewController.titleText= self.titleString;
    
    pageContentViewController.totalNumberOfImages = [imageArray count];
    return pageContentViewController;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [textArray count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController{
    return 0;
}

-(void)setuArrays{
    ImageDictionry=[[NSMutableDictionary alloc] init];
    textDictionery=[[NSMutableDictionary alloc] init];
    
    NSArray* lifeImageArray = @[@"life1.png",@"life2.png",@"life3.png",@"life4.png",@"life5.png",@"life6.png",@"life7.png",@"life8.png",@"life9.png",@"life10.png",@"life11.png",@"life12.png",];
    
    NSArray* lifeTextArray = @[@"The life line is long and deep ,then this represent a long life full off vitality. A short line, if strong and deep ,also show great vitality in your life and ability to overcome health problems. However if the line is short and shallow, then life may have the tendency to control by others.",
                               
                               @"Extra line often noted as vitality lines. If your life line is doubled, or even tripled, then this showed a great vitality in your life and positive force around you.",
                               @"A swooping semicircle line around the base of the thumb showed great strength and enthusiasm, as well as an improved love life.",@"If the line is straight and stick close to the side of your palm, then this is a sign of limited exploration of love and a very caution nature.",
                               @"The type of line is extent to the middle of the palm , away from the thumb toward base of hand. This represent a life that consist a lot of travelling.",
                               @"A chained line indicates various health problem, both physical and emotional. Many people with allergies have such a line as well",
                               @"A donut representation of hospitalization as a result of some sort of accident.",
                               @"A break representation of sudden change in life style, an accident or an illness.",
                               @" Line crossing through the life line indicate either worries or danger, however star indicate some sort of crisis.",
                               @"A square on the line indicate protection at a time it is needed.It may also mark a turning point in your life.",
                               @" Line extending up and above the life line show the ability to recover from situations.", @"Line extending bellow the life line show a habit of wasting energy."];
    
    
    
    
    NSArray* heartImageArray = @[@"heart1.png",@"heart2.png",@"heart3.png",@"heart4.png",@"heart5.png",@"heart6.png",@"heart7.png",@"heart8.png",@"heart9.png",@"heart10.png",@"heart11.png",];
    NSArray*heartTextArray =  @[@"A normal and content love life is represented by the line that starter beneath the index finger.",
                                @"A selfish and materialistic look at love is characteristic to those whose heart line start bellow the middle finger. A single disregard to the true meaning of love and its responsibilities are indicated by the line that start between the middle and index finger, the person tends to easily give their heart away",
                                @"If the line extends boldly across the palm , then the person tends to look for those whose status rise above their own, and has great respect for them ,If such line is very straight and parallel to the head line ,then it show strong emotional control.",
                                @"If the line is long and curved(especially upwards),then the person has pleasant ,romantic nature ,great warmth in their action .they may also tends to give all of themselves to love ,no matter the cost .",
                                @"A short line show a lack of interest in the affair of love and affection .however if short line is also very strong and deep ,then the person’s affections tends to be quite stable .",@"A wavy line as well as broken or chained line , represents many love interests, but non of them very  serious .",
                                @"A star on the line represents happiness in your marriage .",
                                @"A donut on the line represents a time of depression.",
                                @"Emotional loss may be symbolized by broken line ,as well as a line with small lines crossing through it .Such losses include death and the end of relationships.",
                                @"happiness in love is shown by small lines that extends upward from the heart line. However if the line extends downwards , then it symbolizes a disappointment ",
                                @"Protection from loved one is indicated by doubled line"];
    NSArray* headImageArray=@[@"head1.png",@"head2.png",@"head3.png",@"head4.png",@"head5.png",@"head6.png",@"head7.png",@"head8.png",@"head9.png",@"head10.png"];
    
    NSArray* headTextArray=
    @[@"If your head line and life line are joined at the beginning, this indicates that your strong sense of mind generally rules over your body .you also lock at childhood with a cautious and fearful outlook. separated lines show a love for adventure and enthusiasm for life.",
      @"A deep long line stretching across the palm indicate a logical and direct way of thinking . The straighter the line the more realistic the thinking, and the deeper the line the better the memory. if the line is short however, it tends to indicate the limited mental aims and the shift towards (physical)thinking rather than reflection.",
      @"If the line is away then you tends to have short attention span ,with a lack of deep thinking ,however this does not affect your intellect.",
      @"If the line is short and curved upwards ,then you tends to have a short attention span also known as scatterbrain. A long line that curves upward represents more of a retentive memory. however if the line swoops down toward the heel , the person tends to be imaginative and ",
      @"double line shows strong mental abilities.",
      @"A donut or a cross through the head line represents a mental crisis.",
      @"A broken line shows a distinct changes in your way of thinking , sometime even characteristic of a nervous breakdown.",
      @"A star on your line indicate a significate mental achievement .",
      @"Cross through the line indicate major decision in your life",
      @"The space created between the life line and the head line is known as the angle of luck. The greater the space the greater your luck. the smaller the space ,the less luck seems to stand by your side ."];
    
    
    NSArray* fameImageArray=@[@"fame1.png",@"fame2.png",@"fame3.png",@"fame4.png",@"fame5.png"];
    
    NSArray* fameTextArray=
    @[@"A strong and clear line of fame indicate both distinction and satisfaction with your life work",
      @"if the line travel to the ring finger, this indicate fame in the arts",
      @"Starting at the head line running through the heart line ,indicate hard work and success late in life. But a fork ending the line indicates that success may be dubious in value.",
      @"If the line end beneath the ring finger in a star or a triangle, spectacular success await in the fine arts field. A square in the same area indicates you to be a kindly patron.",
      @"If the line appears broken ,this is an indicator of the ups and downs of your social recognition.",];
    
    NSArray* fateImageArray=@[@"fate1.png",@"fate2.png",@"fate3.png",@"fate4.png",@"fate5.png",@"fate6.png",@"fate7.png",];
    
    NSArray* fateTextArray=
    @[@"If your fate line start clearly and at the wrist but join the life line, this indicate a point where you have to surrender your own interest to those of other people .If the fate line separate again from the life line ,it indicates that you are now in control of your life again.",
      @"If the fate line starts on the base of your thumb inside your life line curve, It indicate a point where family or close friend are supportive of you.",
      @"If the fate line starts at the base of your palm, this indicate that your life will fined its  way into the public eye. You may rise from obscurity to be a politician, or an entertainer.",
      @"If a break occur in your fate line at the head line and goes on ,this indicates that you will successfully change your job in your middle ear.",
      @"A star at the end of fate line indicates that destiny has marked you for success . If the line with a star ends under the index finger, you will fined fame in non creative field. if the stared line ends under the middle finger ,you will sea success after ten years of hard work. If the line ends under the ring finger, you will fined success in creative arts field.",
      @"Island and break in your fate line show period where your life will not follow so smoothly. Fate has some trouble in store for you.",
      @"Lines that cross the fate line foreshadow times where you destiny is opposed by others"];
    
    NSArray* travelImageArray=@[@"travel1.png",@"travel2.png",@"travel3.png",@"travel4.png",@"travel5.png",];
    NSArray* travelTextArray=@[@"If the travel line intersect with the life line ,then a trip will be made under  circumstances of health or your health will be affected by a trip.",
                               @"Lines that cross the travel lines foreshadow danger, or problem with travel.",
                               @"if a square appears on the lines ,It is a sign of protection in your travel.",
                               @"Breaks in the lines indicates a delay in your travels.",
                               @"if the travel line intersects the fate line, this is an indication that your travel will present a life changing experience."];
    NSArray* moneyImageArray=@[@"money1.png",@"money2.png",@"money3.png",@"money4.png"];
    
    NSArray* monytextArray=@[@"A line that runs from the base of the thumb, to bellow the index finger ending in a star, indicates a natural talent for money making",
                             @"A line that travel from the base of the thumb to the little finger indicates wealth acquired through inheritance or family allowance.",
                             @"A line running from the base of the thumb to bellow the middle finger indicates money made in business.",
                             @"A line from the head line that runs to the ring finger ,cutting through the fame line, indicates money acquired through luck and by surprise."];
    NSArray* marriageImageArray=@[@"marriage1.png",@"marriage2.png",@"marriage3.png",@"marriage4.png",@"marriage5.png",@"marriage6.png"];
    
    NSArray* marriagTextArray=@[@"Lines that meets the marriage line ,but don’t cross it, indicate children that will be born  into the marriage",
                                @"A line with a fork at the start, towards the back of the hands ,indicate a long engagement.",
                                @"A fork on the end of the marriage line ,towards the palm ,indicates separation (with or without divorce)",
                                @"A line that cut off the marriage line at the end indicates the end of marriage in death or divorce.",
                                @"The overlapping of lines in this manner indicates an affairs, while one is married.",
                                @"if the marriage line breaks ,then resume with an overlap, this indicates a separation ,and later ,reunion",];
    
    
    
    
    
    
    [ImageDictionry setObject:lifeImageArray forKey:@"0"];
    [textDictionery setObject:lifeTextArray forKey:@"0"];
    
    [ImageDictionry setObject:heartImageArray forKey:@"1"];
    [textDictionery setObject:heartTextArray forKey:@"1"];
    
    [ImageDictionry setObject:headImageArray forKey:@"2"];
    [textDictionery setObject:headTextArray forKey:@"2"];
    
    [ImageDictionry setObject:fameImageArray forKey:@"3"];
    [textDictionery setObject:fameTextArray forKey:@"3"];
    
    [ImageDictionry setObject:fateImageArray forKey:@"4"];
    [textDictionery setObject:fateTextArray forKey:@"4"];
    
    [ImageDictionry setObject:travelImageArray forKey:@"5"];
    [textDictionery setObject:travelTextArray forKey:@"5"];
    
    [ImageDictionry setObject:moneyImageArray forKey:@"6"];
    [textDictionery setObject:monytextArray forKey:@"6"];
    
    [ImageDictionry setObject:marriageImageArray forKey:@"7"];
    [textDictionery setObject:marriagTextArray forKey:@"7"];
    
}

@end
