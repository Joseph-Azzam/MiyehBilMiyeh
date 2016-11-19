//
//  ReplicationInfo.m
//  MiyehBilMiyeh
//
//  Created by Joseph Azzam on 2014-01-04.
//  Copyright (c) 2014 Joseph Azzam. All rights reserved.
//

#import "ReplicationInfo.h"

@implementation ReplicationInfo

@synthesize Match;
@synthesize MatchImage;
@synthesize CardsOnDeck;

@synthesize Score;
@synthesize NumberOfCards;
@synthesize NumberOfSavedCards;


- (id)init
{
    self = [super init];
    if (self) {
        Match = NO;
        MatchImage = [[NSString alloc]init];
        CardsOnDeck = [[NSMutableArray alloc]init];
        Score = malloc(sizeof(int) * 13);
        NumberOfCards = malloc(sizeof(int) * 13);
        NumberOfSavedCards = malloc(sizeof(int) * 13);
    }
    return self;
}

@end
