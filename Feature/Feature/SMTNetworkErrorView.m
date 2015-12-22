//
//  SMTNetworkErrorView.m
//  Feature
//
//  Created by sa.xiong on 15/12/22.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "SMTNetworkErrorView.h"

@interface SMTNetworkErrorView()<UIGestureRecognizerDelegate>
@property (nonatomic, copy)ReloadBlock reloadBlock;
@property (nonatomic, strong) UIImageView *errorImageView;
@property (nonatomic, strong) UILabel *errorMsgLabel;
@end

@implementation SMTNetworkErrorView

+ (void)showNetworkErrorViewWithReloadBlock:(ReloadBlock)reloadBlock toView:(UIView *)view {
    SMTNetworkErrorView *errorView = [[SMTNetworkErrorView alloc] initWithReloadBlock:reloadBlock];
    [view addSubview:errorView];
    [view bringSubviewToFront:errorView];
}

+ (void)hideNetworkErrorViewToView:(UIView *)view {

    for (id temp in view.subviews) {
        if ([temp isKindOfClass:[SMTNetworkErrorView class]]) {
            [temp removeFromSuperview];
        }
    }
}


- (id)initWithReloadBlock:(ReloadBlock)reloadBlock {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.reloadBlock = reloadBlock;
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [self addGestureRecognizer:tapGes];
        
        self.errorImageView.center = self.center;
        [self addSubview:self.errorImageView];
        
    }
    return self;
}

- (void)handleTapGesture:(UITapGestureRecognizer *)tgr {
    if (self.reloadBlock) {
        self.reloadBlock();
    }
}


- (UIImageView *)errorImageView
{
    if (!_errorImageView)
    {
        _errorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"networkErro_selected"]];
        
    }
    return _errorImageView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
