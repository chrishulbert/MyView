//
//  ShowViewController.m
//  MyView
//
//  Created by Chris Hulbert on 17/10/2014.
//  Copyright (c) 2014 Chris Hulbert. All rights reserved.
//

#import "ShowViewController.h"

#import <MediaPlayer/MediaPlayer.h>

#import "ShowView.h"
#import "Show.h"
#import "VideosService.h"
#import "Video.h"
#import "VideoService.h"
#import "UIButton+WebCache.h"
#import "UIView+MyUserInfo.h"

@implementation ShowViewController {
    ShowView *_view;
    Show *_show;
    NSArray *_videos;
}

- (id)initWithShow:(Show *)show {
    if (self = [super init]) {
        _show = show;
        self.title = show.name;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (void)loadView {
    _view = [[ShowView alloc] init];
    self.view = _view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [VideosService requestVideosForShow:_show completion:^(NSArray *videos, BOOL success) {
        if (success) {
            _videos = videos;
            // Clear.
            for (UIView *view in _view.subviews.copy) {
                [view removeFromSuperview];
            }
            
            // Add new ones.
            for (Video *video in videos) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
                [button sd_setBackgroundImageWithURL:video.image forState:UIControlStateNormal];
                button.imageView.contentMode = UIViewContentModeScaleAspectFill;
                button.clipsToBounds = YES;
                button.myUserInfo = video;
                [button addTarget:self action:@selector(tapVideo:) forControlEvents:UIControlEventTouchUpInside];
                [_view addSubview:button];
            }
            [_view setNeedsLayout];
        } else {
            NSLog(@"Error");
        }
    }];
}

- (void)tapVideo:(UIButton *)button {
#warning TODO Show something
    
    self.view.userInteractionEnabled = NO;
    button.enabled = NO;
    
    [VideoService requestMp4ForVideo:button.myUserInfo completion:^(Video *video, NSURL *mp4, BOOL success) {
        self.view.userInteractionEnabled = YES;
        
//        if (success) {
//            MPMoviePlayerViewController *player = [[MPMoviePlayerViewController alloc] initWithContentURL:mp4];
//            [self presentMoviePlayerViewControllerAnimated:player];
//        } else {
//            NSLog(@"Error");
//        }
    }];
}

@end
