//
//  SignView.h
//  TestNetwork
//
//  Created by sa.xiong on 15/9/12.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "SMTBaseView.h"
/**
 *  点击姓名的响应事件
 */
typedef void(^AuthorNameButtonClickBlock)();
typedef void(^SignButtonClickBlcok)();


/**
 *  cell上方显示：作者名称和文章标签的view
 *  整个view可响应事件
 */
@interface SignView : SMTBaseView
@property (nonatomic, copy) AuthorNameButtonClickBlock authorNameBlock;
@property (nonatomic, copy) SignButtonClickBlcok signBlock;
/**
 *  设置数据
 *
 *  @param authorName 作者名
 *  @param sign       文章标签
 */
- (void)showSignViewDataWithAuthorName:(NSString *)authorName sign:(NSString *)sign;

@end
