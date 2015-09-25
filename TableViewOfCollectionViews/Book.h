//
//  Book.h
//  TableViewOfCollectionViews
//
//  Created by Amitai Blickstein on 9/24/15.
//  Copyright © 2015 Amitai Blickstein, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Book : NSObject

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *thickness_cm;

@end
