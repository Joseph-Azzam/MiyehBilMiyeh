//
//  ScoreViewController.m
//  MiyehBilMiyeh
//
//  Created by Joseph Azzam on 2014-01-03.
//  Copyright (c) 2014 Joseph Azzam. All rights reserved.
//

#import "ScoreViewController.h"

@interface ScoreViewController ()

@end

@implementation ScoreViewController

@synthesize S;

@synthesize Score;
@synthesize Background;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if(S>=75)
        [Background setImage:[UIImage imageNamed:@"blue.png"]];
    else
        if(S>=50)
            [Background setImage:[UIImage imageNamed:@"green.png"]];
        else
            [Background setImage:[UIImage imageNamed:@"red.png"]];
    
    Score.text = [NSString stringWithFormat:@"%d%c",S,'%'];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)PlayAgain:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
