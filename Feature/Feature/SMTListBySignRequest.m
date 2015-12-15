//
//  SMTListBySignRequest.m
//  Feature
//
//  Created by sa.xiong on 15/12/12.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "SMTListBySignRequest.h"

@implementation SMTListBySignRequest
{
    NSNumber *_signId;
}

- (id)initWithSignId:(NSNumber *)signId
{
    if (self = [super init]) {
        _signId = signId;
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
             @"action":kDigestListBySign,
             @"signId":[_signId stringValue],
             @"pageSize":kPageSize
             };
}

@end
