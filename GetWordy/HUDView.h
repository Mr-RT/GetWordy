//
//  HUDView.h
//  GetWordy
//
//  Created by R. T. on 11/10/13.
//  Copyright (c) 2013 R. T. All rights reserved.
//  Adapted from a tutorial by Marin Todorov      
//  Source: http://www.raywenderlich.com/33808/how-to-make-a-letter-word-game-with-uikit-part-3 

#import <UIKit/UIKit.h>
#import "StopWatchView.h"
#import "CounterLabelView.h"

@interface HUDView : UIView
@property (strong, nonatomic) StopWatchView* stopwatch;
@property (strong, nonatomic) CounterLabelView* gamePoints;
@property (strong, nonatomic) UIButton* btnHelp;

+(instancetype)viewWithRect:(CGRect)r;

@end
