//
//  SMTHomePageListRequest.h
//  Feature
//
//  Created by sa.xiong on 15/12/11.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "SMTBaseRequest.h"

// 主页数据请求
@interface SMTHomePageListRequest : SMTBaseRequest

- (id)initWithAct:(NSString *)act dayOrNight:(NSString *)dayOrNight sortPage:(NSNumber *)sortPage;

@end
