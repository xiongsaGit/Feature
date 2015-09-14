//
//  LeftMenuView.m
//  TestNetwork
//
//  Created by sa.xiong on 15/9/10.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "LeftMenuView.h"

@interface LeftMenuView()<UIGestureRecognizerDelegate>
{
    UIView * _coverView;
    CGRect _closeRect;
}
@property (nonatomic, strong) UIButton *borderBtn;

@end

@implementation LeftMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        UISwipeGestureRecognizer *swipeGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGesture:)];
        swipeGes.direction = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:swipeGes];
        
        
        [self setBackgroundColor:UIColorFromHex(0x2c2c2c)];
        self.isOpen = NO;
        
        [self addSubview:self.borderBtn];
//        self.borderBtn setf
        
        [self.borderBtn mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(self.mas_left).offset(10);
            make.top.mas_equalTo(self.mas_top).offset(10);
            make.size.mas_equalTo(CGSizeMake(60, 25));
        }];
    }
    return self;
}


-(void)showFrame:(CGRect)rect
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification object:nil]; //监听是否触发home键挂起程序.
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(keyboardWillShow:)
    //                                                 name:UIKeyboardWillShowNotification
    //                                               object:nil];
    
    UIWindow * window = [[UIApplication sharedApplication]keyWindow];
    [self addCoverView];
    if (![window.subviews containsObject:self])
    {
        [window addSubview:self];

    }
    self.frame = rect;
    CGRect kRect = rect;
    kRect.origin.x = -rect.size.width;
    _closeRect = kRect;
}

- (void)applicationWillResignActive:(NSNotification *)notification
{
    [self closeFrame:_closeRect];
}



-(void)closeFrame:(CGRect)rect
{
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [UIView animateWithDuration:0.2 animations:^{
//        self.alpha = 0;
        self.frame = _closeRect;
        _coverView.alpha = 0;
    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
        self.isOpen = NO;
//        [_coverView removeFromSuperview];
    }];
}

-(void)addCoverView{
    UIWindow * window = [[UIApplication sharedApplication]keyWindow];
    if (_coverView == nil) {
        UITapGestureRecognizer  * tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeFrame:)];
        _coverView = [[UIView alloc]initWithFrame:window.bounds];
        _coverView.backgroundColor = [UIColor grayColor];
        _coverView.alpha = 0.7;
        [_coverView addGestureRecognizer:tapGes];
        [window addSubview:_coverView];
    }
    _coverView.alpha = .7;
}

- (void)handleSwipeGesture:(UIGestureRecognizer *)tgr
{
    if (self.swipeBlock)
    {
        self.swipeBlock();
    }
}

- (void)handleBorderButtonClick:(UIButton *)btn
{
    if (self.buttonClickBlock)
    {
        self.buttonClickBlock();
    }
}

- (UIButton *)borderBtn
{
    if (!_borderBtn)
    {
        _borderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _borderBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _borderBtn.layer.cornerRadius = 3;
        _borderBtn.layer.masksToBounds = YES;
        _borderBtn.backgroundColor = [UIColor blackColor];
        _borderBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_borderBtn setTitle:@"反馈意见" forState:UIControlStateNormal];
        [_borderBtn addTarget:self action:@selector(handleBorderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _borderBtn;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
