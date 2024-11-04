//
//  PalmistryTableViewCell.h
//  PalmReadingGuide
//
//  Created by Raza on 23/08/2024.
//  Copyright © 2024 MacBookPro. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PalmistryTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *palmLable;
@property (strong, nonatomic) IBOutlet UIImageView *imageName;
@property (strong, nonatomic) IBOutlet UITextView *palmTextView;
@property (strong, nonatomic) IBOutlet UIImageView *lineImage;

- (instancetype)initWithTitle:(NSString *)palmLable imageName:(NSString *)imageName palmTextView:(NSString *)descriptionText;

@end

NS_ASSUME_NONNULL_END
