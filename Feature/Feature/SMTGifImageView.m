//
//  SMTGifImageView.m
//  Feature
//
//  Created by sa.xiong on 15/12/14.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "SMTGifImageView.h"
#import "UIImage+animatedGIF.h"

@implementation SMTGifImageView

- (id)init {
    if (self = [super init]) {
        self.frame = CGRectMake((SCREEN_WIDTH-120)/2,(SCREEN_HEIGHT - 120)/2, 120, 120);

        NSURL *gifURL = [[NSBundle mainBundle] URLForResource:@"common_loading_gif" withExtension:@"gif"];
        self.image = [UIImage animatedImageWithAnimatedGIFURL:gifURL];
    }
    return self;
}

+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view animated:(BOOL)animated {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [hud setLabelText:@"努力加载中..."];
    [view addSubview:hud];
    [hud show:animated];
    return MB_AUTORELEASE(hud);
}

+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated {
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    if (hud != nil) {
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:animated];
        return YES;
    }
    return NO;
}



+ (void)showGifAddedTo:(UIView *)view
{

}

+ (void)hideGifInView:(UIView *)view
{
    
}


@end
