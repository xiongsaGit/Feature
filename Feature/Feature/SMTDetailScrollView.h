//
//  SMTDetailScrollView.h
//  Feature
//
//  Created by sa.xiong on 15/12/19.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AuthorModel,SignModel,TitleView,SMTEBookInfoView;
typedef void(^DetailToAuthorBlock)(AuthorModel *authorModel);
typedef void(^DetailToTypeBlock)(SignModel *signModel);

@interface SMTDetailScrollView : UIScrollView

@property (nonatomic, strong) TitleView *titleView;
@property (nonatomic, strong) UIWebView *contentWebView;
@property (nonatomic, strong) SMTEBookInfoView *bookInfoView;

- (id)initWithAuthorBlock:(DetailToAuthorBlock)authorBlock typeBlock:(DetailToTypeBlock)typeBlock;

@end
