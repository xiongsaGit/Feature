//
//  SignModel.h
//  TestNetwork
//
//  Created by sa.xiong on 15/9/12.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "JSONModel.h"


@protocol SignModel <NSObject>

@end

@interface SignModel : JSONModel
@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *name;
@end