//
//  TitleView.m
//  Feature
//
//  Created by sa.xiong on 15/9/14.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "TitleView.h"

@interface TitleView()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *authorLabel;
@end

@implementation TitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self configureUI];
        [self configureFrame];
    }
    return self;
}

- (void)setArticleTitle:(NSString *)title Author:(NSString *)author
{
    self.titleLabel.text = title;
    self.authorLabel.text = author;
}

- (void)configureUI
{
    [self addSubview:self.titleLabel];
    [self addSubview:self.authorLabel];
}

- (void)configureFrame
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(kSpaceY/2);
        make.top.mas_equalTo(kSpaceX);
        make.right.mas_equalTo(-kSpaceX);
    
    }];
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        
        [_titleLabel setFont:kFONT_TITLE];
    }
    return _titleLabel;
}

- (UILabel *)authorLabel
{
    if (!_authorLabel)
    {
        _authorLabel = [[UILabel alloc] init];
        [_authorLabel setFont:kFONT_TITLE];
        [_authorLabel setBackgroundColor:UIColorFromHex(0x7bb1d7)];
    }
    return _authorLabel;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
