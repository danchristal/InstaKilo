//
//  Photo.h
//  InstaKilo
//
//  Created by Dan Christal on 2016-09-21.
//  Copyright © 2016 Dan Christal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface Photo : NSObject
@property (nonatomic, strong) UIImage *photo;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *subject;

-(instancetype)initWithPhoto:(UIImage *)photo Location:(NSString *)location AndSubject:(NSString *)subject;

@end
