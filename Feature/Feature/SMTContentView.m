//
//  SMTContentView.m
//  Feature
//
//  Created by sa.xiong on 15/12/12.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "SMTContentView.h"
#import "DigestModel.h"
#import "SMTCurrentIsDay.h"

@interface SMTContentView()

@property (nonatomic, strong) UILabel *cardTitleLabel;
@property (nonatomic, strong) UILabel *cardRemarkLabel;
@property (nonatomic, strong) UIImageView *cardImageView;

@property (nonatomic, strong) UIImageView *pic1ImageView;
@property (nonatomic, strong) UIImageView *pic2ImageView;
@property (nonatomic, strong) UIImageView *pic3ImageView;


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
    self.backgroundColor = [SMTTheme viewBackgroundColor];
    self.cardTitleLabel.textColor = [SMTTheme cardTitleColor];
   
    self.cardTitleLabel.text = model.cardTitle;
    
    if (type == CardTypeText) {
        self.cardRemarkLabel.text = model.cardRemark;
    }else if (type == CardTypeImage) {
        [self downloadToImageView:self.cardImageView withPicPath:model.pic1Path];
    }else if(type == CardTypeMixture) {
        [self downloadToImageView:self.cardImageView withPicPath:model.pic1Path];
        self.cardRemarkLabel.text = model.cardRemark;
    }else
    {
        // 多张图片
        [self downloadToImageView:self.pic1ImageView withPicPath:model.smallPic1Path];
        [self downloadToImageView:self.pic2ImageView withPicPath:model.smallPic2Path];
        [self downloadToImageView:self.pic3ImageView withPicPath:model.smallPic3Path];

    }
}

- (void)configureUIWithCardType:(CardType)type
{
    self.cardTitleLabel = [self factoryForLabelWithFont:kCardTitleFont textColor:kCardTitleTextColor];
    [self addSubview:self.cardTitleLabel];
    
    if (type == CardTypeText) {
        [self addCardRemarkLabel];
    }else if (type == CardTypeImage) {
        self.cardImageView = [self factoryForImageView];
        [self addSubview:self.cardImageView];
    }else if (type == CardTypeMixture)
    {
        [self addCardRemarkLabel];
        self.cardImageView = [self factoryForImageView];
        [self addSubview:self.cardImageView];
    }else {
        self.pic1ImageView = [self factoryForImageView];
        self.pic2ImageView = [self factoryForImageView];
        self.pic3ImageView = [self factoryForImageView];
        [self addSubview:self.pic1ImageView];
        [self addSubview:self.pic2ImageView];
        [self addSubview:self.pic3ImageView];

    }
}

/*
 *  CardTypeMutilImages时，标题不展示，连标题背景色也没有
 *
 */

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
    }
    else if (type == CardTypeImage) {
        [self.cardImageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(self.cardTitleLabel.mas_bottom).offset(kSpaceY/2);
            make.width.mas_equalTo(self.mas_width);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
    }else if (type == CardTypeMixture) {
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
    else {
        [self.pic1ImageView mas_remakeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(self.cardTitleLabel.mas_bottom).offset(kSpaceY/2);
            make.bottom.mas_equalTo(self.mas_bottom);
            make.left.mas_equalTo(self.mas_left).offset(kSpaceX/2);
            make.right.mas_equalTo(self.pic2ImageView.mas_left).offset(-kSpaceX/2);
            make.width.mas_equalTo(self.pic2ImageView.mas_width);
            
        }];
        [self.pic2ImageView mas_remakeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(self.pic1ImageView.mas_top);
            make.bottom.mas_equalTo(self.mas_bottom);
            make.left.mas_equalTo(self.pic1ImageView.mas_right).offset(kSpaceX/2);
            make.right.mas_equalTo(self.pic3ImageView.mas_left).offset(-kSpaceX/2);
            make.width.mas_equalTo(self.pic3ImageView.mas_width);
        }];
        [self.pic3ImageView mas_remakeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(self.pic1ImageView.mas_top);
            make.bottom.mas_equalTo(self.mas_bottom);
            make.left.mas_equalTo(self.pic2ImageView.mas_right).offset(kSpaceX/2);
            make.right.mas_equalTo(self.mas_right).offset(-kSpaceX/2);
            make.width.mas_equalTo(self.pic1ImageView.mas_width);

        }];
    }
}

#pragma mark - 下载图片
- (void)downloadToImageView:(UIImageView *)imageView withPicPath:(NSString *)picPath
{
    [imageView sd_setImageWithURL:[NSURL URLWithString:picPath] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageProgressiveDownload];
}

#pragma mark - 添加配文说明
- (void)addCardRemarkLabel
{
    self.cardRemarkLabel = [self factoryForLabelWithFont:kCardRemarkFont textColor:kCardRemarkTextColor];
    [self addSubview:self.cardRemarkLabel];
}

/**
 *  大图片直接放置
 *  小图片似乎有个边缘翘起且有阴影的特殊效果
 *
 *  @return imageview
 */
- (UIImageView *)factoryForImageView {
    UIImageView *imageView = [[UIImageView alloc] init];
    [[imageView layer] setShadowOffset:CGSizeMake(5, 5)]; //设置阴影起点位置
    [[imageView layer] setShadowRadius:6];                       //设置阴影扩散程度
    [[imageView layer] setShadowOpacity:1];                      //设置阴影透明度
    [[imageView layer] setShadowColor:[UIColor grayColor].CGColor]; //设置阴影颜色
    return imageView;
}



//- (UIImageView *)cardImageView
//{
//    if (!_cardImageView)
//    {
//        _cardImageView = [[UIImageView alloc] init];
//        [[_cardImageView layer] setShadowOffset:CGSizeMake(5, 5)]; //设置阴影起点位置
//        
//        [[_cardImageView layer] setShadowRadius:6];                       //设置阴影扩散程度
//        
//        [[_cardImageView layer] setShadowOpacity:1];                      //设置阴影透明度
//        
//        [[_cardImageView layer] setShadowColor:[UIColor grayColor].CGColor]; //设置阴影颜色
//        
//    }
//    return _cardImageView;
//}

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
