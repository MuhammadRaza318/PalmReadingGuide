//
//  MainCollectionViewCell.h
//  PalmReadingGuide
//
//  Created by MacBookPro on 9/21/17.
//  Copyright © 2017 MacBookPro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbLineType;
@property (weak, nonatomic) IBOutlet UIImageView *ivLineImage;
@property (weak, nonatomic) IBOutlet UITextView *tvLineDetail;

@end
