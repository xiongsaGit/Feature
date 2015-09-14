//
//  TitleView.h
//  Feature
//
//  Created by sa.xiong on 15/9/14.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  SingleDetailViewController中使用，页面顶端展示标题和作者的view
 */
@interface TitleView : UIView


- (void)setArticleTitle:(NSString *)title Author:(NSString *)author;

@end
