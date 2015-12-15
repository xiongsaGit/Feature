//
//  SMTCurrentIsDay.h
//  Feature
//
//  Created by sa.xiong on 15/12/15.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

// 判断当前时间是白天(06:00:00~20:00:00)还是夜晚

#import <Foundation/Foundation.h>

@interface SMTCurrentIsDay : NSObject

+ (BOOL)currentTimeIsDay;

@end
