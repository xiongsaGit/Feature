//
//  LeftMenuView.m
//  TestNetwork
//
//  Created by sa.xiong on 15/9/10.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "LeftMenuView.h"
#import "TimerView.h"

@interface LeftMenuView()<UIGestureRecognizerDelegate>
{
    UIView * _coverView;
    CGRect _closeRect;
}
@property (nonatomic, strong) UIView *backgroundView;
// 反馈信息按钮
@property (nonatomic, strong) UIButton *feedbackBtn;
// 返回白天按钮
@property (nonatomic, strong) UIButton *returnDayBtn;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *appNameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) TimerView *timerView;
@end

@implementation LeftMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setBackgroundColor:kCOLOR_MENU_BACKGROUND];
        self.isOpen = NO;
        
        [self configureUI];
        [self configureFrame];

    }
    return self;
}

- (void)gradientLayer
{
   CAGradientLayer  *gradientLayer = [CAGradientLayer layer];  // 设置渐变效果
    gradientLayer.bounds = self.backgroundView.bounds;
    gradientLayer.borderWidth = 0;
    
    gradientLayer.frame = self.backgroundView.bounds;
    gradientLayer.colors = [NSArray arrayWithObjects:
                             (id)[[UIColor clearColor] CGColor],
                             (id)[[UIColor blackColor] CGColor],nil];
    gradientLayer.startPoint = CGPointMake(0.5, 0.5);
    gradientLayer.endPoint = CGPointMake(0.5, 1.0);
    
    [self.backgroundView.layer insertSublayer:gradientLayer atIndex:0];
}

/*
 _layerView = [[UIView alloc] initWithFrame:CGRectMake(0, 320-100, 320, 100)];
 
 _gradientLayer = [CAGradientLayer layer];  // 设置渐变效果
 _gradientLayer.bounds = _layerView.bounds;
 _gradientLayer.borderWidth = 0;
 
 _gradientLayer.frame = _layerView.bounds;
 _gradientLayer.colors = [NSArray arrayWithObjects:
 (id)[[UIColor clearColor] CGColor],
 (id)[[UIColor blackColor] CGColor], nil nil];
 _gradientLayer.startPoint = CGPointMake(0.5, 0.5);
 _gradientLayer.endPoint = CGPointMake(0.5, 1.0);
 
 [_layerView.layer insertSublayer:_gradientLayer atIndex:0];
 
 */


/* 检测室day还是night
 * 控制 返回白天  按钮是否显示--返回白天（距白天来临还有+倒计时），进入黑夜（倒计时不展示）
 * 同时,timeLabel展示不同（1）距夜幕降临还有 (2)距白天到来还有
 */

- (void)configureUI
{
    UISwipeGestureRecognizer *swipeGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGesture:)];
    swipeGes.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipeGes];
    
    self.backgroundView = [[UIView alloc] init];
    [self addSubview:self.backgroundView];
    
    [self gradientLayer];
    
    self.feedbackBtn = [self factortyForButtonWithTitle:@"反馈信息" selectorString:@"handleFeedbackButtonClick:" tag:kFEEDBACK_TAG];
    self.returnDayBtn = [self factortyForButtonWithTitle:@"返回白天" selectorString:@"handleFeedbackButtonClick:" tag:kRETURN_DAY_TAG];
    [self.backgroundView addSubview:self.feedbackBtn];
    [self.backgroundView addSubview:self.returnDayBtn];
    
    self.iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"head"]];
    self.iconImageView.layer.cornerRadius = CGRectGetWidth(self.iconImageView.frame)/2;
    self.appNameLabel = [self factoryForLabelWithTitle:@"翻篇儿" textColor:kCOLOR_BACKGROUND fontSize:20];
    self.timeLabel = [self factoryForLabelWithTitle:@"距夜幕降临还有" textColor:[UIColor lightGrayColor] fontSize:13];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.backgroundView addSubview:self.iconImageView];
    
    [self.backgroundView addSubview:self.appNameLabel];
    
    [self.backgroundView addSubview:self.timeLabel];
    
    [self.backgroundView addSubview:self.timerView];

}


- (void)configureFrame
{
    [self.backgroundView mas_remakeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.mas_top);
        make.size.mas_equalTo(self.frame.size);
    }];
    [self.feedbackBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(60, 25));
    }];

    [self.returnDayBtn mas_remakeConstraints:^(MASConstraintMaker *make){
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(60, 25));
    }];
    
    [self.iconImageView mas_remakeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.feedbackBtn.mas_bottom).offset(30);
    }];
    
    [self.appNameLabel mas_remakeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.iconImageView.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
    }];
    
    [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(30);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-60);
    }];
    
    [self.timerView mas_remakeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
        make.centerX.mas_equalTo(self.mas_centerX);

    }];
    
    
}


-(void)showFrame:(CGRect)rect
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification object:nil]; //监听是否触发home键挂起程序.
    
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
    [self.timerView openTimer];

}

- (void)applicationWillResignActive:(NSNotification *)notification
{
    [self closeFrame:_closeRect];
}

-(void)closeFrame:(CGRect)rect
{
    
    [self.timerView closeTimer];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = _closeRect;
        _coverView.alpha = 0;
    } completion:^(BOOL finished) {
        self.isOpen = NO;
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

- (void)handleFeedbackButtonClick:(UIButton *)btn
{
    if (self.buttonClickBlock)
    {
        self.buttonClickBlock(btn);
    }
}

- (UIButton *)factortyForButtonWithTitle:(NSString *)title selectorString:(NSString *)selectorString tag:(NSInteger)btnTag
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.layer.borderColor = [UIColor whiteColor].CGColor;
    btn.layer.borderWidth = 1;
    btn.layer.cornerRadius = 4;
    btn.layer.masksToBounds = YES;
    btn.titleLabel.adjustsFontSizeToFitWidth = YES;
    btn.tag = btnTag;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn addTarget:self action:NSSelectorFromString(selectorString) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}


- (UILabel *)factoryForLabelWithTitle:(NSString *)title textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize
{
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:fontSize];
    return label;
}

- (TimerView *)timerView
{
    if (!_timerView) {
        _timerView = [[TimerView alloc] init];
    }
    return _timerView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
