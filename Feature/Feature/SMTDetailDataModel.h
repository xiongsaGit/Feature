//
//  SMTDetailDataModel.h
//  Feature
//
//  Created by sa.xiong on 15/12/16.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "JSONModel.h"
#import "SMTDigestDetailModel.h"
#import "SMTUserBaseInfoModel.h"

@protocol SMTDetailDataModel <NSObject>

@end

@interface SMTDetailDataModel : JSONModel
@property (nonatomic, strong) NSNumber *canBeDel;
@property (nonatomic, copy) NSString *currentDate;
@property (nonatomic, strong)SMTDigestDetailModel *digestDetail;
@property (nonatomic, strong) NSNumber *subscribe;
@property (nonatomic, copy) NSString *systemDate;
@property (nonatomic, strong) SMTUserBaseInfoModel *userBaseInfo;
@end
