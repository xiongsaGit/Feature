//
//  SMTCurrentIsDay.m
//  Feature
//
//  Created by sa.xiong on 15/12/15.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "SMTCurrentIsDay.h"

@implementation SMTCurrentIsDay

+ (BOOL)currentTimeIsDay
{
    BOOL currentIsDay = YES;
    
    NSDate *currentDate = [NSDate date];
    
    NSDateFormatter *format1 = [[NSDateFormatter alloc] init];
    [format1 setDateFormat:@"HH:mm:ss"];
    
    NSString *dayFromString = @"05:59:59";
    NSString *nightFromString = @"19:59:59";
    
    NSString *currentTimeString = [format1 stringFromDate:currentDate];
    NSTimeInterval currentInterval = [self timeIntervalWithTime:currentTimeString];
    NSTimeInterval dayFromInterval = [self timeIntervalWithTime:dayFromString];
    NSTimeInterval nightFromInterval = [self timeIntervalWithTime:nightFromString];
    if (currentInterval>dayFromInterval&&currentInterval<nightFromInterval) {
        currentIsDay = YES;
    }else {
        currentIsDay = NO;
    }
    return currentIsDay;
}

+ (NSTimeInterval)timeIntervalWithTime:(NSString *)time
{
    NSTimeInterval timeInterval = 0;
    NSArray *timeArray = [time componentsSeparatedByString:@":"];
    
    if (timeArray.count>=3) {
        timeInterval = 60*60*[timeArray[0] intValue]+60*[timeArray[1] intValue]+[timeArray[2] intValue];
    }
    return timeInterval;
}

@end
