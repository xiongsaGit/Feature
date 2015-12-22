//
//  SMTNetworkErrorView.h
//  Feature
//
//  Created by sa.xiong on 15/12/22.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReloadBlock)();

@interface SMTNetworkErrorView : UIView


+ (void)showNetworkErrorViewWithReloadBlock:(ReloadBlock)reloadBlock toView:(UIView *)view;
+ (void)hideNetworkErrorViewToView:(UIView *)view;


@end
