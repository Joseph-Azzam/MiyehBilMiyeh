//
//  Photo.h
//  MiyehBilMiyeh
//
//  Created by Joseph Azzam on 2014-01-03.
//  Copyright (c) 2014 Joseph Azzam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject

@property (nonatomic, strong) NSString *name;
@property NSInteger tag;
@property char type;

- (id)initWith:(NSString*) n Tag:(NSInteger) t  Type: (char) c;

@end
