//
//  TitleView.m
//  Feature
//
//  Created by sa.xiong on 15/9/14.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "TitleView.h"
#import "AuthorModel.h"

@interface TitleView()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *authorButton;
@property (nonatomic, copy) TitleViewClickToAuthorListBlock toAuthorListBlock;
@property (nonatomic, strong) AuthorModel *authorModel;

@end

@implementation TitleView

- (id)initWithToAuthorListBlock:(TitleViewClickToAuthorListBlock)toAuthorListBlock
{
    if (self = [super init]) {
        [self configureUI];
        [self configureFrame];
        self.toAuthorListBlock = toAuthorListBlock;
    }
    return self;
}

- (void)setTitleViewDataWithDigestDetailModel:(SMTDigestDetailModel *)detailModel {
    AuthorModel *authorModel = detailModel.authorList[0];
    self.authorModel = authorModel;
    
    self.titleLabel.text = detailModel.cardTitle;
    [self.authorButton setTitleColor:UIColorFromHex(0x4d81a6) forState:UIControlStateNormal];
    [self.authorButton setTitle:[NSString stringWithFormat:@"文/%@",authorModel.name] forState:UIControlStateNormal];
}

- (void)handleAuthorButtonClicked:(UIButton *)button
{
    if (self.toAuthorListBlock) {
        self.toAuthorListBlock(self.authorModel);
    }
}

- (void)configureUI
{
    [self addSubview:self.titleLabel];
    [self addSubview:self.authorButton];
}

- (void)configureFrame
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(kSpaceY/2);
        make.left.mas_equalTo(kSpaceX);
        make.right.mas_equalTo(-kSpaceX);
    
    }];
    
    [self.authorButton mas_remakeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(kSpaceX/2);
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.right.mas_equalTo(self.titleLabel.mas_right);
        make.height.mas_equalTo(kHEIGHT_OF_LABEL);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-kSpaceX/2);
    }];
    
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        [_titleLabel setFont:kCardTitleFont];
    }
    return _titleLabel;
}

- (UIButton *)authorButton
{
    if (!_authorButton)
    {
        _authorButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_authorButton.titleLabel setFont:kFONT_TITLE];
        _authorButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        _authorButton.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
        [_authorButton addTarget:self action:@selector(handleAuthorButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _authorButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
