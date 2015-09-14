//
//  RootModel.h
//  TestNetwork
//
//  Created by sa.xiong on 15/9/12.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "JSONModel.h"
#import "DataModel.h"
#import "StatusModel.h"


@interface RootModel : JSONModel

@property (nonatomic, strong) DataModel *data;
@property (nonatomic, strong) StatusModel *status;
@property (nonatomic, strong) NSString *systemDate;
@end
