//
//  VideoService.h
//  MyView
//
//  Created by Chris Hulbert on 17/10/2014.
//  Copyright (c) 2014 Chris Hulbert. All rights reserved.
//
//  This gets you information about a single video.

#import <Foundation/Foundation.h>

@class Video;

typedef void(^VideoCompletion)(Video *video, NSURL *mp4, BOOL success);

@interface VideoService : NSObject

+ (void)requestMp4ForVideo:(Video *)video completion:(VideoCompletion)completion;

@end
