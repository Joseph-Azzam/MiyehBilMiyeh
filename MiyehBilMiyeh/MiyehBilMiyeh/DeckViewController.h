//
//  DeckViewController.h
//  MiyehBilMiyeh
//
//  Created by Joseph Azzam on 2014-01-03.
//  Copyright (c) 2014 Joseph Azzam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cards.h"
#import "Photo.h"
#import "ReplicationInfo.h"
#import "ScoreViewController.h"
#import "CardsAnimation.h"
#import <math.h>

const int MAX = 100;//Maximum Score Value

@interface DeckViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *BackStill;
@property (weak, nonatomic) IBOutlet UIImageView *BackAnimated;
@property (weak, nonatomic) IBOutlet UIImageView *MatchCard;
@property (weak, nonatomic) IBOutlet UILabel *Score;
@property (weak, nonatomic) IBOutlet UIImageView *SavedCardsStack;
@property (weak, nonatomic) IBOutlet UILabel *NbrOfCards;

//View Controller Properties
@property BOOL Animated;
@property BOOL WAIT;
@property (nonatomic,strong) Cards *CD;
@property (nonatomic,strong) CardsAnimation *ANIM;
//Methods

- (IBAction)StartButtonPressed:(id)sender;
- (void)ClearDeck;
- (void) ShowScore;
- (void)ResetView;
- (void) CheckStack;
@end
