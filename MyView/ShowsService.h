//
//  ShowsService.h
//  MyView
//
//  Created by Chris Hulbert on 16/10/2014.
//  Copyright (c) 2014 Chris Hulbert. All rights reserved.
//
//  Gets a list of shows.

#import <Foundation/Foundation.h>

typedef void(^ShowsCompletion)(NSArray *shows, BOOL success);

@interface ShowsService : NSObject

+ (void)requestShowsWithCompletion:(ShowsCompletion)completion;

@end
