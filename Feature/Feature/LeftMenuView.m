//
//  LeftMenuView.m
//  TestNetwork
//
//  Created by sa.xiong on 15/9/10.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "LeftMenuView.h"
#import "TimerView.h"
#import "SMTCurrentIsDay.h"

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
// 控制倒计时是否展示（night时，展示“返回白天”按钮，点击后展示为"进入黑夜"，此时不展示倒计时，即showTimerView = NO）
@property (nonatomic, assign) BOOL showTimerView;
@end

@implementation LeftMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setBackgroundColor:kCOLOR_MENU_BACKGROUND];
        self.isOpen = NO;
        self.showTimerView = YES;
        [self configureUI];
        [self configureFrame];

    }
    return self;
}

/* 检测室day还是night
 * 控制 返回白天  按钮是否显示--返回白天（距白天来临还有+倒计时），进入黑夜（倒计时不展示）
 * 同时,timeLabel展示不同（1）距夜幕降临还有 (2)距白天到来还有
 */

- (void)decideToShowWhatWhenTimeIsCurrent
{
    if ([SMTCurrentIsDay currentTimeIsDay]) {
        self.timeLabel.hidden = NO;
        self.timeLabel.text = @"距夜幕降临还有";
        
        self.returnDayBtn.hidden = YES;
        
        self.timerView.hidden = NO;
        [self.timerView openTimer];

    }else {
        if (self.showTimerView) {
            self.returnDayBtn.hidden = NO;
            self.returnDayBtn.titleLabel.text = @"返回白天";
            self.timeLabel.hidden = NO;
            self.timeLabel.text = @"距白天来临还有";
            self.timerView.hidden = NO;
            [self.timerView openTimer];

        }else {
            self.returnDayBtn.hidden = NO;
            self.returnDayBtn.titleLabel.text = @"进入黑夜";
            self.timeLabel.hidden = YES;
            self.timerView.hidden = YES;
        }
    }
}

- (void)configureUI
{
    UISwipeGestureRecognizer *swipeGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGesture:)];
    swipeGes.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipeGes];
    
    self.feedbackBtn = [self factortyForButtonWithTitle:@"反馈信息" selectorString:@"handleButtonClick:" tag:kBUTTON_FEEDBACK_TAG];
    self.returnDayBtn = [self factortyForButtonWithTitle:@"返回白天" selectorString:@"handleButtonClick:" tag:kBUTTON_RETURN_DAY_TAG];
    [self addSubview:self.feedbackBtn];
    [self addSubview:self.returnDayBtn];
    
    self.iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"head"]];
    self.iconImageView.layer.cornerRadius = CGRectGetWidth(self.iconImageView.frame)/2;
    self.appNameLabel = [self factoryForLabelWithTitle:@"翻篇儿" textColor:kCOLOR_BACKGROUND fontSize:20];
    self.timeLabel = [self factoryForLabelWithTitle:@"距夜幕降临还有" textColor:[UIColor lightGrayColor] fontSize:13];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.iconImageView];
    
    [self addSubview:self.appNameLabel];
    
    [self addSubview:self.timeLabel];
    
    [self addSubview:self.timerView];
}

- (void)configureFrame
{

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
    [self decideToShowWhatWhenTimeIsCurrent];
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

- (void)handleButtonClick:(UIButton *)btn
{
    // 返回白天按钮 要把侧滑栏隐藏
    if (btn.tag == kBUTTON_RETURN_DAY_TAG) {
     
        self.showTimerView = !self.showTimerView;

        if (self.swipeBlock)
        {
            self.swipeBlock();
        }
    }
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
    btn.layer.cornerRadius = 8;
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
