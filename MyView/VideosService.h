//
//  VideosService.h
//  MyView
//
//  Created by Chris Hulbert on 16/10/2014.
//  Copyright (c) 2014 Chris Hulbert. All rights reserved.
//
//  This gets the list of videos for a show.

#import <Foundation/Foundation.h>

typedef void(^VideosCompletion)(NSArray *videos, BOOL success);

@class Show;

@interface VideosService : NSObject

+ (void)requestVideosForShow:(Show *)show completion:(VideosCompletion)completion;

@end
