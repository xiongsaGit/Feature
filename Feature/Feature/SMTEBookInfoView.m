//
//  SMTEBookInfoView.m
//  Feature
//
//  Created by sa.xiong on 15/12/16.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "SMTEBookInfoView.h"
#import "SMTSignView.h"

@interface SMTEBookInfoView()
@property (nonatomic, strong) SMTSignView *signView;
@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *bookTitleLabel;
@property (nonatomic, strong) UILabel *bookAuthorLabel;
@property (nonatomic, strong) UILabel *bookRemarkLabel;
@property (nonatomic, copy)   EBookInfoViewClickToTypeListBlock toTypeListBlock;

@end

@implementation SMTEBookInfoView

- (id)initWithToTypeListBlock:(EBookInfoViewClickToTypeListBlock)toTypeListBlock {
    if (self = [super init]) {
        self.toTypeListBlock = toTypeListBlock;
        [self configureUI];
        [self configureFrame];
        
        self.bookAuthorLabel.textColor = [SMTTheme detailBookAuthorColor];
        self.bookTitleLabel.textColor = [SMTTheme detailBookTitleColor];
        self.bookRemarkLabel.textColor = [SMTTheme detailBookRemarkColor];
    }
    return self;
}

- (void)showBookInfoWithDigestModel:(SMTDigestDetailModel *)digestModel
{
    [self.signView showSignViewDataWithSignList:digestModel.signList];
    
    SMTEBookInfoModel *bookInfo = digestModel.ebookInfo;
   [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:bookInfo.bookImgUrl] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageProgressiveDownload];
    
    self.bookTitleLabel.text = bookInfo.bookName;
    self.bookAuthorLabel.text = bookInfo.bookAuthor;
    self.bookRemarkLabel.text = digestModel.cardRemark;

}

- (void)configureUI
{
    self.lineLabel = [self factoryForLabelWithFont:kCardRemarkFont textColor:[UIColor blackColor]];
    self.lineLabel.backgroundColor = [UIColor blackColor];
    self.bookTitleLabel = [self factoryForLabelWithFont:kCardTitleFont textColor:kCardTitleTextColor];
    self.bookAuthorLabel = [self factoryForLabelWithFont:kCardRemarkFont textColor:kCardRemarkTextColor];
    self.bookRemarkLabel = [self factoryForLabelWithFont:kCardRemarkFont textColor:kCardRemarkTextColor];
    
    [self addSubview:self.signView];
    [self addSubview:self.lineLabel];
    [self addSubview:self.coverImageView];
    [self addSubview:self.bookTitleLabel];
    [self addSubview:self.bookAuthorLabel];
    [self addSubview:self.bookRemarkLabel];

}

- (void)configureFrame
{
    [self.signView mas_remakeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(kHEIGHT_OF_LABEL);
    }];
    
    [self.lineLabel mas_remakeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.signView.mas_bottom).offset(kSpaceX*2);
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.coverImageView mas_remakeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.lineLabel.mas_bottom).offset(kSpaceX);
        make.left.mas_equalTo(self.mas_left).offset(kSpaceX/2);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-2*kSpaceX);
        make.width.mas_equalTo(100);
    }];
    
    [self.bookTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.coverImageView.mas_top);
        make.left.mas_equalTo(self.coverImageView.mas_right).offset(kSpaceX/2);
        make.right.mas_equalTo(self.mas_right).offset(-kSpaceX/2);
    }];
    
    [self.bookAuthorLabel mas_remakeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.bookTitleLabel.mas_bottom).offset(kSpaceX/4);
        make.left.mas_equalTo(self.bookTitleLabel.mas_left);
        make.right.mas_equalTo(self.bookTitleLabel.mas_right);
        make.height.mas_equalTo(kHEIGHT_OF_LABEL);
    }];
    
    [self.bookRemarkLabel mas_remakeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.bookAuthorLabel.mas_bottom).offset(kSpaceX/4);
        make.left.mas_equalTo(self.bookTitleLabel.mas_left);
        make.right.mas_equalTo(self.bookTitleLabel.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-kSpaceX/2);
    }];

}

#pragma mark - getter&setter

- (SMTSignView *)signView {
    if (!_signView) {
        __weak typeof(self)weakSelf = self;
        _signView = [[SMTSignView alloc] initWithClickToSignListBlock:^(SignModel *signModel) {
            if (weakSelf.toTypeListBlock) {
                weakSelf.toTypeListBlock(signModel);
            }
        }];
    }
    return _signView;
}

- (UIImageView *)coverImageView
{
    if (!_coverImageView)
    {
        _coverImageView = [[UIImageView alloc] init];
    }
    return _coverImageView;
}

- (UILabel *)factoryForLabelWithFont:(UIFont *)font textColor:(UIColor *)textColor
{
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.font = font;
    label.textColor = textColor;
    return label;
}
@end
