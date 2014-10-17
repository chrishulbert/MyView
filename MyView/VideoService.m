//
//  VideoService.m
//  MyView
//
//  Created by Chris Hulbert on 17/10/2014.
//  Copyright (c) 2014 Chris Hulbert. All rights reserved.
//
//  This gets you information about a single video.

#import "VideoService.h"

#import "Video.h"

@implementation VideoService

+ (void)requestMp4ForVideo:(Video *)video completion:(VideoCompletion)completion {
    NSURLRequest *request = [NSURLRequest requestWithURL:video.homepage];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data.length && !connectionError) {
            completion(video, [self parse:data], YES);
        } else {
            completion(video, nil, NO);
        }
    }];
}

#pragma mark - Private

+ (NSURL *)parse:(NSData *)data {
    NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (html) {
        NSString *useful = [self findFrom:@"var videoClip" to:@"}" in:html];
        if (useful) {
            NSString *source = [self findFrom:@"source: \"" to:@"\"" in:useful];
            if (source) {
                return [NSURL URLWithString:source];
            }
        }
    }
    return nil;
}

+ (NSString *)findFrom:(NSString *)from to:(NSString *)to in:(NSString *)string {
    NSRange start = [string rangeOfString:from];
    if (start.length) {
        NSUInteger searchFrom = start.location + start.length;
        NSRange end = [string rangeOfString:to options:0 range:NSMakeRange(searchFrom, string.length - searchFrom)];
        if (end.length) {
            return [string substringWithRange:NSMakeRange(searchFrom, end.location - searchFrom)];
        }
    }
    return nil;
}

@end
