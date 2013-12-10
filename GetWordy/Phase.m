//
//  Phase.m
//  GetWordy
//
//  Created by R. T. on 11/10/13.
//  Copyright (c) 2013 R. T. All rights reserved.
//  Adapted from a tutorial by Marin Todorov      
//  Source: http://www.raywenderlich.com/33808/how-to-make-a-letter-word-game-with-uikit-part-3  

#import "Phase.h"

@implementation Phase
+(instancetype)phaseWithNum:(int)phaseNum;
{
    //find .plist file for this phase
    NSString* fileName = [NSString stringWithFormat:@"phase%i.plist", phaseNum];
    NSString* phasePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
    
    //load .plist file
    NSDictionary* phaseDict = [NSDictionary dictionaryWithContentsOfFile:phasePath];
    
    //3 validation
    NSAssert(phaseDict, @"phase config file not found");
    
    //4 create Phase instance
    Phase* p = [[Phase alloc] init];
    
    //5 initialize the object from the dictionary
    p.pointsPerTile = [phaseDict[@"pointsPerTile"] intValue];
    p.wordlist = phaseDict[@"wordlist"];
    p.timeToSolve = [phaseDict[@"timeToSolve"] intValue];
    
    return p;
}@end
