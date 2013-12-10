//
//  GameController.h
//  GetWordy
//
//  Created by R. T. on 11/10/13.
//  Copyright (c) 2013 R. T. All rights reserved.
//  Adapted from a tutorial by Marin Todorov      
//  Source: http://www.raywenderlich.com/33808/how-to-make-a-letter-word-game-with-uikit-part-3 



#import "GameController.h"
#import "config.h"
#import "TileView.h"
#import "TargetView.h"
#import "StopWatchView.h"
#import "ExplodeView.h"
#import "StarDustView.h"

@implementation GameController
{
    //tile lists
    NSMutableArray* _tiles;
    NSMutableArray* _targets;
    //stopwatch variables
    int _secondsLeft;
    NSTimer* _timer;
}

//initialize the game controller
-(instancetype)init
{
    self = [super init];
    if (self != nil) {
        //initialize
        self.data = [[GameData alloc] init];
    }
    
    self.audioController = [[AudioController alloc] init];
    [self.audioController preloadAudioEffects: kAudioEffectFiles];
    
    return self;
}

-(void)dealRandomWord
{
    //1
    NSAssert(self.phase.wordlist, @"no phase loaded");
    
    //2 random word
    int randomIndex = arc4random()%[self.phase.wordlist count];
    NSArray* wordPair = self.phase.wordlist[ randomIndex ];
    
    //3
    NSString* wordlist1 = wordPair[0];
    NSString* wordlist2 = wordPair[1];
    
    //4
    int word1len = [wordlist1 length];
    int word2len = [wordlist2 length];
    
    
    //calculate the tile size
    float tileSide = ceilf( kScreenWidth*0.5 / (float)MAX(word1len, word2len) ) - kTileMargin;
    //get the left margin for first tile
    float xOffset = (kScreenWidth - MAX(word1len, word2len) * (tileSide + kTileMargin))/2;
    
    //adjust for tile center (instead of the tile's origin)
    xOffset += tileSide/2;
    
    //initialize target list
    _targets = [NSMutableArray arrayWithCapacity: word2len];
    
    //create targets for the tiles
    for (int i=0;i<word2len;i++) {
        NSString* letter = [wordlist2 substringWithRange:NSMakeRange(i, 1)];
        
        if (![letter isEqualToString:@" "]) {
            TargetView* target = [[TargetView alloc] initWithLetter:letter andSideLength:tileSide];
            target.center = CGPointMake(xOffset + i*(tileSide + kTileMargin), kScreenHeight/4);
            
            
            [self.gameView addSubview:target];
            [_targets addObject: target];
        }
    }
    //1 initialize tile list
    _tiles = [NSMutableArray arrayWithCapacity: word1len];
    
    //2 create the tiles
    for (int i=0;i<word1len;i++) {
        NSString* letter = [wordlist1 substringWithRange:NSMakeRange(i, 1)];
        
        
        if (![letter isEqualToString:@" "]) {
            TileView* tile = [[TileView alloc] initWithLetter:letter andSideLength:tileSide];
            tile.center = CGPointMake(xOffset + i*(tileSide + kTileMargin), kScreenHeight/4*3);
            [tile randomize];
            tile.dragDelegate = self;
        
            [self.gameView addSubview:tile];
            [_tiles addObject: tile];
        }
    }
    self.hud.btnHelp.enabled = YES;
    //start the timer
    [self startStopwatch];
}

//a tile was dragged, check if it matches a target
-(void)tileView:(TileView*)tileView didDragToPoint:(CGPoint)pt
{
    TargetView* targetView = nil;
    
    for (TargetView* tv in _targets) {
        if (CGRectContainsPoint(tv.frame, pt)) {
            targetView = tv;
            break;
        }
    }
    
    // check if target was found
    if (targetView!=nil) {
        
        // check if letter matches
        if ([targetView.letter isEqualToString: tileView.letter]) {
            
            [self placeTile:tileView atTarget:targetView];
            
            //Letter matches
            //give points
            self.data.points += self.phase.pointsPerTile;
            [self.hud.gamePoints countTo:self.data.points withDuration:1.50];
            //Plays sound
            [self.audioController playEffect: kSoundDing];
            //check for finished game
            [self checkForSuccess];
            
        } else {
            //take out points
            self.data.points -= self.phase.pointsPerTile/2;
            [self.hud.gamePoints countTo:self.data.points withDuration:0.75];
            //Plays sound
            [self.audioController playEffect: kSoundWrong];
            //visualizes the mistake
            [tileView randomize];
            
            [UIView animateWithDuration:0.35
                                  delay:0.00
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 tileView.center = CGPointMake(tileView.center.x + randomf(-20, 20),
                                                               tileView.center.y + randomf(20, 30));
                             } completion:nil];
        }
    }
}

