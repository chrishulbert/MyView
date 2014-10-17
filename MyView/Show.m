//
//  Show.m
//  MyView
//
//  Created by Chris Hulbert on 16/10/2014.
//  Copyright (c) 2014 Chris Hulbert. All rights reserved.
//
//  This is a show model object as returned by the shows service.

#import "Show.h"

@implementation Show

- (NSString *)description {
    return [NSString stringWithFormat:@"Name: %@, Homepage: %@, Image: %@", _name, _homepage.absoluteString, _image.absoluteString];
}

@end
