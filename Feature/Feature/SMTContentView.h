//
//  SMTContentView.h
//  Feature
//
//  Created by sa.xiong on 15/12/12.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "SMTBaseView.h"

@class DigestModel;
@interface SMTContentView : SMTBaseView

- (id)initWithCardType:(CardType)cardType;

- (void)showContentViewWithCardType:(CardType)type DigestModel:(DigestModel *)model;

@end
