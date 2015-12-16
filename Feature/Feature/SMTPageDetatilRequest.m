//
//  SMTPageDetatilRequest.m
//  Feature
//
//  Created by sa.xiong on 15/12/14.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "SMTPageDetatilRequest.h"

@implementation SMTPageDetatilRequest
{
    NSNumber *_digestId;
}

- (id)initWithDigestId:(NSNumber *)digestId
{
    if (self = [super init]) {
        _digestId = digestId;
    }
    return self;
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (id)requestArgument
{
    return @{
             @"action":kDigestDetail,
             @"digestId":[_digestId stringValue],
             };
}
@end
