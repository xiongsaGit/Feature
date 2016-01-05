//
//  DigestModel.m
//  TestNetwork
//
//  Created by sa.xiong on 15/9/12.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "DigestModel.h"


@implementation DigestModel
- (id)init
{
    if (self = [super init])
    {
        
        self.authorList = (NSArray<Optional,AuthorModel> *)[[NSArray alloc] init];
        self.cardRemark = [[NSString alloc]init];
        self.cardTitle = [[NSString alloc]init];
        self.cardType = [[NSNumber alloc] init];
        self.createTime = [[NSNumber alloc] init];
        
        self.dayOrNight = [[NSNumber alloc] init];
        self.id = [[NSNumber alloc] init];
        self.isPraise = [[NSNumber alloc] init];
       
        self.pic1Path = [[NSString alloc] init];
        self.replyCnt = [[NSNumber alloc] init];
        self.showStartDateYmdLong = [[NSNumber alloc] init];
        self.signList = (NSArray<Optional,SignModel> *)[[NSArray alloc] init];
        self.smallPic1Path = [[NSString alloc] init];
        self.smallPic2Path = [[NSString alloc] init];
        self.smallPic3Path = [[NSString alloc] init];
        
        self.sortPage = [[NSNumber alloc] init];
        self.topCnt = [[NSNumber alloc] init];
     
    }
    return self;
}
- (void)dealloc
{
    
}
- (id)copyWithZone:(NSZone *)zone
{
    DigestModel *copy = [[[self class] allocWithZone:zone] init];
    copy->_authorList = [_authorList copy];
    copy->_cardRemark = [_cardRemark copy];
    copy->_cardTitle = [_cardTitle copy];
    copy->_cardType = [_cardType copy];
    copy->_createTime = [_createTime copy];
    copy->_dayOrNight = [_dayOrNight copy];
    copy->_id = [_id copy];
    copy->_isPraise = [_isPraise copy];
    copy->_pic1Path = [_pic1Path copy];
    copy->_replyCnt = [_replyCnt copy];
    copy->_showStartDateYmdLong = [_showStartDateYmdLong copy];
    copy->_signList = [_signList copy];
    copy->_smallPic1Path = [_smallPic1Path copy];
    copy->_smallPic2Path = [_smallPic2Path copy];
    copy->_smallPic3Path = [_smallPic3Path copy];
    copy->_sortPage = [_sortPage copy];
    copy->_topCnt = [_topCnt copy];
    return copy;
}


@end
