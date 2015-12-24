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
@property (nonatomic, strong) NSNumber<Optional> *alreayMark;
@property (nonatomic, strong) NSArray <Optional,AuthorModel>*authorList;
@property (nonatomic, copy) NSString<Optional> *cardRemark;
@property (nonatomic, copy) NSString<Optional> *cardTitle;
@property (nonatomic, strong) NSNumber<Optional> *cardType;
@property (nonatomic, copy) NSString<Optional> *cardUrl;
@property (nonatomic, strong) NSNumber<Optional> *clickCnt;
@property (nonatomic, strong) NSNumber<Optional> *digestId;
@property (nonatomic, strong) SMTEBookInfoModel<Optional> *ebookInfo;
//@property (nonatomic, strong) NSDictionary<Optional,SMTEBookInfoModel> *ebookInfo;

@property (nonatomic, strong) NSNumber<Optional> *isPraise;
@property (nonatomic, strong) NSNumber<Optional> *isSupportReward;
@property (nonatomic, strong) NSNumber<Optional> *mediaId;
@property (nonatomic, strong) NSNumber<Optional> *mood;
@property (nonatomic, copy)   NSString<Optional> *pic1Path;
@property (nonatomic, strong) NSNumber<Optional> *reviewCnt;
@property (nonatomic, strong) NSNumber<Optional> *showStartDate;
@property (nonatomic, strong) NSNumber<Optional> *saleId;
// signList
@property (nonatomic, strong) NSArray <SignModel>*signList;
@property (nonatomic, strong) NSNumber *topCnt;
@property (nonatomic, strong) NSNumber *type;

@end
