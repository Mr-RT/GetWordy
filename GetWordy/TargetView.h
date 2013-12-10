//
//  TargetView.h
//  GetWordy
//
//  Created by R. T. on 11/10/13.
//  Copyright (c) 2013 R. T. All rights reserved.
//  Adapted from a tutorial by Marin Todorov      
//  Source: http://www.raywenderlich.com/33808/how-to-make-a-letter-word-game-with-uikit-part-3  

#import <UIKit/UIKit.h>

@interface TargetView : UIImageView

@property (strong, nonatomic, readonly) NSString* letter;
@property (assign, nonatomic) BOOL isMatched;

-(instancetype)initWithLetter:(NSString*)letter andSideLength:(float)sideLength;

@end
