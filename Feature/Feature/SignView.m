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
        [self configureUI];
    }
    return self;
}

- (void)showSignViewDataWithAuthorName:(NSString *)authorName sign:(NSString *)sign
{
    self.backgroundColor = [SMTTheme viewBackgroundColor];
    [self.authorNameButton setTitleColor:[SMTTheme detailTitleColor] forState:UIControlStateNormal];
    [self.signButton setTitleColor:[SMTTheme viewBackgroundColor] forState:UIControlStateNormal];
    [self configureFrameWithAuthorName:authorName sign:sign];

    [self.authorNameButton setTitle:authorName forState:UIControlStateNormal];
   
    NSString *resultSign = [NSString stringWithFormat:@"  %@  ",sign];
    [self.signButton setTitle:resultSign forState:UIControlStateNormal];
    
}

- (void)handleSignButton
{
    if (self.signBlock)
    {
        self.signBlock();
    }
}

- (void)handleAuthorNameButton
{
    if (self.authorNameBlock)
    {
        self.authorNameBlock();
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
        [_signButton setBackgroundColor:[SMTRandomColor randomColor]];
        _signButton.titleLabel.font = kFONT_MAIN;
        [_signButton addTarget:self action:@selector(handleSignButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _signButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
