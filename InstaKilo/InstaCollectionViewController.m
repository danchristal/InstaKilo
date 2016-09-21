//
//  InstaCollectionViewController.m
//  InstaKilo
//
//  Created by Dan Christal on 2016-09-21.
//  Copyright © 2016 Dan Christal. All rights reserved.
//

#import "InstaCollectionViewController.h"
#import "InstaCollectionViewCell.h"
#import "Photo.h"
#import "InstaCollectionReusableView.h"

@interface InstaCollectionViewController ()

@property (nonatomic, strong) NSMutableArray<Photo *> *images;
@property (nonatomic, strong) NSArray<NSString *> *subjects;
@property (nonatomic, strong) NSArray<NSString *> *locations;
@property (nonatomic, strong) NSMutableDictionary *sectionItemsDict;
@property (nonatomic, strong) NSMutableArray<Photo *> *sectionItems;
@property (nonatomic, strong) NSString *sectionName;

@property BOOL SoryBySubject;

@end    

@implementation InstaCollectionViewController

//static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    // [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    
    Photo *image1 = [[Photo alloc] initWithPhoto:[UIImage imageNamed:@"Iceland1"] Location:@"Iceland" AndSubject:@"Iceberg"];
    Photo *image2 = [[Photo alloc] initWithPhoto:[UIImage imageNamed:@"Iceland2"] Location:@"Iceland" AndSubject:@"Moss"];
    Photo *image3 = [[Photo alloc] initWithPhoto:[UIImage imageNamed:@"Iceland3"] Location:@"Iceland" AndSubject:@"Rocks"];
    Photo *image4 = [[Photo alloc] initWithPhoto:[UIImage imageNamed:@"Iceland4"] Location:@"Iceland" AndSubject:@"Waterfall"];
    Photo *image5 = [[Photo alloc] initWithPhoto:[UIImage imageNamed:@"Iceland5"] Location:@"Iceland" AndSubject:@"Lava"];
    Photo *image6 = [[Photo alloc] initWithPhoto:[UIImage imageNamed:@"Iceland6"] Location:@"Iceland" AndSubject:@"Hot Springs"];
    Photo *image7 = [[Photo alloc] initWithPhoto:[UIImage imageNamed:@"Iceland7"] Location:@"Iceland" AndSubject:@"Church"];
    Photo *image8 = [[Photo alloc] initWithPhoto:[UIImage imageNamed:@"Iceland8"] Location:@"Iceland" AndSubject:@"Puffin"];
    Photo *image9 = [[Photo alloc] initWithPhoto:[UIImage imageNamed:@"Iceland9"] Location:@"Iceland" AndSubject:@"Waterfall"];

    self.images = [[NSMutableArray alloc] init];
    
    [self.images addObject:image1];
    [self.images addObject:image2];
    [self.images addObject:image3];
    [self.images addObject:image4];
    [self.images addObject:image5];
    [self.images addObject:image6];
    [self.images addObject:image7];
    [self.images addObject:image8];
    [self.images addObject:image9];

    //get array of unique subjects by way of creating a set
    self.subjects = [[NSArray alloc] init];
    NSMutableSet *subjectSet = [[NSMutableSet alloc] init];
    for (Photo* photo in self.images) {
        [subjectSet addObject:photo.subject];
    }
    self.subjects = [subjectSet allObjects];
    
    //get array of unique locations by way of creating a set
    self.locations = [[NSArray alloc] init];
    NSMutableSet *locationSet = [[NSMutableSet alloc] init];
    for (Photo* photo in self.images) {
        [locationSet addObject:photo.location];
    }
    self.locations = [locationSet allObjects];
    
    
    self.sectionItems = [[NSMutableArray alloc] init];
    self.sectionName = [[NSString alloc] init];
    
    self.sectionItemsDict = [self createSectionDictWith:self.images andSubjects:self.subjects];
    self.SoryBySubject = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
   
    NSInteger sectionCount = (self.SoryBySubject) ? [self.subjects count] : [self.locations count];
    
    return sectionCount;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    self.sectionName = (self.SoryBySubject) ? self.subjects[section] : self.locations[section];
    
    self.sectionItems = [self.sectionItemsDict valueForKey:self.sectionName];
    
    return [self.sectionItems count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    InstaCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"instaCell" forIndexPath:indexPath];
    
    // Configure the cell
    self.sectionName = (self.SoryBySubject) ? self.subjects[indexPath.section] : self.locations[indexPath.section];
    self.sectionItems = [self.sectionItemsDict valueForKey:self.sectionName];
    
    Photo *cellPhoto = self.sectionItems[indexPath.row];
    cell.imageView.image = cellPhoto.photo;
    
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    InstaCollectionReusableView *sectionHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"instaSection" forIndexPath:indexPath];
    
    sectionHeaderView.titleLabel.text = (self.SoryBySubject) ? self.subjects[indexPath.section] : self.locations[indexPath.section];
    
    return sectionHeaderView;
}

- (IBAction)playButtonAction:(UIBarButtonItem *)sender {
    
    if(self.SoryBySubject){
        self.sectionItemsDict = [self createSectionDictWith:self.images andLocations:self.locations];
        self.SoryBySubject = NO;
    } else{
        self.sectionItemsDict = [self createSectionDictWith:self.images andSubjects:self.subjects];
        self.SoryBySubject = YES;
    }
    
    
    
    [self.collectionView reloadData];

    
}

-(NSMutableDictionary *)createSectionDictWith:(NSMutableArray *)photos andSubjects:(NSArray *)subjects{
    
    NSMutableDictionary *sectionItems = [[NSMutableDictionary alloc] init];
    
    for(int i = 0; i< [subjects count]; i++) {
        
        NSMutableArray *sectionPhotos = [[NSMutableArray alloc] init];
        
        for (Photo *photo in photos) {
            if([photo.subject isEqualToString:subjects[i]]){
                [sectionPhotos addObject:photo];
            }
        }
        [sectionItems setValue:sectionPhotos forKey:subjects[i]];
    }
    return sectionItems;
}

-(NSMutableDictionary *)createSectionDictWith:(NSMutableArray *)photos andLocations:(NSArray *)locations{
    
    NSMutableDictionary *sectionItems = [[NSMutableDictionary alloc] init];
    
    for(int i = 0; i< [locations count]; i++) {
        
        NSMutableArray *sectionPhotos = [[NSMutableArray alloc] init];
        
        for (Photo *photo in photos) {
            if([photo.location isEqualToString:locations[i]]){
                [sectionPhotos addObject:photo];
            }
        }
        [sectionItems setValue:sectionPhotos forKey:locations[i]];
    }
    return sectionItems;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
