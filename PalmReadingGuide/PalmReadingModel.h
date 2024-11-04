//
//  PalmReadingModel.h
//  PalmReadingGuide
//
//  Created by Raza on 26/08/2024.
//  Copyright © 2024 MacBookPro. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PalmReadingModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *descriptionText;


- (instancetype)initWithTitle:(NSString *)title
                    imageName:(NSString *)imageName
               descriptionText:(NSString *)descriptionText;

@end

NS_ASSUME_NONNULL_END
