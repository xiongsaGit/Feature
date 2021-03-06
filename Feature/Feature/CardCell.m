//
//  CardCell.m
//  TestNetwork
//
//  Created by sa.xiong on 15/9/11.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "CardCell.h"
#import "SignView.h"
#import "SMTContentView.h"
#import "DigestModel.h"
#import "SMTCurrentIsDay.h"

@interface CardCell()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) SignView *signView;
@property (nonatomic, strong) SMTContentView *cardView;

@end


@implementation CardCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(CardType)cellType
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.cardType = cellType;
        [self configureUI];
        [self configureFrame];
    
    }
    return self;
}

//- (void)setDigestModel:(DigestModel *)digestModel {
//    _digestModel = digestModel;
//    [self showDataForCellType:(CardType)digestModel.cardType WithDataModel:digestModel];
//}

- (void)showDataForCellType:(CardType)type WithDataModel:(DigestModel *)model
{
    self.contentView.backgroundColor = [SMTTheme cellContentViewColor];
    self.backView.backgroundColor = [SMTTheme viewBackgroundColor];

    self.digestModel = model;
    [self showSignViewDataWithDigestModel:model];

    [self.cardView showContentViewWithCardType:type DigestModel:model];
    
}

- (void)showSignViewDataWithDigestModel:(DigestModel *)model
{
    NSArray *authorList = model.authorList;
    AuthorModel *authorModel = authorList[0];
    NSArray *signList = model.signList;
    SignModel *signModel = signList[0];
    [self.signView showSignViewDataWithAuthorName:authorModel.name sign:signModel.name];
}

- (void)configureUI
{
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.signView];
    [self.backView addSubview:self.cardView];
}

- (void)configureFrame
{
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
  
        make.edges.mas_equalTo(UIEdgeInsetsMake(kSpaceY/4, 0, kSpaceY/4, 0));
    }];
    
    [self.signView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.mas_top);
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(kHeight);
    }];
    
    [self.cardView mas_remakeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.signView.mas_bottom).offset(kSpaceY/2);
        make.width.mas_equalTo(self.mas_width);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-kSpaceY);
    }];

}

- (UIView *)backView
{
    if (!_backView)
    {
        _backView = [[UIView alloc] init];
    }
    return _backView;
}

- (SignView *)signView
{
    if (!_signView)
    {
        _signView = [[SignView alloc] init];
        __weak typeof(self) weakSelf = self;
        
        _signView.authorNameBlock = ^(){
            if (weakSelf.toAuthorPageBlock)
            {
                weakSelf.toAuthorPageBlock();
            }
        };
        _signView.signBlock = ^(){
            if (weakSelf.toSignPageBlock)
            {
                weakSelf.toSignPageBlock();
            }
        };
    }
    return _signView;
}

- (SMTContentView *)cardView
{
    if (!_cardView) {
        _cardView = [[SMTContentView alloc] initWithCardType:self.cardType];
    }
    return _cardView;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
