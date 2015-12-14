//
//  SMTContentView.m
//  Feature
//
//  Created by sa.xiong on 15/12/12.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "SMTContentView.h"
#import "DigestModel.h"

@interface SMTContentView()

@property (nonatomic, strong) UILabel *cardTitleLabel;
@property (nonatomic, strong) UILabel *cardRemarkLabel;
@property (nonatomic, strong) UIImageView *cardImageView;
@end

@implementation SMTContentView

- (id)initWithCardType:(CardType)cardType
{
    if (self = [super init]) {
        [self configureUIWithCardType:cardType];
        [self configureFrameWithCardType:cardType];
    }
    return self;
}


- (void)showContentViewWithCardType:(CardType)type DigestModel:(DigestModel *)model
{
    
    self.cardTitleLabel.text = model.cardTitle;
    
    if (type == CardTypeText) {
        self.cardRemarkLabel.text = model.cardRemark;
    }else if (type == CardTypeImage) {
        
        [self.cardImageView sd_setImageWithURL:[NSURL URLWithString:model.pic1Path] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageProgressiveDownload];
        
    }else {
        
        self.cardRemarkLabel.text = model.cardRemark;
        [self.cardImageView sd_setImageWithURL:[NSURL URLWithString:model.pic1Path] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageProgressiveDownload];
    }
}

- (void)configureUIWithCardType:(CardType)type
{
    self.cardTitleLabel = [self factoryForLabelWithFont:kCardTitleFont textColor:kCardTitleTextColor];
    [self addSubview:self.cardTitleLabel];
    
    if (type == CardTypeText) {
        self.cardRemarkLabel = [self factoryForLabelWithFont:kCardRemarkFont textColor:kCardRemarkTextColor];
        [self addSubview:self.cardRemarkLabel];
    }else if (type == CardTypeImage) {
        [self addSubview:self.cardImageView];
    }else
    {
        self.cardRemarkLabel = [self factoryForLabelWithFont:kCardRemarkFont textColor:kCardRemarkTextColor];
        [self addSubview:self.cardRemarkLabel];
        [self addSubview:self.cardImageView];
    }
}

- (void)configureFrameWithCardType:(CardType)type
{
    [self.cardTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make){
    
        make.top.mas_equalTo(self.mas_top);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(self.mas_width).offset(-2*kSpaceX);
    }];

    if (type == CardTypeText) {
        [self.cardRemarkLabel mas_remakeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(self.cardTitleLabel.mas_bottom).offset(kSpaceY/2);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.width.mas_equalTo(self.mas_width).offset(-2*kSpaceX);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
    }else if (type == CardTypeImage)
    {
        [self.cardImageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(self.cardTitleLabel.mas_bottom).offset(kSpaceY/2);
            make.width.mas_equalTo(self.mas_width);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
    }else
    {
        [self.cardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.cardTitleLabel.mas_bottom).offset(kSpaceY/2);
            make.right.mas_equalTo(self.mas_right).offset(-kSpaceX);
            make.bottom.mas_equalTo(self.mas_bottom);
            make.size.width.mas_equalTo(self.cardImageView.mas_height);
        }];
        
        [self.cardRemarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.cardImageView.mas_top);
            make.right.mas_equalTo(self.cardImageView.mas_left).offset(-kSpaceX);
            make.left.mas_equalTo(self.mas_left).offset(kSpaceX);
            make.bottom.mas_equalTo(self.mas_bottom);
            
        }];
    }

}


/**
 *  大图片直接放置
 *  小图片似乎有个边缘翘起且有阴影的特殊效果
 *
 *  @return imageview
 */
- (UIImageView *)cardImageView
{
    if (!_cardImageView)
    {
        _cardImageView = [[UIImageView alloc] init];
        [[_cardImageView layer] setShadowOffset:CGSizeMake(5, 5)]; //设置阴影起点位置
        
        [[_cardImageView layer] setShadowRadius:6];                       //设置阴影扩散程度
        
        [[_cardImageView layer] setShadowOpacity:1];                      //设置阴影透明度
        
        [[_cardImageView layer] setShadowColor:[UIColor grayColor].CGColor]; //设置阴影颜色
        
    }
    return _cardImageView;
}

- (UILabel *)factoryForLabelWithFont:(UIFont *)font textColor:(UIColor *)textColor
{
    UILabel *lbl = [[UILabel alloc] init];
    lbl.font = font;
    lbl.textColor = textColor;
    lbl.numberOfLines = 0;
    lbl.lineBreakMode = NSLineBreakByCharWrapping;
    return lbl;
}

@end