//If tile is a match then it deactivates the tile and does animation
-(void)placeTile:(TileView*)tileView atTarget:(TargetView*)targetView
{
    targetView.isMatched = YES;
    tileView.isMatched = YES;
    
    tileView.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:0.35
                          delay:0.00
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         tileView.center = targetView.center;
                         tileView.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished){
                         targetView.hidden = YES;
                     }];
    
    //Animation plays
    ExplodeView* explode = [[ExplodeView alloc] initWithFrame:CGRectMake(tileView.center.x,tileView.center.y,10,10)];
    [tileView.superview addSubview: explode];
    [tileView.superview sendSubviewToBack:explode];
    

     
}

-(void)checkForSuccess
{
    for (TargetView* t in _targets) {
        //no success, bail out
        if (t.isMatched==NO) return;
    }
    
    //stop the stopwatch
    [self stopStopwatch];
    
    //the anagram is completed!
    [self.audioController playEffect:kSoundWin];
    
    //win animation
    TargetView* firstTarget = _targets[0];
    
    int startX = 0;
    int endX = kScreenWidth + 300;
    int startY = firstTarget.center.y;
    
    StarDustView* stars = [[StarDustView alloc] initWithFrame:CGRectMake(startX, startY, 10, 10)];
    [self.gameView addSubview:stars];
    [self.gameView sendSubviewToBack:stars];
    
    [UIView animateWithDuration:3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         stars.center = CGPointMake(endX, startY);
                     } completion:^(BOOL finished) {
                         
                         //game finished
                         [stars removeFromSuperview];
                         
                         //when animation is finished, show menu
                         [self resetStopwatch];
                         [self clearBoard];
                         self.onAnagramSolved();
    }];
}

-(void)startStopwatch
{
    //initialize the timer HUD
    _secondsLeft = self.phase.timeToSolve;
    [self.hud.stopwatch setSeconds:_secondsLeft];
    
    //schedule a new timer
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                              target:self
                                            selector:@selector(tick:)
                                            userInfo:nil
                                             repeats:YES];
}

//stop the watch
-(void)stopStopwatch
{
    [_timer invalidate];
    _timer = nil;
}

//stopwatch on tick
-(void)tick:(NSTimer*)timer
{
    _secondsLeft --;
    [self.hud.stopwatch setSeconds:_secondsLeft];
    
    if (_secondsLeft==0) {
        [self stopStopwatch];
        [self.audioController playEffect: kSoundWrong];
        [self clearBoard];
        self.onAnagramSolved();
    }
}


//reset the watch
-(void)resetStopwatch
{
    [_timer invalidate];
    _timer = nil;
    [self.hud.stopwatch setSeconds:0];
}


//connect the Hint button
-(void)setHud:(HUDView *)hud
{
    _hud = hud;
    [hud.btnHelp addTarget:self action:@selector(actionHint) forControlEvents:UIControlEventTouchUpInside];
    hud.btnHelp.enabled = NO;
}

//the user presses the hint button
-(void)actionHint
{
    //1
    self.hud.btnHelp.enabled = NO;
    
    //2
    self.data.points -= self.phase.pointsPerTile/2;
    [self.hud.gamePoints countTo: self.data.points withDuration: 1.5];
    //3 find the first target, not matched yet
    TargetView* target = nil;
    for (TargetView* t in _targets) {
        if (t.isMatched==NO) {
            target = t;
            break;
        }
    }
    //4 find the first tile, matching the target
    TileView* tile = nil;
    for (TileView* t in _tiles) {
        if (t.isMatched==NO && [t.letter isEqualToString:target.letter]) {
            tile = t;
            break;
        }
    }
    //5
    // don't want the tile sliding under other tiles
    [self.gameView bringSubviewToFront:tile];
    //Plays sound
    NSString *let = tile.letter;
    let = [let stringByAppendingString:@".wav"];
    [self.audioController playEffect: let];
    [self.audioController playEffect: kSoundDing];
    
    //6
    //show the animation to the user
    [UIView animateWithDuration:1.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         tile.center = target.center;
                     } completion:^(BOOL finished) {
                         //7 adjust view on spot
                         [self placeTile:tile atTarget:target];
                         
                         //8 re-enable the button
                         self.hud.btnHelp.enabled = YES;
                         
                         //9 check for finished game
                         [self checkForSuccess];
                     }];
    
}

//clear the tiles and targets
-(void)clearBoard
{
    [_tiles removeAllObjects];
    [_targets removeAllObjects];
    
    for (UIView *view in self.gameView.subviews) {
        [view removeFromSuperview];
    }
}

@end
