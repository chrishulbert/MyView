//
//  ShowsView.m
//  MyView
//
//  Created by Chris Hulbert on 17/10/2014.
//  Copyright (c) 2014 Chris Hulbert. All rights reserved.
//
//  Root for ShowsViewController.

#import "ShowsView.h"

@implementation ShowsView

- (id)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    int w = self.bounds.size.width;
    int h = self.bounds.size.height;
    
    // Images are 160x90.
    int buttons = self.subviews.count;
    
    // Try a bunch of column counts to find the best fit.
    NSLog(@"Layout");
    int bestDifference = 9999;
    int bestColumns = 1;
    int bestRows = 1;
    int bestWidth = 0;
    int bestHeight = 0;
    for (int testColumnCount=1; testColumnCount<20; testColumnCount++) {
        int rows = ceilf(buttons / ((float)testColumnCount));
        int buttonWidth = w / testColumnCount;
        int buttonHeight = buttonWidth * 90 / 160;
        int allHeight = buttonHeight * rows;
        int thisDifference = ABS(allHeight - h);
        if (thisDifference < bestDifference) {
            bestDifference = thisDifference;
            bestColumns = testColumnCount;
            bestRows = rows;
            bestWidth = buttonWidth;
            bestHeight = buttonHeight;
        }
    }
    
    // Lay out the buttons.
    int row=0, col=0;
    for (UIView *view in self.subviews) {
        view.frame = CGRectMake(col*bestWidth, row*bestHeight, bestWidth, bestHeight);
        
        col++;
        if (col >= bestColumns) {
            col=0;
            row++;
        }
    }
}

@end
