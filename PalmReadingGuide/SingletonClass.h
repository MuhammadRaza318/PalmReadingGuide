//
//  SingletonClass.h
//  E_Sign
//
//  Created by Muhammad Luqman on 10/4/16.
//  Copyright © 2016 Muhammad Luqman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface SingletonClass : NSObject

#define SINGLETON_FOR_CLASS(SingletonClass)
+ (id)SingletonClass;

@property (nonatomic, strong) NSMutableArray *uniqueArray;
@property (nonatomic, strong) NSMutableArray *clickCounterArray;
@property NSString* selectedSeason;
@property int clickCounter;
@property int videoCounter;
@end
