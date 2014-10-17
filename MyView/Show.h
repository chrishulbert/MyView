//
//  Show.h
//  MyView
//
//  Created by Chris Hulbert on 16/10/2014.
//  Copyright (c) 2014 Chris Hulbert. All rights reserved.
//
//  This is a show model object as returned by the shows service.

#import <Foundation/Foundation.h>

@interface Show : NSObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSURL *homepage;
@property(nonatomic, strong) NSURL *image;

@end
