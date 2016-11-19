//
//  CardsAnimation.m
//  MiyehBilMiyeh
//
//  Created by Joseph Azzam on 2014-01-05.
//  Copyright (c) 2014 Joseph Azzam. All rights reserved.
//

// View Tags list
// 1->13 - Deck Cards
// 14 - Match Card
// 15 - Back Still Image
// 16 - Back Animated Image
// 17 - Saved Images Stack
// 18 - Score
// 19 - Nbre Of Cards
// 0 everything else



#import "CardsAnimation.h"

@implementation CardsAnimation

@synthesize isAnimating;
@synthesize UIV;
@synthesize Speed;

//Not Properties
NSTimer *AnimationTimer;
ReplicationInfo *RI;

// Interface
UIImageView *MatchCard ;
UIImageView *BackStillImage ;
UIImageView *BackAnimatedImage ;
UIImageView *SavedImagesStack ;
UILabel * Score ;
UILabel * NbrOfCards ;

- (id)init
{
    self = [super init];
    if (self)
    {
        Speed = 2048;
        isAnimating = NO;
    }
    return self;
}

- (void) SetView
{
    MatchCard = (UIImageView *)[UIV viewWithTag:14];
    BackStillImage = (UIImageView *)[UIV viewWithTag:15];
    BackAnimatedImage = (UIImageView *)[UIV viewWithTag:16];
    SavedImagesStack = (UIImageView *)[UIV viewWithTag:17];
    Score = (UILabel *)[UIV viewWithTag:18];
    NbrOfCards= (UILabel *)[UIV viewWithTag:19];
}

- (void) AnimateWithReplicationInfo: (ReplicationInfo *) ReplInf InView: (UIView *) CurrentView
{
    isAnimating =YES;
    RI = ReplInf;
    UIV = CurrentView;
    [self SetView];
    [self Animation];
}

-(void)Animation //set the timer for the animation
{
    float duration = [self DurationTo:(UIImageView *)[UIV viewWithTag:3] withSpeedOf:Speed];
    
    AnimationTimer = [NSTimer scheduledTimerWithTimeInterval:duration+0.15
                                                      target:self
                                                    selector:@selector(Animate)
                                                    userInfo:nil repeats:YES];//the timer is on loop untill all the cards are displayed
}

- (void) Animate //take the saved cards stored in StartButtonPress and animate them one after one
{
    static int i = 1;
    if(i>RI.CardsOnDeck.count)
    {
        [AnimationTimer invalidate];
        AnimationTimer = nil;
        i=1;
        isAnimating = NO;
    }
    else
    {
        float duration = [self DurationTo:(UIImageView *)[UIV viewWithTag:i] withSpeedOf:Speed];//animate card at index i
        [self AnimateFrom: BackAnimatedImage To:(UIImageView *)[UIV viewWithTag:i] withDuration: duration tag:i];
        [self CheckStack:i-1];//Will assign appropriate image depending on number of saved cards
        i++;
        
                
    }
}

- (float) DurationTo: (id) dst withSpeedOf: (float) speed//calculate the distance from source to destination
{
    
    CGRect source = [BackStillImage frame];
    CGRect destination = [dst frame];
    float distance = 0;
    float duration = 0.22;
    float VectorX = destination.origin.x - source.origin.x;
    float VectorY = destination.origin.y - source.origin.y;
    distance = sqrt( pow(VectorX,2) + pow(VectorY,2));
    duration = 0.4*sqrt(distance/speed);//v=d/t, v is in points per seconds;
    return(duration);
}

- (IBAction)AnimateFrom:(id)src To:(id) dst withDuration: (float) d tag:(int) i
{
    
    [NSTimer scheduledTimerWithTimeInterval:d+0.1
                                     target:self
                                   selector:@selector(AnimationEnd)
                                   userInfo:nil
                                    repeats:NO];
    
    [UIView animateWithDuration:d animations:^//animate card from source to destination
     {
         CGRect destination = [dst frame];
         [src setFrame:destination];
     }completion:^(BOOL finished)
    {
         NbrOfCards.text = [NSString stringWithFormat:@"%i", RI.NumberOfCards[i-1]];//change the label of number of cards in the Main Stack
         Score.text = [NSString stringWithFormat:@"%i%c", RI.Score[i-1],'%'];//change the label of the score
         //reveal card
         UIImageView *IV = [[UIImageView alloc]init];
         IV = (UIImageView *)[UIV viewWithTag:i];

        UIImage *image = [[UIImage alloc]init];
        
        @try {
         image = [UIImage imageNamed:[RI.CardsOnDeck objectAtIndex:i-1]];
        }
        @catch (NSException *exception) {}
        
         [IV setImage:image];
        
        if(i>=RI.CardsOnDeck.count)
        {
            if(RI.Match)
            {
                [MatchCard setImage:[UIImage imageNamed:RI.MatchImage]];
                RI.Match = NO;
            }

        }
     }];
}


- (void) AnimationEnd //return the animated back image to original position so i can be used again
{
    CGRect destination = [BackStillImage frame];
    [BackAnimatedImage setFrame:destination];
}

-(void) CheckStack: (int) i //Check how many Saved Cards are Stacked and display corresponding Image
{
    if(RI.NumberOfSavedCards[i]>=30)
        [SavedImagesStack setImage:[UIImage imageNamed:@"stack4.png"]];
    else
        if(RI.NumberOfSavedCards[i]>=10)
            [SavedImagesStack setImage:[UIImage imageNamed:@"stack3.png"]];
        else
            if(RI.NumberOfSavedCards[i]>=3)
                [SavedImagesStack setImage:[UIImage imageNamed:@"stack2.png"]];
            else
                if(RI.NumberOfSavedCards[i]>=1)
                    [SavedImagesStack setImage:[UIImage imageNamed:@"stack1.png"]];
                else
                    [SavedImagesStack setImage:NULL];
}

@end
