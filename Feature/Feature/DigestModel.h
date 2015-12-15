//
//  DigestModel.h
//  TestNetwork
//
//  Created by sa.xiong on 15/9/12.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "JSONModel.h"
#import "AuthorModel.h"
#import "SignModel.h"

@protocol DigestModel <NSObject>

@end

@interface DigestModel : JSONModel
@property (nonatomic, strong) NSArray<Optional,AuthorModel> *authorList;
@property (nonatomic, strong) NSString *cardRemark;
@property (nonatomic, strong) NSString *cardTitle;
@property (nonatomic, strong) NSNumber *cardType;

@property (nonatomic, strong) NSNumber *createTime;
@property (nonatomic, strong) NSNumber<Optional> *dayOrNight;
@property (nonatomic, strong) NSNumber *id;// id
@property (nonatomic, strong) NSNumber<Optional> *isPraise;

@property (nonatomic, strong) NSString<Optional> *pic1Path;
@property (nonatomic, strong) NSNumber<Optional> *replyCnt;
@property (nonatomic, strong) NSNumber<Optional> *showStartDateYmdLong;

@property (nonatomic, strong) NSArray<Optional,SignModel>* signList;

@property (nonatomic, strong) NSString<Optional> *smallPic1Path;
@property (nonatomic, strong) NSString<Optional> *smallPic2Path;
@property (nonatomic, strong) NSString<Optional> *smallPic3Path;

@property (nonatomic, strong) NSNumber<Optional> *sortPage;
@property (nonatomic, strong) NSNumber<Optional> *topCnt;

@end
