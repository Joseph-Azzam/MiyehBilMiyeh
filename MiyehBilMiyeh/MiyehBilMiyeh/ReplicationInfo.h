//
//  ReplicationInfo.h
//  MiyehBilMiyeh
//
//  Created by Joseph Azzam on 2014-01-04.
//  Copyright (c) 2014 Joseph Azzam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReplicationInfo : NSObject

@property BOOL Match;//is there a match?
@property (nonatomic,strong) NSString *MatchImage;//what is the match Image name?
@property (nonatomic,strong) NSMutableArray *CardsOnDeck;// Images of the cards on thew deck

@property int* Score; //Stores the variation of the score
@property int* NumberOfCards;// Stores the variation of the Number of cards
@property int* NumberOfSavedCards;// Stores the variation of the Number of cards




@end
