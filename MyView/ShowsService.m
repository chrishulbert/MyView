//
//  ShowsService.m
//  MyView
//
//  Created by Chris Hulbert on 16/10/2014.
//  Copyright (c) 2014 Chris Hulbert. All rights reserved.
//
//  Gets a list of shows.

#import "ShowsService.h"

#import "Show.h"

static NSString *kUrl = @"http://www.abc.net.au/abcforkids/video/";

@implementation ShowsService

+ (void)requestShowsWithCompletion:(ShowsCompletion)completion {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kUrl]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data.length && !connectionError) {
            completion([self parse:data], YES);
        } else {
            completion(nil, NO);
        }
    }];
}

#pragma mark - Private

+ (NSArray *)parse:(NSData *)data {
    NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (html) {
        NSRange start = [html rangeOfString:@"abcforkids-content-wrapper-outer"];
        if (start.length) {
            NSRange end = [html rangeOfString:@"</div>" options:0 range:NSMakeRange(start.location, html.length - start.location)];
            if (end.length) {
                NSString *useful = [html substringWithRange:NSMakeRange(start.location, end.location-start.location)];
                NSArray *showChunks = [useful componentsSeparatedByString:@"</li>"];
                NSMutableArray *shows = [NSMutableArray array];
                for (NSString *chunk in showChunks) {
                    NSString *name = [self findFrom:@"<li title=\"" to:@"\"" in:chunk];
                    NSString *page = [self findFrom:@"<a href=\"" to:@"\"" in:chunk]; // Relative link.
                    NSString *image = [self findFrom:@"<img src=\"" to:@"\"" in:chunk]; // Absolute link.
                    if (name.length && page.length && image.length) {
                        Show *show = [[Show alloc] init];
                        show.name = [name stringByRemovingPercentEncoding];
                        show.homepage = [NSURL URLWithString:page relativeToURL:[NSURL URLWithString:kUrl]];
                        show.image = [NSURL URLWithString:image];
                        [shows addObject:show];
                    }
                }
                return [shows copy];
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
