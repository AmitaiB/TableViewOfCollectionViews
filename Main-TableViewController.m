//
//  Main-TableViewController.m
//  TableViewOfCollectionViews
//
//  Created by Amitai Blickstein on 9/24/15.
//  Copyright © 2015 Amitai Blickstein, LLC. All rights reserved.
//
#define kShelvesCount 5
#import "Main-TableViewController.h"
#import "ShelfCollectionView.h"
#import "TableViewCell-thatHas-CollectionView-inside.h"
#import "HomeLibrary.h"

@interface Main_TableViewController ()

@property (nonatomic, strong) NSDictionary *bookcase;

@end

@implementation Main_TableViewController

static NSString * const reuseIdentifier = @"collectionViewCellID";

#pragma mark -
#pragma mark - === Lifecycle ==

-(NSDictionary *)bookcase {
    if (_bookcase == nil) {
        NSMutableArray *arrayOfCollectionViews = [NSMutableArray new];
        for (NSUInteger i = 0; i < kShelvesCount; i++) {
            [arrayOfCollectionViews addObject:[UICollectionView new]];
        }
        
        _bookcase = @{@"shelvesCount" : @(kShelvesCount),
                      @"width_cm"     : @55,
                      @"shelf ID#"    : @1,
                      @"shelves"      : arrayOfCollectionViews
                      };
    }
    return _bookcase;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self preCacheLibraryData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)preCacheLibraryData {
    HomeLibrary *library = [Library_RandomGenerator generateRandomLibrary];
        ///Select current book.
        ///Check if its thickness goes over the shelf-width.
        ///If no, add to array, increment Xposition, and repeat.
        ///If yes, increment shelves, reset Xposition to 0, and repeat.
        ///Stop when we run out of space(shelves) or books.
    
    CGFloat Xposition = 0.0f;
    CGFloat totalThicknessThisShelf = 55.0f;
    NSMutableArray *tempShelf = [NSMutableArray new];
    NSUInteger currentShelf = 0;
    
    for (Book *book in library.books) {
        if (Xposition + [book.thickness_cm floatValue] > totalThicknessThisShelf) {
            currentShelf += 1;
            Xposition = 0.0; //TODO: add error check for reaching end of shelf...
            [self.bookcase[@"shelves"][currentShelf] addObject:book];
        } else {
            Xposition += [book.thickness_cm floatValue];
            [self.bookcase[@"shelves"][currentShelf] addObject:book];
        }
    }
    
    tempShelf addObject:library.books[0]
    
    self.bookcase[@"shelves"][0];
}


#pragma mark -
#pragma mark - === Table view data source ===

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.bookcase[@"shelvesCount"] integerValue];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell_thatHas_CollectionView_inside *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];

    // Configure the cell...
    
    cell.shelfCollectionView = self.bookcase[@"shelves"][indexPath.row];
    cell.shelfCollectionView.delegate = self;
    
    
    return cell;
}

#pragma mark -
#pragma mark - === UICollectionView DataSource ===

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
}


@end
