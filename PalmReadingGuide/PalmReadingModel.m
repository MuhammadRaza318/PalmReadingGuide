//
//  PalmReadingModel.m
//  PalmReadingGuide
//
//  Created by Raza on 26/08/2024.
//  Copyright © 2024 MacBookPro. All rights reserved.
//

#import "PalmReadingModel.h"

@interface PalmReadingModel ()

@end

@implementation PalmReadingModel

- (instancetype)initWithTitle:(NSString *)title
                    imageName:(NSString *)imageName
               descriptionText:(NSString *)descriptionText {
    self = [super init];
    if (self) {
        _title = title;
        _imageName = imageName;
        _descriptionText = descriptionText;
    }
    return self;
}



@end
