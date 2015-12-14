//
//  SMTContentView.h
//  Feature
//
//  Created by sa.xiong on 15/12/12.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DigestModel;
typedef NS_ENUM(NSInteger,ContentViewType)
{
    ContentViewTypeText,// 纯文字
    ContentViewTypeMixture,// 文字图片共存
    ContentViewTypeImage, // 纯图片
};

@interface SMTContentView : UIView

- (id)initWithCardType:(CardType)cardType;

- (void)showContentViewWithCardType:(CardType)type DigestModel:(DigestModel *)model;

@end
