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
@property (nonatomic, copy) NSString<Optional> *bookAuthor;
@property (nonatomic, copy) NSString<Optional> *bookImgUrl;
@property (nonatomic, copy) NSString<Optional> *bookName;
@property (nonatomic, copy) NSString<Optional> *editorRecommend;
@property (nonatomic, strong) NSNumber<Optional> *isPaperBook;
@property (nonatomic, copy) NSString<Optional> *mediaType;
@property (nonatomic, strong) NSNumber<Optional> *productId;
@property (nonatomic, strong) NSNumber<Optional> *saleId;
@end
