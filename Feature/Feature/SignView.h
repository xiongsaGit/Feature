//
//  SignView.h
//  TestNetwork
//
//  Created by sa.xiong on 15/9/12.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  点击姓名label的响应事件
 */
typedef void(^AuthorNameLabelTapBlock)();
typedef void(^SignLabelTapBlcok)();


/**
 *  cell上方显示：作者名称和文章标签的view
 *  整个view可响应事件
 */
@interface SignView : UIView
@property (nonatomic, copy) AuthorNameLabelTapBlock authorNameTapBlock;
@property (nonatomic, copy) SignLabelTapBlcok signLabelTapBlock;
/**
 *  设置数据
 *
 *  @param authorName 作者名
 *  @param sign       文章标签
 */
- (void)showSignViewDataWithAuthorName:(NSString *)authorName sign:(NSString *)sign;

@end
