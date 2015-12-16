//
//  SMTDetailModel.h
//  Feature
//
//  Created by sa.xiong on 15/12/16.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "JSONModel.h"
#import "StatusModel.h"
#import "SMTDetailDataModel.h"

@interface SMTDetailModel : JSONModel
@property (nonatomic, strong) SMTDetailDataModel *data;
@property (nonatomic, strong) StatusModel *status;
@property (nonatomic, copy) NSString *systemDate;
@end
