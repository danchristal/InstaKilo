//
//  InstaCollectionViewController.h
//  InstaKilo
//
//  Created by Dan Christal on 2016-09-21.
//  Copyright © 2016 Dan Christal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InstaCollectionViewController : UICollectionViewController

-(NSMutableDictionary *)createSectionDictWith:(NSMutableArray *)photos andSubjects:(NSArray *)subjects;
-(NSMutableDictionary *)createSectionDictWith:(NSMutableArray *)photos andLocations:(NSArray *)locations;

@end
