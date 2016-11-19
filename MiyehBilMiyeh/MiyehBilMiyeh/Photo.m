//
//  Photo.m
//  MiyehBilMiyeh
//
//  Created by Joseph Azzam on 2014-01-03.
//  Copyright (c) 2014 Joseph Azzam. All rights reserved.
//

#import "Photo.h"

@implementation Photo

@synthesize name;
@synthesize tag;
@synthesize type;

- (id)initWith:(NSString*) n Tag:(NSInteger) t  Type: (char) c
{
    self = [super init];
    if (self) {
        name = [[NSString alloc]initWithString:n];
        tag = t;
        type = c;
    }
    return self;
}

@end
