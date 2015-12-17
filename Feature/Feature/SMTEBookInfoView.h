//
//  SMTEBookInfoView.h
//  Feature
//
//  Created by sa.xiong on 15/12/16.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMTDigestDetailModel.h"

typedef void(^EBookInfoViewClickToTypeListBlock)(SignModel *signModel);

@interface SMTEBookInfoView : UIView

- (id)initWithToTypeListBlock:(EBookInfoViewClickToTypeListBlock)toTypeListBlock;

- (void)showBookInfoWithDigestModel:(SMTDigestDetailModel *)digestModel;

@end
