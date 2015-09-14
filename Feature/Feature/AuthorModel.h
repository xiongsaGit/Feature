//
//  AuthorModel.h
//  TestNetwork
//
//  Created by sa.xiong on 15/9/12.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "JSONModel.h"

@protocol AuthorModel <NSObject>

@end

@interface AuthorModel : JSONModel
@property (nonatomic, strong) NSNumber *authorId;
@property (nonatomic, strong) NSString *name;
@end
