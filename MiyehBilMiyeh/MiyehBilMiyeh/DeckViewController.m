//
//  DeckViewController.m
//  MiyehBilMiyeh
//
//  Created by Joseph Azzam on 2014-01-03.
//  Copyright (c) 2014 Joseph Azzam. All rights reserved.
//

#import "DeckViewController.h"

@interface DeckViewController ()

@end

@implementation DeckViewController

@synthesize Animated;//Turn On and off the animation
@synthesize CD;
@synthesize ANIM;
@synthesize WAIT;

@synthesize BackStill;
@synthesize BackAnimated;
@synthesize MatchCard;
@synthesize Score;
@synthesize SavedCardsStack;
@synthesize NbrOfCards;


- (void)viewDidLoad
{
    WAIT = NO;
    Animated = YES;
    ANIM = [[CardsAnimation alloc]init];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CD = [[Cards alloc]init];
    NbrOfCards.text = [NSString stringWithFormat:@"%i", [CD NbrOfCards]];

}
- (void) viewDidDisappear:(BOOL)animated
{
    [self ResetView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)ResetView
{
    CD = [[Cards alloc]init];
    NbrOfCards.text = [NSString stringWithFormat:@"%i", [CD NbrOfCards]];
    [self ClearDeck];
    [SavedCardsStack setImage:NULL];
    [MatchCard setImage:NULL];
    Score.text = [NSString stringWithFormat:@"%d%c",0,'%'];
    WAIT = NO;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Score"] )
    {
        //send the score to the Score ViewController
        ScoreViewController *svc = [segue destinationViewController];
        svc.S = CD.score;
        //Reset this view for a new match
    }
}
- (IBAction)StartButtonPressed:(id)sender
{
    if((self.CD.NbrOfCards !=0 || self.CD.score<MAX) && !ANIM.isAnimating && !WAIT)
    {
        
        ReplicationInfo *RI;
        if(Animated) RI = [[ReplicationInfo alloc]init];
        if(Animated) ANIM = [[CardsAnimation alloc]init];
        
        [self ClearDeck];
        BOOL Match = NO;
        UIImageView *IV;
        Photo *photo ;
        UIImage *image ;
        NSMutableArray *SavedCards = [[NSMutableArray alloc]init];
        
        for(int i=1 ; i<=13 ; i++)
        {
            photo = [[Photo alloc]init];
            image = [[UIImage alloc]init];
            
            //Find concerned UIImageView
            IV = (UIImageView *)[self.view viewWithTag:i];
            photo=[self.CD StartCounting];
            image = [UIImage imageNamed:[photo name]];
            if(!Animated) [IV setImage:image];
            [SavedCards addObject:photo];
            
            if(Animated) [RI.CardsOnDeck addObject:[NSString stringWithFormat:@"%d%c.png", [photo tag], [photo type] ]];
            
            if(i == [photo tag] )//in case of a match
            {
                Match = YES;
                
                if(Animated) RI.Match = YES;
                if(Animated) RI.MatchImage = [photo name];
                
                self.CD.score+=[photo tag]; //update the score
                if(self.CD.score >MAX)
                    self.CD.score = MAX; //forbid bypass of maximum score value
                
                [CD SaveCards:SavedCards];//Save Cards On Deck
                if(!Animated) [MatchCard setImage:[UIImage imageNamed:[photo name]]];
            }
            if(Animated) RI.Score[i-1] = CD.score;
            if(Animated) RI.NumberOfCards[i-1] = CD.NbrOfCards;
            if(Animated) RI.NumberOfSavedCards[i-1] = CD.NbrOfSavedCards;
            
            if(!Animated) Score.text = [NSString stringWithFormat:@"%d%c",self.CD.score,'%'];
            if(!Animated) NbrOfCards.text = [NSString stringWithFormat:@"%d",self.CD.NbrOfCards];
            
            if(!Animated) [self CheckStack];//Change Image of the Saved Cards Stack
            
            if( (self.CD.NbrOfSavedCards == 0 && self.CD.NbrOfCards == 0) || (self.CD.score == MAX) || Match )
            break;
            
        }
        if(Animated) [ANIM AnimateWithReplicationInfo:RI InView:self.view];
        
        if( (self.CD.NbrOfSavedCards == 0 && self.CD.NbrOfCards == 0) || (self.CD.score == MAX)) //Check When the Game is Over
        {
            if(!Animated) [self ShowScore];//(FOR ANIMATION SHOULD ADD CONDITION)
            if(Animated)
            {    WAIT = YES;
                [self performSelectorInBackground:@selector(wait) withObject:nil];
            }
        }
    }
}

-(void) CheckStack //Check how many Saved Cards are Stacked and display corresponding Image
{
    if(CD.NbrOfSavedCards>=30)
        [SavedCardsStack setImage:[UIImage imageNamed:@"stack4.png"]];
    else
        if(CD.NbrOfSavedCards>=10)
            [SavedCardsStack setImage:[UIImage imageNamed:@"stack3.png"]];
        else
            if(CD.NbrOfSavedCards>=3)
                [SavedCardsStack setImage:[UIImage imageNamed:@"stack2.png"]];
            else
                if(CD.NbrOfSavedCards>=1)
                    [SavedCardsStack setImage:[UIImage imageNamed:@"stack1.png"]];
                else
                    [SavedCardsStack setImage:NULL];
}


- (void) ClearDeck // empty the cards deck
{
    UIImageView *IV;
    for(int i=1 ; i<=13 ; i++)
    {
        IV = [[UIImageView alloc]init];
        IV = (UIImageView *)[self.view viewWithTag:i];
        [IV  setImage:NULL];
    }
}

- (void) ShowScore
{
    [self performSegueWithIdentifier:@"Score" sender:self];
}

- (void) wait
{
    while (ANIM.isAnimating) {sleep(2);}
    [self ShowScore];
}

@end
