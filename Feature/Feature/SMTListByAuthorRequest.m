//
//  SMTListByAuthorRequest.m
//  Feature
//
//  Created by sa.xiong on 15/12/12.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "SMTListByAuthorRequest.h"

@implementation SMTListByAuthorRequest
{
    NSNumber *_authorId;
}

- (id)initWithAuthorId:(NSNumber *)authorId
{
    if (self = [super init]) {
        _authorId = authorId;
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
             @"action":kDigestListByAuthor,
             @"authorId":[_authorId stringValue],
             @"pageSize":kPageSize
             };
}


@end
