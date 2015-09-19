//
//  CardCell.m
//  TestNetwork
//
//  Created by sa.xiong on 15/9/11.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "CardCell.h"
#import "SignView.h"
#import "DigestModel.h"

/**
 kHeight 是signView和cardTitleLabel的高度
 */
static CGFloat const kHeight = 40;
static CGFloat const kSpaceX = 20;
static CGFloat const kSpaceY = 20;
static CGFloat const kSmallImageWidth = 100;


#define kCardTitleFont       [UIFont systemFontOfSize:20]
#define kCardRemarkFont       [UIFont systemFontOfSize:14]
#define kCardTitleTextColor     [UIColor blackColor]
#define kCardRemarkTextColor     [UIColor lightGrayColor]



@interface CardCell()


@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) SignView *signView;
@property (nonatomic, strong) UILabel *cardTitleLabel;
@property (nonatomic, strong) UILabel *cardRemarkLabel;
@property (nonatomic, strong) UIImageView *cardImageView;

@end


@implementation CardCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(CardCellType)cellType
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.contentView.backgroundColor = UIColorFromHex(0xfefefe);
        self.cardType = cellType;
        [self configureUI];
    }
    return self;
}

- (void)showDataForCellType:(CardCellType)type WithDataModel:(DigestModel *)model
{
    [self configureFrame];

    if (type == CardCellTypeText)
    {
        [self settingCommonData:model];
        [self.cardRemarkLabel setText:model.cardRemark];
        
    }else if (type == CardCellTypeMixture)
    {
        [self settingCommonData:model];
        [self.cardRemarkLabel setText:model.cardRemark];
        [self.cardImageView sd_setImageWithURL:[NSURL URLWithString:model.pic1Path] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageProgressiveDownload];
    }else
    {
        [self settingCommonData:model];
        [self.cardImageView sd_setImageWithURL:[NSURL URLWithString:model.pic1Path] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageProgressiveDownload];

    }
    

}

- (void)settingCommonData:(DigestModel *)model
{
    NSArray *authorList = model.authorList;
    AuthorModel *authorModel = authorList[0];
    NSArray *signList = model.signList;
    SignModel *signModel = signList[0];
    [self.signView showSignViewDataWithAuthorName:authorModel.name sign:signModel.name];
    
    
    [self.cardTitleLabel setText:model.cardTitle];
}

- (void)configureUI
{
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.signView];
    
    [self commonSetForLabel:self.cardTitleLabel];
    
    if (self.cardType == CardCellTypeImage)
    {
        // 只有一张图
        [self.contentView addSubview:self.cardImageView];
    }else if(self.cardType == CardCellTypeText)
    {
         [self commonSetForLabel:self.cardRemarkLabel];
    }else
    {
        [self commonSetForLabel:self.cardRemarkLabel];
        [self.backView addSubview:self.cardImageView];
    }
    
}

- (void)commonSetForLabel:(UILabel *)lbl
{
    if (lbl == self.cardTitleLabel)
    {
        self.cardTitleLabel = [self factoryForLabel];
        [self.cardTitleLabel setFont:kCardTitleFont];
        [self.cardTitleLabel setTextColor:kCardTitleTextColor];
        [self.contentView addSubview:self.cardTitleLabel];
    }else
    {
        // 左侧文字，右侧图片
        self.cardRemarkLabel = [self factoryForLabel];
        [self.cardRemarkLabel setFont:kCardRemarkFont];
        [self.cardRemarkLabel setTextColor:kCardRemarkTextColor];
        self.cardRemarkLabel.numberOfLines = 0;
        self.cardRemarkLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self.contentView addSubview:self.cardRemarkLabel];
        
    }
}

- (void)configureFrame
{
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
  
        make.edges.mas_equalTo(UIEdgeInsetsMake(kSpaceY/4, 0, kSpaceY/4, 0));
    }];
    
    [self.signView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.mas_top);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(kHeight);
    }];
    
    [self.cardTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.signView.mas_bottom);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(self.mas_width).offset(-2*kSpaceX);
        make.height.mas_equalTo(kHeight);
        
    }];
    
    if (self.cardType == CardCellTypeImage)
    {
        [self.cardImageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(self.cardTitleLabel.mas_bottom).offset(kSpaceY/2);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.width.mas_equalTo(self.mas_width);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-kSpaceY/2);
            
        }];
        
    }else if (self.cardType == CardCellTypeText)
    {
        [self.cardRemarkLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(self.cardTitleLabel.mas_bottom).offset(kSpaceY/2);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.width.mas_equalTo(self.mas_width).offset(-2*kSpaceX);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-kSpaceY/2);

        }];
    }else
    {

        [self.cardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.cardTitleLabel.mas_bottom).offset(kSpaceY/2);
            make.right.mas_equalTo(self.mas_right).offset(-kSpaceX);
            make.size.mas_equalTo(kSmallImageWidth);
            make.size.mas_equalTo(CGSizeMake(kSmallImageWidth,kSmallImageWidth)).priorityMedium();
            make.bottom.mas_equalTo(self.mas_bottom).offset(-kSpaceY/2);
        }];
        
        [self.cardRemarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.cardTitleLabel.mas_bottom).offset(kSpaceY/2);
            make.right.mas_equalTo(self.cardImageView.mas_left).offset(-kSpaceX);
            make.left.mas_equalTo(self.mas_left).offset(kSpaceX);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-kSpaceY/2);

        }];
    }
    
}

- (UIView *)backView
{
    if (!_backView)
    {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = UIColorFromHex(0xefefef);
    }
    return _backView;
}

- (SignView *)signView
{
    if (!_signView)
    {
        _signView = [[SignView alloc] init];
        __weak typeof(self) weakSelf = self;
        
        _signView.authorNameTapBlock = ^(){
            if (weakSelf.toAuthorPageBlock)
            {
                weakSelf.toAuthorPageBlock();
            }
            // 点击进入对应标签的列表✌️
            NSLog(@"点击进入对应标签的列表✌️");
            
        };
        _signView.signLabelTapBlock = ^(){
            if (weakSelf.toSignPageBlock)
            {
                weakSelf.toSignPageBlock();
            }
            NSLog(@"点击进入标签页面");
        };
    }
    return _signView;
}

- (UILabel *)factoryForLabel
{
    UILabel *lbl = [[UILabel alloc] init];
    return lbl;
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


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
