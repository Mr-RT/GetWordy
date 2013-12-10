//
//  GameController.h
//  GetWordy
//
//  Created by R. T. on 11/10/13.
//  Copyright (c) 2013 R. T. All rights reserved.
//  Adapted from a tutorial by Marin Todorov      
//  Source: http://www.raywenderlich.com/33808/how-to-make-a-letter-word-game-with-uikit-part-3 
#import <Foundation/Foundation.h>
#import "Phase.h"
#import "TileView.h"
#import "HUDView.h"
#import "GameData.h"
#import "AudioController.h"

typedef void (^CallbackBlock)();

@interface GameController : NSObject <TileDragDelegateProtocol>
//the view to add game elements to
@property (weak, nonatomic) UIView* gameView;

//the current level
@property (strong, nonatomic) Phase* phase;
//the hud layer
@property (weak, nonatomic) HUDView* hud;

//Keeps track of data
@property (strong, nonatomic) GameData* data;
//For a block that shows the game menu when a word is completed
@property (strong, nonatomic) CallbackBlock onAnagramSolved;

@property (strong, nonatomic) AudioController* audioController;

//display a new anagram on the screen
-(void)dealRandomWord;
@end
