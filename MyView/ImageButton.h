//
//  ImageButton.h
//  MyView
//
//  Created by Chris Hulbert on 19/10/2014.
//  Copyright (c) 2014 Chris Hulbert. All rights reserved.
//
//  Button with an image that fades in.

#import <UIKit/UIKit.h>

@interface ImageButton : UIButton

+ (instancetype)buttonWithImage:(NSURL *)image;

@end
