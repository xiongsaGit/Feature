//
//  SMTDigestDetailModel.h
//  Feature
//
//  Created by sa.xiong on 15/12/16.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "JSONModel.h"
#import "AuthorModel.h"
#import "SignModel.h"
#import "SMTEBookInfoModel.h"

@protocol SMTDigestDetailModel <NSObject>

@end

@interface SMTDigestDetailModel : JSONModel
@property (nonatomic, strong) NSNumber *alreayMark;
@property (nonatomic, strong) NSArray <AuthorModel>*authorList;
@property (nonatomic, copy) NSString *cardRemark;
@property (nonatomic, copy) NSString *cardTitle;
@property (nonatomic, strong) NSNumber *cardType;
@property (nonatomic, copy) NSString *cardUrl;
@property (nonatomic, strong) NSNumber *clickCnt;
@property (nonatomic, strong) NSNumber *digestId;
@property (nonatomic, strong) SMTEBookInfoModel *ebookInfo;
@property (nonatomic, strong) NSNumber *isPraise;
@property (nonatomic, strong) NSNumber *isSupportReward;
@property (nonatomic, strong) NSNumber *mediaId;
@property (nonatomic, strong) NSNumber *mood;
@property (nonatomic, copy) NSString *pic1Path;
@property (nonatomic, strong) NSNumber *reviewCnt;
@property (nonatomic, strong) NSNumber *showStartDate;
// signList
@property (nonatomic, strong) NSArray <SignModel>*signList;
@property (nonatomic, strong) NSNumber *topCnt;
@property (nonatomic, strong) NSNumber *type;






@end
