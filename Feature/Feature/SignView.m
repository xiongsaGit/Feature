//
//  SignView.m
//  TestNetwork
//
//  Created by sa.xiong on 15/9/12.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "SignView.h"

static CGFloat const kSpace = 10;
static CGFloat const kOriginY = 10;

static CGFloat const kLabelHeight = 20;
#define kSignFont   [UIFont systemFontOfSize:14]

@interface SignView()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UILabel *authorNameLabel;
@property (nonatomic, strong) UILabel *signLabel;
@end

@implementation SignView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
        [self configureUI];
        [self configureFrame];
        
    }
    return self;
}

- (void)showSignViewDataWithAuthorName:(NSString *)authorName sign:(NSString *)sign
{
    [self.authorNameLabel setText:authorName];
    [self.signLabel setText:sign];
}


- (void)handleTapGestureInSignLabel
{
    if (self.signLabelTapBlock)
    {
        self.signLabelTapBlock();
    }
}

- (void)handleTapGestureInAuthorNameLabel
{
    if (self.authorNameTapBlock)
    {
        self.authorNameTapBlock();
    }
}

- (void)configureUI
{
    [self addSubview:self.authorNameLabel];
    [self addSubview:self.signLabel];
}

/**
 *  宽度是自动变化的，如何写约束呢
 */
- (void)configureFrame
{
    [self.signLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(kOriginY);
        make.right.mas_equalTo(-kSpace);
        make.height.mas_equalTo(kLabelHeight);

    }];
    
    [self.authorNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kOriginY);

        make.right.mas_equalTo(self.signLabel.mas_left).offset(-kSpace);
        
        make.height.mas_equalTo(kLabelHeight);
    }];
}


/**
 * 文章标签需要不同的颜色 如何随机的分配颜色
 *
 *  @return 标签label
 */
- (UILabel *)signLabel
{
    if (!_signLabel)
    {
        _signLabel = [[UILabel alloc] init];
        _signLabel.layer.cornerRadius = 5;
        _signLabel.layer.masksToBounds = YES;
        _signLabel.font = [UIFont systemFontOfSize:14];
        [_signLabel setBackgroundColor:[self randomColor]];
        [_signLabel setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureInSignLabel)];
        [_signLabel addGestureRecognizer:tapGes];
    }
    return _signLabel;
}

- (UILabel *)authorNameLabel
{
    if (!_authorNameLabel)
    {
        _authorNameLabel = [[UILabel alloc] init];
        _authorNameLabel.backgroundColor = [UIColor clearColor];
        [_authorNameLabel setFont:kSignFont];
        [_authorNameLabel setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureInAuthorNameLabel)];
        [_authorNameLabel addGestureRecognizer:tapGes];
    }
    return _authorNameLabel;
}


/**
 *  如何生成一个随机颜色，且不能为白色
 *
 *  @return <#return value description#>
 */
- (UIColor *) randomColor

{
    
    CGFloat red = (arc4random()%255/255.0);
    CGFloat green = (arc4random()%255/255.0);
    CGFloat blue = (arc4random()%255/255.0);

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
