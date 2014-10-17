//
//  ViewController.m
//  MyView
//
//  Created by Chris Hulbert on 16/10/2014.
//  Copyright (c) 2014 Chris Hulbert. All rights reserved.
//

#import "ViewController.h"

#import "ShowsService.h"
#import "VideosService.h"
#import "Show.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)init {
    if (self = [super init]) {
        self.title = @"Shows";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [ShowsService requestShowsWithCompletion:^(NSArray *shows, BOOL success) {
        if (success) {
            NSLog(@"Shows: %@", shows);
            
            if (shows.count) {
                Show *show = shows.lastObject;
                [VideosService requestVideosForShow:show completion:^(NSArray *videos, BOOL success) {
                    if (success) {
                        NSLog(@"Videos: %@", videos);
                    } else {
                        NSLog(@"Error");
                    }
                }];
            }
            
        } else {
            NSLog(@"Error");
        }
    }];
}

@end
