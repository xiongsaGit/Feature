//
//  SMTEBookInfoModel.h
//  Feature
//
//  Created by sa.xiong on 15/12/16.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "JSONModel.h"

@protocol SMTEBookInfoModel <NSObject>

@end

@interface SMTEBookInfoModel : JSONModel
@property (nonatomic, copy) NSString *bookAuthor;
@property (nonatomic, copy) NSString *bookImgUrl;
@property (nonatomic, copy) NSString *bookName;
@property (nonatomic, copy) NSString *editorRecommend;
@property (nonatomic, strong) NSNumber *isPaperBook;
@property (nonatomic, copy) NSString *mediaType;
@property (nonatomic, strong) NSNumber *productId;
@property (nonatomic, strong) NSNumber *saleId;
@end
