//
//  CardCell.h
//  TestNetwork
//
//  Created by sa.xiong on 15/9/11.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DigestModel;
typedef NS_ENUM(NSInteger,CardCellType)
{
    CardCellTypeText,// 纯文字
    CardCellTypeMixture,// 文字图片共存
    CardCellTypeImage, // 纯图片
};

typedef void(^ToAuthorNamePageBlock)();
typedef void(^ToSignPageBlock)();


@interface CardCell : UITableViewCell
@property (nonatomic, copy) ToAuthorNamePageBlock toAuthorPageBlock;
@property (nonatomic, copy) ToSignPageBlock toSignPageBlock;
@property (nonatomic, assign) CardCellType cardType;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(CardCellType)cellType;


- (void)showDataForCellType:(CardCellType)type WithDataModel:(DigestModel *)model;

@end
