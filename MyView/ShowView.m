//
//  ShowView.m
//  MyView
//
//  Created by Chris Hulbert on 18/10/2014.
//  Copyright (c) 2014 Chris Hulbert. All rights reserved.
//
//  Root for ShowViewController.

#import "ShowView.h"

#import "UIView+GridLayout.h"

@implementation ShowView

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
