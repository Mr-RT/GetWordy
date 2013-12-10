//
//  TargetView.m
//  GetWordy
//
//  Created by R. T. on 11/10/13.
//  Copyright (c) 2013 R. T. All rights reserved.
//  Adapted from a tutorial by Marin Todorov      
//  Source: http://www.raywenderlich.com/33808/how-to-make-a-letter-word-game-with-uikit-part-3 

#import <UIKit/UIKit.h>
#import "TargetView.h"


@implementation TargetView

- (id)init
{
    NSAssert(NO, @"Use initWithLetter:andSideLength instead");
    return nil;
}

- (id)initWithImage:(UIImage *)image
{
    NSAssert(NO, @"Use initWithLetter:andSideLength instead");
    return nil;
}

- (id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
    NSAssert(NO, @"Use initWithLetter:andSideLength instead");
    return nil;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    NSAssert(NO, @"Use initWithLetter:andSideLength instead");
    return nil;
}

- (id)initWithFrame:(CGRect)frame
{
    NSAssert(NO, @"Use initWithLetter:andSideLength instead");
    return nil;
}

//create a new target, store what letter should it match to
-(instancetype)initWithLetter:(NSString*)letter andSideLength:(float)sideLength
{
    UIImage* img = [UIImage imageNamed:@"slot"];
    self = [super initWithImage: img];
    
    if (self != nil) {
        //initialization
        self.isMatched = NO;
        
        float scale = sideLength/img.size.width;
        self.frame = CGRectMake(0,0,img.size.width*scale, img.size.height*scale);
        
        _letter = letter;
    }
    return self;
}

@end
