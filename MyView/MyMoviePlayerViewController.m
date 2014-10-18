//
//  MyMoviePlayerViewController.m
//  MyView
//
//  Created by Chris Hulbert on 19/10/2014.
//  Copyright (c) 2014 Chris Hulbert. All rights reserved.
//
//  This is a movie player that loads the url while it's transitioning in.

#import "MyMoviePlayerViewController.h"

#import "Video.h"
#import "VideoService.h"

@implementation MyMoviePlayerViewController {
    Video *_video;
}

- (id)initWithVideo:(Video *)video {
    if (self = [super initWithContentURL:nil]) {
        _video = video;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [VideoService requestMp4ForVideo:_video completion:^(Video *video, NSURL *mp4, BOOL success) {
        if (success) {
            self.moviePlayer.contentURL = mp4;
        } else {
            NSLog(@"VideoService error");
            [self dismissMoviePlayerViewControllerAnimated];
        }
    }];
}

@end
