//
//  SMTHomePageListRequest.m
//  Feature
//
//  Created by sa.xiong on 15/12/11.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "SMTHomePageListRequest.h"

@implementation SMTHomePageListRequest
{
    NSString *_act;
    NSString *_dayOrNight;
    NSNumber *_sortPage;
}


- (id)initWithAct:(NSString *)act dayOrNight:(NSString *)dayOrNight sortPage:(NSNumber *)sortPage
{
    self = [super init];
    if (self) {
        _act = act;
        _dayOrNight = dayOrNight;
        _sortPage = sortPage;
    }
    return self;
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (id)requestArgument
{
    if (_sortPage == nil) {
        return @{
                 @"act":_act,
                 @"action":kDigestHomePageList,
                 @"dayOrNight":_dayOrNight,
                 @"pageSize":kPageSize,
                 };
    }else{
        return @{
                 @"act":_act,
                 @"action":kDigestHomePageList,
                 @"dayOrNight":_dayOrNight,
                 @"pageSize":kPageSize,
                 @"sortPage":[_sortPage stringValue]
                 };
    }
}

@end
