//
//  SMTUserBaseInfoModel.h
//  Feature
//
//  Created by sa.xiong on 15/12/16.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "JSONModel.h"

@protocol SMTUserBaseInfoModel <NSObject>

@end


@interface SMTUserBaseInfoModel : JSONModel
@property (nonatomic, strong) NSNumber *barOwnerLevel;
@property (nonatomic, strong) NSNumber *channelOwner;
@property (nonatomic, strong) NSNumber *createBar;
@property (nonatomic, copy) NSString *custImg;
@property (nonatomic, strong) NSNumber *displayId;
@property (nonatomic, strong) NSNumber *experience;
@property (nonatomic, strong) NSNumber *gender;
@property (nonatomic, strong) NSNumber *integral;
@property (nonatomic, copy) NSString *introduct;
@property (nonatomic, strong) NSNumber *level;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *nickNameAll;
@property (nonatomic, copy) NSString *pubCustId;
@end
