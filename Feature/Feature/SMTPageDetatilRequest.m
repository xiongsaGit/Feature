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
    NSString *_action;
    NSString *_digestId;
}

- (id)initWithAction:(NSString *)action digestId:(NSString *)digestId
{
    if (self = [super init]) {
        _action = action;
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
             @"action":_action,
             @"digestId":_digestId,
             };
}
@end
