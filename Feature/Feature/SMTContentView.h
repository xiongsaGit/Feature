//
//  SMTContentView.h
//  Feature
//
//  Created by sa.xiong on 15/12/12.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DigestModel;
@interface SMTContentView : UIView

- (id)initWithCardType:(CardType)cardType;

- (void)showContentViewWithCardType:(CardType)type DigestModel:(DigestModel *)model;

- (void)showDifferColorByCurrentIsDay:(BOOL)currentIsDay;

@end
