//
//  SMTDetailView.m
//  Feature
//
//  Created by sa.xiong on 15/12/19.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "SMTDetailView.h"

#import "TitleView.h"
#import "SMTEBookInfoView.h"


@interface SMTDetailView()<UIScrollViewDelegate>
@property (nonatomic, copy) DetailToAuthorBlock toAuthorListBlock;
@property (nonatomic, copy) DetailToTypeBlock toTypeListBlock;

@end

@implementation SMTDetailView

- (id)initWithAuthorBlock:(DetailToAuthorBlock)authorBlock typeBlock:(DetailToTypeBlock)typeBlock
{
    if (self = [super init]) {
        self.toAuthorListBlock = authorBlock;
        self.toTypeListBlock = typeBlock;
        [self addSubview:self.titleView];
        [self addSubview:self.contentWebView];
        [self addSubview:self.bookInfoView];
        
        self.titleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120);
        self.contentWebView.frame = CGRectMake(0, CGRectGetMaxY(self.titleView.frame), SCREEN_WIDTH, 0);
        self.bookInfoView.frame = CGRectMake(0, CGRectGetMaxY(self.contentWebView.frame), SCREEN_WIDTH, 250);
    }
    return self;
}


- (UIWebView *)contentWebView
{
    if (!_contentWebView)
    {
        _contentWebView = [[UIWebView alloc] init];
//      _contentWebView.delegate = self;
        _contentWebView.scalesPageToFit=YES;
        _contentWebView.userInteractionEnabled = NO;
        _contentWebView.scrollView.scrollEnabled = NO;
        _contentWebView.scrollView.bounces = NO;
        _contentWebView.scrollView.showsVerticalScrollIndicator = NO;
        [_contentWebView sizeToFit];
    }
    return _contentWebView;
}

- (TitleView *)titleView
{
    if (!_titleView)
    {
        __weak typeof(self)weakSelf = self;
        _titleView = [[TitleView alloc] initWithToAuthorListBlock:^(AuthorModel *authorModel) {
            //            MainViewController *mainViewCtrl = [[MainViewController alloc] initWithListType:ListTypeByAuthor listId:authorModel.authorId title:authorModel.name];
            //            [weakSelf.navigationController pushViewController:mainViewCtrl animated:YES];
            if (weakSelf.toAuthorListBlock) {
                weakSelf.toAuthorListBlock(authorModel);
            }
        }];
    }
    return _titleView;
}

- (SMTEBookInfoView *)bookInfoView {
    if (!_bookInfoView) {
        __weak typeof(self)weakSelf = self;
        _bookInfoView = [[SMTEBookInfoView alloc] initWithToTypeListBlock:^(SignModel *signModel) {
            if (weakSelf.toTypeListBlock) {
                weakSelf.toTypeListBlock(signModel);
            }
            //            MainViewController *mainViewCtrl = [[MainViewController alloc] initWithListType:ListTypeBySign listId:signModel.id title:signModel.name];
            //            [weakSelf.navigationController pushViewController:mainViewCtrl animated:YES];
        }];
    }
    return _bookInfoView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
