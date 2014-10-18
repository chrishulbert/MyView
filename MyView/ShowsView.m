//
//  ShowsView.m
//  MyView
//
//  Created by Chris Hulbert on 17/10/2014.
//  Copyright (c) 2014 Chris Hulbert. All rights reserved.
//
//  Root for ShowsViewController.

#import "ShowsView.h"

#import "UIView+GridLayout.h"

@implementation ShowsView

- (id)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self layoutSubviewsAsGrid];
}

@end
