//
//  SignView.m
//  TestNetwork
//
//  Created by sa.xiong on 15/9/12.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "SignView.h"
#import "SMTCurrentIsDay.h"

static CGFloat const kSpace = 15;
static CGFloat const kOriginY = 12;

static CGFloat const kLabelHeight = 20;

@interface SignView()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIButton *authorNameButton;
@property (nonatomic, strong) UIButton *signButton;
@end

@implementation SignView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        [self configureUI];
        if ([SMTCurrentIsDay currentTimeIsDay]) {
            self.authorNameButton.titleLabel.textColor = kTEXT_COLOR_DAY;
        }else {
            self.authorNameButton.titleLabel.textColor = kTEXT_COLOR_NIGHT;
        }
    }
    return self;
}

- (void)showSignViewDataWithAuthorName:(NSString *)authorName sign:(NSString *)sign
{
    [self configureFrameWithAuthorName:authorName sign:sign];

    [self.authorNameButton setTitle:authorName forState:UIControlStateNormal];
   
    NSString *resultSign = [NSString stringWithFormat:@"  %@  ",sign];
    [self.signButton setTitle:resultSign forState:UIControlStateNormal];
    
}

- (void)handleSignButton
{
    if (self.signLabelTapBlock)
    {
        self.signLabelTapBlock();
    }
}

- (void)handleAuthorNameButton
{
    if (self.authorNameTapBlock)
    {
        self.authorNameTapBlock();
    }
}

- (void)configureUI
{
    [self addSubview:self.authorNameButton];
    [self addSubview:self.signButton];
}

/**
 *  宽度是自动变化的，如何写约束呢
 */

- (void)configureFrameWithAuthorName:(NSString *)authorName sign:(NSString *)sign
{
    [self.signButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(kOriginY);
            make.height.mas_equalTo(kLabelHeight);
        if (sign==nil) {
            make.right.mas_equalTo(self.mas_right);
            make.width.mas_equalTo(0);
        }else {
            make.right.mas_equalTo(self.mas_right).offset(-kSpace);
        }
            
    }];
    [self.authorNameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kOriginY);
        if (sign == nil) {
            make.right.mas_equalTo(self.mas_right).offset(-kSpace);
        }else
            make.right.mas_equalTo(self.signButton.mas_left).offset(-kSpace);
        
        make.height.mas_equalTo(kLabelHeight);
        if (authorName == nil) {
            make.width.mas_equalTo(0);
        }
    }];
}


- (UIButton *)authorNameButton
{
    if (!_authorNameButton)
    {
        _authorNameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_authorNameButton setTitleColor:kTEXT_COLOR_NIGHT forState:UIControlStateNormal];
        _authorNameButton.titleLabel.font = kFONT_AUTHORNAME;
        [_authorNameButton addTarget:self action:@selector(handleAuthorNameButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _authorNameButton;
}

- (UIButton *)signButton
{
    if (!_signButton)
    {
        _signButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _signButton.layer.cornerRadius = 10;
        [_signButton setBackgroundColor:[self randomColor]];
        _signButton.titleLabel.font = kFONT_MAIN;
        [_signButton addTarget:self action:@selector(handleSignButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _signButton;
}


/**
 * 文章标签需要不同的颜色 如何随机的分配颜色
 *
 *  @return 标签label
 */
/**
 *  如何生成一个随机颜色，且不能为白色
 *
 *  @return <#return value description#>
 */
- (UIColor *) randomColor
{
    CGFloat red = (arc4random()%256/255.0);
    CGFloat green = (arc4random()%256/255.0);
    CGFloat blue = (arc4random()%256/255.0);
    if (red == 1.0&&green == 1.0&&blue == 1.0 ) {
        green = 0.5;
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
