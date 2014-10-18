//
//  UIView+GridLayout.m
//  MyView
//
//  Created by Chris Hulbert on 18/10/2014.
//  Copyright (c) 2014 Chris Hulbert. All rights reserved.
//
//  Lays all the subviews out in a grid.

#import "UIView+GridLayout.h"

@implementation UIView (GridLayout)

- (void)layoutSubviewsAsGrid {
    int w = self.bounds.size.width;
    int h = self.bounds.size.height;
    
    // Images are 160x90.
    int buttons = self.subviews.count;
    
    // Try a bunch of column counts to find the best fit.
    int bestDifference = 9999;
    int bestColumns = 1;
    int bestRows = 1;
    for (int testColumnCount=1; testColumnCount<10; testColumnCount++) {
        int rows = ceilf(buttons / ((float)testColumnCount));
        int buttonWidth = w / testColumnCount;
        int buttonHeight = buttonWidth * 90 / 160;
        int allHeight = buttonHeight * rows;
        int thisDifference = ABS(allHeight - h);
        if (thisDifference < bestDifference) {
            bestDifference = thisDifference;
            bestColumns = testColumnCount;
            bestRows = rows;
        }
    }
    
    // Lay out the buttons.
    int row=0, col=0;
    int colWidth = roundf(w / ((float)bestColumns));
    int lastColWidth = w - colWidth*(bestColumns-1); // Compensate for rounding.
    int rowHeight = roundf(h / ((float)bestRows));
    int lastRowHeight = h - rowHeight*(bestRows-1);
    for (UIView *view in self.subviews) {
        BOOL isLastCol = col == bestColumns-1;
        BOOL isLastRow = row == bestRows-1;
        view.frame = CGRectMake(col*colWidth, row*rowHeight,
                                isLastCol ? lastColWidth : colWidth,
                                isLastRow ? lastRowHeight : rowHeight);
        
        col++;
        if (col >= bestColumns) {
            col=0;
            row++;
        }
    }
}

@end
