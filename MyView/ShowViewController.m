//
//  ShowViewController.m
//  MyView
//
//  Created by Chris Hulbert on 17/10/2014.
//  Copyright (c) 2014 Chris Hulbert. All rights reserved.
//

#import "ShowViewController.h"

#import <MediaPlayer/MediaPlayer.h>

#import "Show.h"
#import "VideosService.h"
#import "Video.h"
#import "VideoService.h"

static NSString *kCellId = @"cell";

@implementation ShowViewController {
    Show *_show;
    NSArray *_videos;
}

- (id)initWithShow:(Show *)show {
    if (self = [super init]) {
        _show = show;
        self.title = show.name;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellId];
    
    [VideosService requestVideosForShow:_show completion:^(NSArray *videos, BOOL success) {
        if (success) {
            _videos = videos;
            [self.tableView reloadData];
        } else {
            NSLog(@"Error");
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _videos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Video *video = _videos[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId forIndexPath:indexPath];
    cell.textLabel.text = video.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Video *video = _videos[indexPath.row];

    #warning TODO Show something
    self.view.userInteractionEnabled = NO;
    [VideoService requestMp4ForVideo:video completion:^(Video *video, NSURL *mp4, BOOL success) {
        self.view.userInteractionEnabled = YES;
        
        if (success) {
            MPMoviePlayerViewController *player = [[MPMoviePlayerViewController alloc] initWithContentURL:mp4];
            [self presentMoviePlayerViewControllerAnimated:player];
        } else {
            NSLog(@"Error");
        }
    }];
}

@end
