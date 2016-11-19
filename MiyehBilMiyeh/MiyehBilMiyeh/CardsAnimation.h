//
//  CardsAnimation.h
//  MiyehBilMiyeh
//
//  Created by Joseph Azzam on 2014-01-05.
//  Copyright (c) 2014 Joseph Azzam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReplicationInfo.h"

@interface CardsAnimation : NSObject

@property BOOL isAnimating;
@property (nonatomic,strong) UIView *UIV;
@property float Speed;//points per second
- (void) AnimateWithReplicationInfo: (ReplicationInfo *) ReplInf InView: (UIView *) CurrentView;

@end
