//
//  Library-RandomGenerator.m
//  TableViewOfCollectionViews
//
//  Created by Amitai Blickstein on 9/24/15.
//  Copyright © 2015 Amitai Blickstein, LLC. All rights reserved.
//
#define ARC4RANDOM_MAX 0x100000000
#import "Library-RandomGenerator.h"
#import "HomeLibrary.h"
#import "Book.h"

@implementation Library_RandomGenerator

+(HomeLibrary *)generateRandomLibrary {
    
    NSUInteger booksCount = ceilf((arc4random() % 50) / 50) + 30;
    NSLog(@"Books count: %lu", booksCount);
    
    HomeLibrary *defaultLibrary = [HomeLibrary new];
    
    NSMutableArray *books = [NSMutableArray arrayWithCapacity:booksCount];
    
    for (NSUInteger i = 0; i < books.count; i++) {
        Book *book = [Book new];
        book.color = [self randomColor];
        book.title = [self randomTitle];
        book.thickness_cm = [self randomThickness];
        [books addObject:book];
    }
    
    defaultLibrary.books = [books copy];
    
    return defaultLibrary;
}

+(NSString*)randomTitle {
    NSUInteger titleLength = ceilf([Library_RandomGenerator randomFloatBetweenNumber:1 andNumber:3]);
    NSMutableArray *tempTitle = [NSMutableArray arrayWithObject:@"The"];
    for (NSUInteger i = 0; i < titleLength; i++) {
        [tempTitle addObject:@" "];
        [tempTitle addObject:[Library_RandomGenerator randomWord]];
    }
    [tempTitle insertObject:@"of the" atIndex:2];
    NSString *workingTitle = [tempTitle componentsJoinedByString:@" "];
    return workingTitle;
}

+(NSString*)randomWord {
    NSUInteger wordLength = ceilf([Library_RandomGenerator randomFloatBetweenNumber:3 andNumber:10]);
    NSMutableArray *word = [NSMutableArray new];
    NSString *alphabet = @"abcdefghijklmnopqrstuvwxyz";
    
    for (NSUInteger i = 0; i < wordLength; i++) {
        NSUInteger idx = roundf([Library_RandomGenerator randomFloatBetweenNumber:0 andNumber:alphabet.length]);
        [word addObject:[alphabet substringWithRange:NSMakeRange(idx, 1)]];
    }
    return [word copy];
}

+(UIColor*)randomColor {
    CGFloat redValue   = (arc4random() % 255) / 255.0f;
    CGFloat blueValue  = (arc4random() % 255) / 255.0f;
    CGFloat greenValue = (arc4random() % 255) / 255.0f;

    return [UIColor colorWithRed:redValue green:greenValue blue:blueValue alpha:1.0];
}

+(NSNumber*)randomThickness {
    return @([Library_RandomGenerator randomFloatBetweenNumber:10.0 andNumber:20.0]);
}

+(CGFloat)randomFloatBetweenNumber:(CGFloat)minRange andNumber:(CGFloat)maxRange
{
    return ((float)arc4random() / ARC4RANDOM_MAX) * (maxRange - minRange);
}

@end
