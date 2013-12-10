//
//  StopWatchView.m
//  GetWordy
//
//  Created by R. T. on 11/10/13.
//  Copyright (c) 2013 R. T. All rights reserved.
//  Adapted from a tutorial by Marin Todorov
//  Source: http://www.raywenderlich.com/33808/how-to-make-a-letter-word-game-with-uikit-part-3
#import "StopWatchView.h"
#import "config.h"

@implementation StopWatchView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        self.font = kFontHUDBig;
    }
    return self;
}

//helper method that implements time formatting
//to an int parameter (eg the seconds left)
-(void)setSeconds:(int)seconds
{
    self.text = [NSString stringWithFormat:@" %02.f : %02i", round(seconds / 60), seconds % 60 ];
}

@end
