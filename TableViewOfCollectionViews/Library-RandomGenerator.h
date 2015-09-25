//
//  Library-RandomGenerator.h
//  TableViewOfCollectionViews
//
//  Created by Amitai Blickstein on 9/24/15.
//  Copyright © 2015 Amitai Blickstein, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HomeLibrary;
@interface Library_RandomGenerator : NSObject

+(HomeLibrary*)generateRandomLibrary;

+(NSString*)gibberishGenerator;

@end
