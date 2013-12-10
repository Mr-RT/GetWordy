//
//  GameData.m
//  GetWordy
//
//  Created by R. T. on 11/10/13.
//  Copyright (c) 2013 R. T. All rights reserved.
//  Adapted from a tutorial by Marin Todorov      
//  Source: http://www.raywenderlich.com/33808/how-to-make-a-letter-word-game-with-uikit-part-3


#import "GameData.h"

@implementation GameData

//custom setter - keep the score positive
-(void)setPoints:(int)points
{
    _points = MAX(points, 0);
}

@end
