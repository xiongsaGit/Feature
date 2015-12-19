//
//  SMTBaseView.m
//  Feature
//
//  Created by sa.xiong on 15/12/18.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "SMTBaseView.h"

@implementation SMTBaseView

- (id)init {
    if (self = [super init]) {
        NSLog(@"SMTBaseView");
        self.backgroundColor = [SMTTheme viewBackgroundColor];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
