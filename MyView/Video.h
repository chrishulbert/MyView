//
//  Video.h
//  MyView
//
//  Created by Chris Hulbert on 16/10/2014.
//  Copyright (c) 2014 Chris Hulbert. All rights reserved.
//
//  Model object for a video.

#import <Foundation/Foundation.h>

@interface Video : NSObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSURL *homepage;
@property(nonatomic, strong) NSURL *image;

@end
