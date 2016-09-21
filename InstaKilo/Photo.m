//
//  Photo.m
//  InstaKilo
//
//  Created by Dan Christal on 2016-09-21.
//  Copyright © 2016 Dan Christal. All rights reserved.
//

#import "Photo.h"

@implementation Photo

-(instancetype)initWithPhoto:(UIImage *)photo Location:(NSString *)location AndSubject:(NSString *)subject{
    
    
    self = [super init];
            
    if(self){
        _photo = photo;
        _location = location;
        _subject = subject;
    }
    return self;
}

@end
