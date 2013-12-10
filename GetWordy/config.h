//
//  config.h
//  GetWordy
//
//  Created by R. T. on 11/10/13.
//  Copyright (c) 2013 R. T. All rights reserved.
//  Adapted from a tutorial by Marin Todorov
//  Source: http://www.raywenderlich.com/33808/how-to-make-a-letter-word-game-with-uikit-part-3 

#ifndef configed

//UI definitions
#define kScreenWidth [UIScreen mainScreen].bounds.size.height
#define kScreenHeight [UIScreen mainScreen].bounds.size.width

//Fonts
#define kFontHUD [UIFont fontWithName:@"MarkerFelt-Thin" size:40.0]
#define kFontHUDBig [UIFont fontWithName:@"MarkerFelt-Thin" size:80.0]

//audio defines
#define kSoundDing  @"ding.mp3"
#define kSoundWrong @"wrong.m4a"
#define kSoundWin   @"win.mp3"

#define kSoundA @"a.wav"
#define kSoundB @"b.wav"
#define kSoundC @"c.wav"
#define kSoundD @"d.wav"
#define kSoundE @"e.wav"
#define kSoundF @"f.wav"
#define kSoundG @"g.wav"
#define kSoundH @"h.wav"
#define kSoundI @"i.wav"
#define kSoundJ @"j.wav"
#define kSoundK @"k.wav"
#define kSoundL @"l.wav"
#define kSoundM @"m.wav"
#define kSoundN @"n.wav"
#define kSoundO @"o.wav"
#define kSoundP @"p.wav"
#define kSoundQ @"q.wav"
#define kSoundR @"r.wav"
#define kSoundS @"s.wav"
#define kSoundT @"t.wav"
#define kSoundU @"u.wav"
#define kSoundV @"v.wav"
#define kSoundW @"w.wav"
#define kSoundX @"x.wav"
#define kSoundY @"y.wav"
#define kSoundZ @"z.wav"

#define kLetterEffectFiles @[kSoundA, kSoundB, kSoundC, kSoundD, kSoundE, kSoundF, kSoundG, kSoundH, kSoundI, kSoundJ, kSoundK, kSoundL, kSoundM, kSoundN, kSoundO, kSoundP, kSoundQ, kSoundR, kSoundS, kSoundT, kSoundU, kSoundV, kSoundW, kSoundX,  kSoundY, kSoundZ]

#define kAudioEffectFiles @[kSoundDing, kSoundWrong, kSoundWin, kSoundA, kSoundB, kSoundC, kSoundD, kSoundE, kSoundF, kSoundG, kSoundH, kSoundI, kSoundJ, kSoundK, kSoundL, kSoundM, kSoundN, kSoundO, kSoundP, kSoundQ, kSoundR, kSoundS, kSoundT, kSoundU, kSoundV, kSoundW, kSoundX,  kSoundY, kSoundZ]

//more definitions here
#define kTileMargin 20

//handy math functions
#define rad2deg(x) x * 180 / M_PI
#define deg2rad(x) x * M_PI / 180
#define randomf(minX,maxX) ((float)(arc4random() % (maxX - minX + 1)) + (float)minX)


#define configed 1
#endif