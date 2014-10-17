//
//  VideosService.m
//  MyView
//
//  Created by Chris Hulbert on 16/10/2014.
//  Copyright (c) 2014 Chris Hulbert. All rights reserved.
//
//  This gets the list of videos for a show.

#import "VideosService.h"

#import "Show.h"
#import "Video.h"

@implementation VideosService

+ (void)requestVideosForShow:(Show *)show completion:(VideosCompletion)completion {
    NSURLRequest *request = [NSURLRequest requestWithURL:show.homepage];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data.length && !connectionError) {
            completion([self parse:data baseUrl:show.homepage], YES);
        } else {
            completion(nil, NO);
        }
    }];
}

#pragma mark - Private

+ (NSArray *)parse:(NSData *)data baseUrl:(NSURL *)baseUrl {
    NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (html) {
        NSString *useful = [self findFrom:@"abcforkids-video-clips-selector-carousel" to:@"</div>" in:html];
        if (useful) {
            NSMutableArray *videos = [NSMutableArray array];
            for (NSString *chunk in [useful componentsSeparatedByString:@"</li>"]) {
                NSString *name = [self findFrom:@"title=\"" to:@"\"" in:chunk];
                NSString *page = [self findFrom:@"<a href=\"" to:@"\"" in:chunk]; // Relative link.
                NSString *image = [self findFrom:@"src=\"" to:@"\"" in:chunk]; // Absolute link.
                if (name.length && page.length && image.length) {
                    Video *video = [[Video alloc] init];
                    video.name = [name stringByRemovingPercentEncoding];
                    video.homepage = [NSURL URLWithString:page relativeToURL:baseUrl];
                    video.image = [NSURL URLWithString:image];
                    [videos addObject:video];
                }
            }
            return [videos copy];
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
