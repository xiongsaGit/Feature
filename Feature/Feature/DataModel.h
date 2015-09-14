//
//  DataModel.h
//  TestNetwork
//
//  Created by sa.xiong on 15/9/12.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "JSONModel.h"
#import "DigestModel.h"



@interface DataModel : JSONModel
@property (nonatomic, strong) NSString *currentDate;

@property (nonatomic, strong) NSArray<DigestModel>* digestList;

@property (nonatomic, strong) NSNumber *hasNext;
@property (nonatomic, strong) NSString *systemDate;
@end