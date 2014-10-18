//
//  MyMoviePlayerViewController.h
//  MyView
//
//  Created by Chris Hulbert on 19/10/2014.
//  Copyright (c) 2014 Chris Hulbert. All rights reserved.
//
//  This is a movie player that loads the url while it's transitioning in.

#import <MediaPlayer/MediaPlayer.h>

@class Video;

@interface MyMoviePlayerViewController : MPMoviePlayerViewController

- (id)initWithVideo:(Video *)video;

@end
