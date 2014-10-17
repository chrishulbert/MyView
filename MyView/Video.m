//
//  Video.m
//  MyView
//
//  Created by Chris Hulbert on 16/10/2014.
//  Copyright (c) 2014 Chris Hulbert. All rights reserved.
//
//  Model object for a video.

#import "Video.h"

@implementation Video

- (NSString *)description {
    return [NSString stringWithFormat:@"Name: %@, Homepage: %@, Image: %@", _name, _homepage.absoluteString, _image.absoluteString];
}

@end
