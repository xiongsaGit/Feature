//
//  SMTRandomColor.m
//  Feature
//
//  Created by sa.xiong on 15/12/16.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "SMTRandomColor.h"

/**
 *  如何生成一个随机颜色，且不能为白色
 *
 *  @return <#return value description#>
 */
@implementation SMTRandomColor

+ (UIColor *) randomColor
{
    CGFloat red = (arc4random()%256/255.0);
    CGFloat green = (arc4random()%256/255.0);
    CGFloat blue = (arc4random()%256/255.0);
    if (red == 1.0&&green == 1.0&&blue == 1.0 ) {
        green = 0.5;
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}

@end
