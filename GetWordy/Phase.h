//
//  Phase.h
//  GetWordy
//
//  Created by R. T. on 11/10/13.
//  Copyright (c) 2013 R. T. All rights reserved.
//  Adapted from a tutorial by Marin Todorov      
//  Source: http://www.raywenderlich.com/33808/how-to-make-a-letter-word-game-with-uikit-part-3 

#import <Foundation/Foundation.h>

@interface Phase : NSObject
//properties stored in a .plist file
@property (assign, nonatomic) int pointsPerTile;
@property (assign, nonatomic) int timeToSolve;
@property (strong, nonatomic) NSArray* wordlist;

//factory method to load a .plist file and initialize the model
+(instancetype)phaseWithNum:(int)phaseNum;@end
