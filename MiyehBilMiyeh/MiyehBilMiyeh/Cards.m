//
//  Cards.m
//  MiyehBilMiyeh
//
//  Created by Joseph Azzam on 2014-01-03.
//  Copyright (c) 2014 Joseph Azzam. All rights reserved.
//

#import "Cards.h"

@implementation Cards

@synthesize NbrOfCards;
@synthesize CardsImage;
@synthesize CardsTable;
@synthesize SavedCards;
@synthesize NbrOfSavedCards;
@synthesize score;


- (id)init
{
    self = [super init];
    if (self) {
        NbrOfCards = 52;
        CardsTable = malloc(sizeof(int) * NbrOfCards);
        
        for(int i = 0 ; i < 52 ; i++)
            CardsTable[i]=i;
        
        CardsImage = [[NSMutableArray alloc] init];
        
        [self AddCardsOfType: 'b'];
        [self AddCardsOfType: 's'];
        [self AddCardsOfType: 'r'];
        [self AddCardsOfType: 'd'];
        
        SavedCards = malloc(sizeof(int) * NbrOfCards);
        NbrOfSavedCards = 0;
        score = 0;
        
    }
    return self;
}

-(void)AddCardsOfType: (char) c //will load images names and values in a photo class instance
{
    Photo *photo;
    for(int i=1 ; i<=13 ; i++)
    {
        photo = [[Photo alloc]initWith:[NSString stringWithFormat:@"%d%c.png",i,c] Tag:i Type: c];
        [CardsImage addObject:photo];
    }
}


- (Photo*)StartCounting;
{
    Photo *photo = [[Photo alloc]init];
    
    if(NbrOfCards != 0)
    {
        int CurrentCard = arc4random_uniform(NbrOfCards-1);//choos a random nmber betwen 0 and 51
        int CurrentPhoto = CardsTable[CurrentCard]; // check the int table for the corresponding cards
        //example after discarding card  4 the position, for currentcard = 5, current photo is 6
        
        photo = (Photo*)[CardsImage objectAtIndex:CurrentPhoto];//??
        
        for(int i = CurrentCard ; i < NbrOfCards-1 ; i++) //remove used card from the Main Stack
            CardsTable[i]=CardsTable[i+1];
        
        NbrOfCards--;
        
        if(NbrOfCards == 0 && NbrOfSavedCards!=0) //if no more cards are avaible add the Saved Cards To the Main Stack
        {
            [self AddSavedCards];
            [self ClearSavedCards];
        }
    }
    
    return (photo);
}


- (void) SaveCards:(NSMutableArray*)MA //Save Stored Cards in a mutable array
{
    Photo *photo;
    for(int i=0 ; i<MA.count-1 ; i++) // count - 1 because the last card is the match card
    {
        photo = [[Photo alloc]init];
        photo = [MA objectAtIndex:i];//??
        
        int CardNumber = 0;//get the number that correspond to the card (between 0 and 51)
        switch (photo.type) {
            case 'b': CardNumber = [photo tag] -1 ;
                break;
            case 's': CardNumber = [photo tag] + 13 -1 ;
                break;
            case 'r': CardNumber = [photo tag] + 2*13 -1 ;
                break;
            case 'd': CardNumber = [photo tag] + 3*13 -1 ;
                break;
        }
        SavedCards[NbrOfSavedCards] = CardNumber;
        NbrOfSavedCards++;
    }
}

- (void) AddSavedCards //add Saved Cards to Main Cards Stack
{
    for(int i=0 ; i<NbrOfSavedCards ; i++)
        CardsTable[i] = SavedCards[i];
    NbrOfCards = NbrOfSavedCards;
}

- (void) ClearSavedCards
{
    NbrOfSavedCards=0;
}

@end
