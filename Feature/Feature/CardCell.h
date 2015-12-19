//
//  CardCell.h
//  TestNetwork
//
//  Created by sa.xiong on 15/9/11.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "SMTBaseCell.h"

@class DigestModel;


typedef void(^ToAuthorNamePageBlock)();
typedef void(^ToSignPageBlock)();


@interface CardCell : SMTBaseCell
@property (nonatomic, copy) ToAuthorNamePageBlock toAuthorPageBlock;
@property (nonatomic, copy) ToSignPageBlock toSignPageBlock;
@property (nonatomic, assign) CardType cardType;
@property (nonatomic, strong) DigestModel *digestModel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(CardType)cellType;

- (void)showDataForCellType:(CardType)type WithDataModel:(DigestModel *)model;

@end
