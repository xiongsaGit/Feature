//
//  SignView.m
//  TestNetwork
//
//  Created by sa.xiong on 15/9/12.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "SignView.h"

static CGFloat const kSpace = 10;
static CGFloat const kOriginY = 12;

static CGFloat const kLabelHeight = 20;
#define kSignFont   [UIFont systemFontOfSize:14]

@interface SignView()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UILabel *authorNameLabel;
@property (nonatomic, strong) UILabel *signLabel;

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
        [self configureFrame];
        
    }
    return self;
}

- (void)showSignViewDataWithAuthorName:(NSString *)authorName sign:(NSString *)sign
{
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
- (void)configureFrame
{
    [self.signButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(kOriginY);
        make.right.mas_equalTo(-kSpace);
        make.height.mas_equalTo(kLabelHeight);

    }];
    
    [self.authorNameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kOriginY);

        make.right.mas_equalTo(self.signButton.mas_left).offset(-kSpace);
        
        make.height.mas_equalTo(kLabelHeight);
    }];
}

- (UIButton *)authorNameButton
{
    if (!_authorNameButton)
    {
        _authorNameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_authorNameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_authorNameButton addTarget:self action:@selector(handleAuthorNameButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _authorNameButton;
}

- (UIButton *)signButton
{
    if (!_signButton)
    {
        _signButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_signButton setBackgroundColor:[UIColor redColor]];
//        [_signButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
        _signButton.layer.cornerRadius = 8;
        [_signButton setBackgroundColor:[self randomColor]];
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
