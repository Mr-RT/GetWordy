//
//  ViewController.m
//  GetWordy
//
//  Created by R. T. on 11/10/13.
//  Copyright (c) 2013 R. T. All rights reserved.
//  Adapted from a tutorial by Marin Todorov
//  Source: http://www.raywenderlich.com/33808/how-to-make-a-letter-word-game-with-uikit-part-3 

#import "config.h"
#import "ViewController.h"
#import "Phase.h"
#import "GameController.h"
#import "HUDView.h"
@interface ViewController () <UIActionSheetDelegate>
@property (strong, nonatomic) GameController* controller;
@end

@implementation ViewController

-(instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self != nil) {
        //create the game controller
        self.controller = [[GameController alloc] init];
    }
    return self;
}



//setup the view and instantiate the game controller
- (void)viewDidLoad
{
    [super viewDidLoad];

    
    //add one layer for all game elements
    UIView* gameLayer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview: gameLayer];
    
    self.controller.gameView = gameLayer;
    
    //add one layer for all hud and controls
    HUDView* hudView = [HUDView viewWithRect:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:hudView];
    
    self.controller.hud = hudView;
    
    __weak ViewController* weakSelf = self;
    self.controller.onAnagramSolved = ^(){
        [weakSelf showLevelMenu];
    };
    

}


//show tha game menu when the app starts
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self showLevelMenu];
}

#pragma mark - Game manu
//show the level selector menu
-(void)showLevelMenu
{
    UIActionSheet* action = [[UIActionSheet alloc] initWithTitle:@"Play at what difficulty level?"
                                                        delegate:self
                                               cancelButtonTitle:nil
                                          destructiveButtonTitle:nil
                                               otherButtonTitles:@"Phase 1 - Easy", @"Phase 2 - Medium" , @"Phase 3 - Hard", nil];
    [action showInView:self.view];
}
//level was selected, load it up and start the game
-(void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    //1 check if the user tapped outside the menu
    if (buttonIndex==-1) {
        [self showLevelMenu];
        return;
    }
    
    //2 map index 0 to level 1, etc...
    int phaseNum = buttonIndex+1;
    
    //if(phaseNum > 0 && phaseNum < 4){
        //3 load the level, fire up the game
        self.controller.phase = [Phase phaseWithNum:phaseNum];
        [self.controller dealRandomWord];
    //}
    //4 Else, quit the game.
    //Do more here.
    //[self.controller resetStopwatch];
    
    
}



@end
