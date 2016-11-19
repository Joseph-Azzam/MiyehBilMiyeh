//
//  ScoreViewController.h
//  MiyehBilMiyeh
//
//  Created by Joseph Azzam on 2014-01-03.
//  Copyright (c) 2014 Joseph Azzam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreViewController : UIViewController

@property int S;

@property (weak, nonatomic) IBOutlet UILabel *Score;
@property (weak, nonatomic) IBOutlet UIImageView *Background;

- (IBAction)PlayAgain:(id)sender;

@end
