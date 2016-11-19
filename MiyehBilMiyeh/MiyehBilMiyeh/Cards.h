//
//  Cards.h
//  MiyehBilMiyeh
//
//  Created by Joseph Azzam on 2014-01-03.
//  Copyright (c) 2014 Joseph Azzam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

@interface Cards : NSObject

@property int NbrOfCards;
@property int *CardsTable;
@property (readonly,strong,nonatomic) NSMutableArray *CardsImage;
@property int *SavedCards;
@property int NbrOfSavedCards;
@property int score;

- (Photo*)StartCounting;
- (void) SaveCards:(NSMutableArray*)MA;
- (void) ClearSavedCards;

@end
