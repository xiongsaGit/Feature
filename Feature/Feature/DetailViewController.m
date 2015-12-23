//
//  DetailViewController.m
//  Feature
//
//  Created by sa.xiong on 15/9/14.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "DetailViewController.h"
#import "MainViewController.h"
#import "MainViewController.h"
#import "SMTPageDetatilRequest.h"

#import "SuspendView.h"
#import "TitleView.h"
#import "SMTEBookInfoView.h"

#import "SMTDetailModel.h"
#import "DigestModel.h"
#import "SMTDetailScrollView.h"
#import "SMTDetailView.h"
#import "MJRefresh.h"
#import "UIScrollView+MJRefresh.h"

// 每次缩放倍数
#define kSCALE_PER_TIME  10
// 最大倍数--太大太小无实际意义
#define kMAX_SCALE   130
// 最小倍数
#define kMIN_SCALE   70

@interface DetailViewController ()<UIWebViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) NSArray *digestList;
@property (nonatomic, strong) NSNumber *curDigestId;
@property (nonatomic, strong) NSMutableURLRequest *urlRequest;

@property (nonatomic, strong) SMTDetailView *detailView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) SuspendView *suspendView;

@property (nonatomic, assign) CGFloat offsetY;
@property (nonatomic, assign) int currentScale;

@property (nonatomic, strong) MJRefreshNormalHeader *refreshHeader;
@property (nonatomic, strong) MJRefreshAutoNormalFooter *refreshFooter;

@end

@implementation DetailViewController


- (SMTDetailView *)detailView {
    if (!_detailView) {
        __weak typeof(self)weakSelf = self;

        _detailView = [[SMTDetailView alloc] initWithAuthorBlock:^(AuthorModel *authorModel) {
            
            MainViewController *mainViewCtrl = [[MainViewController alloc] initWithListType:ListTypeByAuthor listId:authorModel.authorId title:authorModel.name];
            [weakSelf.navigationController pushViewController:mainViewCtrl animated:YES];
            
        } typeBlock:^(SignModel *signModel) {
            MainViewController *mainViewCtrl = [[MainViewController alloc] initWithListType:ListTypeBySign listId:signModel.id title:signModel.name];
            [weakSelf.navigationController pushViewController:mainViewCtrl animated:YES];
        
        }];
    }
    return _detailView;
}

- (id)initWithDigestId:(NSNumber *)digestId digestList:(NSArray *)digestArray
{
    if (self = [super init]) {
        self.curDigestId = digestId;
        self.digestList = digestArray;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.offsetY = 0;
    self.currentScale = 100;
    
    [self configureUI];
    [self configureFrame];
    
    DLog(@"urlString:%@",[NSString stringWithFormat:@"%@?action=%@&digestId=%@",kBaseURL,kDigestContentForH5,[self.curDigestId stringValue]]);

    [self requestDigestDetailWithDigestId:self.curDigestId requestType:ListRequestTypeDefault];
    [self loadWebViewRequestWithDigestId:self.curDigestId requestType:ListRequestTypeDefault];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (NSURL *)urlWithDigestId:(NSNumber *)digestId {
    NSString *urlString = [NSString stringWithFormat:@"%@?action=%@&digestId=%@",kBaseURL,kDigestContentForH5,[digestId stringValue]];
    return [NSURL URLWithString:urlString];
}

// 调用这两个方法
- (void)loadWebViewRequestWithDigestId:(NSNumber *)digestId requestType:(ListRequestType)requestType {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[self urlWithDigestId:digestId]];
     CGRect detailRect = self.detailView.frame;
    detailRect.size.height = 0;
    self.detailView.frame = detailRect;
    [self.detailView.contentWebView loadRequest:request];
}

- (void)requestDigestDetailWithDigestId:(NSNumber *)digestId requestType:(ListRequestType)requestType {
    __weak typeof(self)weakSelf = self;
    [SvGifView startGifAddedToView:self.view];
    SMTPageDetatilRequest *detailRequest = [[SMTPageDetatilRequest alloc] initWithDigestId:digestId];
    [detailRequest startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
//        [SvGifView stopGifForView:self.view];
        if (requestType == ListRequestTypeRefresh) {
            [self.refreshHeader endRefreshing];
        }else {
            [self.refreshFooter endRefreshing];
        }
        
        NSError* err = nil;
        SMTDetailModel *detailModel = [[SMTDetailModel alloc] initWithString:request.responseString error:&err];
        [weakSelf.detailView.titleView titleViewDataWithDigestDetailModel:detailModel.data.digestDetail];
        [weakSelf.detailView.bookInfoView showBookInfoWithDigestModel:detailModel.data.digestDetail];
        
    } failure:^(YTKBaseRequest *request) {
//        [SvGifView stopGifForView:self.view];
    }];
    
}

- (void)configureUI
{
    [self.view addSubview:self.scrollView];

    [self.scrollView addSubview:self.detailView];
    self.detailView.contentWebView.delegate = self;
    [self.view addSubview:self.suspendView];

}

- (void)configureFrame
{
   self.detailView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 370);
    self.suspendView.frame = CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50);

}


- (void)configureFrameWithHeight:(int)height
{
   
    CGRect webViewRect = self.detailView.contentWebView.frame;
    webViewRect.size.height = height;
    self.detailView.contentWebView.frame = webViewRect;
    
    CGRect bookInfoViewRect = self.detailView.bookInfoView.frame;
    bookInfoViewRect.origin.y = CGRectGetMaxY(self.detailView.contentWebView.frame);
    self.detailView.bookInfoView.frame = bookInfoViewRect;
    
    CGRect detailViewRect = self.detailView.frame;
    detailViewRect.size.height = CGRectGetMaxY(self.detailView.bookInfoView.frame);
    self.detailView.frame = detailViewRect;
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetMaxY(self.detailView.frame));
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [SvGifView stopGifForView:self.view];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    int height_str = [[webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.scrollHeight"] intValue];
    [self configureFrameWithHeight:height_str];

    [self showDifferentColorWithCurrentTime];
    [SvGifView stopGifForView:self.view];
}

- (void)showDifferentColorWithCurrentTime {
    
    if (![SMTCurrentIsDay currentTimeIsDay]) {
        NSString *textColorString = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '%@'",kNIGHT_WEBVIEW_CONTENT];
        [self.detailView.contentWebView stringByEvaluatingJavaScriptFromString:textColorString];
        
        NSString *backgroundColorString = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.background='%@'",kNIGHT_WEBVIEW_BACKGROUND];
        [self.detailView.contentWebView stringByEvaluatingJavaScriptFromString:backgroundColorString];
    }

}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)reduceTextFont
{
    if (self.currentScale-kSCALE_PER_TIME>=kMIN_SCALE) {
        self.currentScale -= kSCALE_PER_TIME;
        [self scaleWebViewFontWithScalePercent:self.currentScale];
    }
    
}

- (void)scaleWebViewFontWithScalePercent:(int)percent
{
    NSString *sizeAdjust = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust = '%d%%'",percent];
    [self.detailView.contentWebView stringByEvaluatingJavaScriptFromString:sizeAdjust];
    
    int height_str = [[self.detailView.contentWebView stringByEvaluatingJavaScriptFromString:@"document.documentElement.scrollHeight"] intValue];
    [self configureFrameWithHeight:height_str];
}

- (void)enlageTextFont
{
    if (self.currentScale + kSCALE_PER_TIME<=kMAX_SCALE) {
        self.currentScale += kSCALE_PER_TIME;
        [self scaleWebViewFontWithScalePercent:self.currentScale];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
        if (scrollView.contentOffset.y > self.offsetY) {//如果当前位移大于缓存位移，说明scrollView向上滑动
            
            [UIView animateWithDuration:.1 animations:^{
                
            
                [self.suspendView setHidden:YES];
                
            }];
            
        }else
        {
            [UIView animateWithDuration:.1 animations:^{
                
                [self.suspendView setHidden:NO];
                
            }];
        }
        
        self.offsetY = scrollView.contentOffset.y;//将当前位移变成缓存位移
    
}

- (SuspendView *)suspendView
{
    if (!_suspendView)
    {
        _suspendView = [[SuspendView alloc] initWithFrame:CGRectZero menuItemsArray:[NSArray arrayWithObjects:@"icon_return",@"icon_small",@"icon_large",@"icon_share", nil]];
       
        __weak typeof(self)weakSelf = self;
        _suspendView.itemClickBlock = ^(UIButton *itemBtn){
            NSInteger btnTag = itemBtn.tag;
            if (btnTag == 0) {
                
                [weakSelf.navigationController popViewControllerAnimated:YES];
                
            }else if (btnTag == 1)
            {
                // 缩小文字
                [weakSelf reduceTextFont];
            }else if (btnTag == 2)
            {
                // 放大文字
                [weakSelf enlageTextFont];
            }else
            {
                // 分享
            }
        };
    }
    return _suspendView;
}

- (NSMutableURLRequest *)urlRequest
{
    if (!_urlRequest) {
        _urlRequest = [NSMutableURLRequest requestWithURL:[self urlWithDigestId:self.curDigestId]];
    }
    return _urlRequest;
}

- (void)mj_headerRefresh {
    
//    - (void)loadWebViewRequestWithDigestId:(NSNumber *)digestId {
//
//    - (void)requestDigestDetailWithDigestId:(NSNumber *)digestId {
//

        [self refreshOrLoadMore:NO];
   
}

- (void)mj_footerRefresh {
    NSLog(@"footer");
    
    [self refreshOrLoadMore:YES];
}

- (void)refreshOrLoadMore:(BOOL)isLoadMore {
    
    NSNumber *refreshId = [self digestModelLocatedByCurrentDigestId:self.curDigestId forNextPage:isLoadMore].id;
    if (refreshId!=nil) {
        if (self.curDigestId != refreshId) {
            self.curDigestId = refreshId;
            [self loadWebViewRequestWithDigestId:refreshId requestType:isLoadMore?ListRequestTypeLoadMore:ListRequestTypeRefresh];
            [self requestDigestDetailWithDigestId:refreshId requestType:isLoadMore?ListRequestTypeLoadMore:ListRequestTypeRefresh];
        }
   
    }
   
}


- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.delegate = self;
        _scrollView.mj_header = self.refreshHeader;
        _scrollView.mj_footer = self.refreshFooter;
    }
    return _scrollView;
}

- (MJRefreshNormalHeader *)refreshHeader {
    if (!_refreshHeader) {
        _refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(mj_headerRefresh)];
    }else
        [self titleWithRefreshOrLoadMore:NO];
    return _refreshHeader;
}

- (MJRefreshAutoNormalFooter *)refreshFooter {
    if (!_refreshFooter) {
        _refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(mj_footerRefresh)];
    }else
        [self titleWithRefreshOrLoadMore:YES];
    return _refreshFooter;
}

- (void)titleWithRefreshOrLoadMore:(BOOL)isLoadMore {
    DigestModel *digestModel = [self digestModelLocatedByCurrentDigestId:self.curDigestId forNextPage:isLoadMore];
    
    if (digestModel.cardTitle == nil||[digestModel.id isEqualToNumber:self.curDigestId]) {
        
        [_refreshHeader setTitle:@"没有了" forState:MJRefreshStateNoMoreData];
    }else {
        if (isLoadMore) {
            [_refreshFooter setTitle:digestModel.cardTitle forState:MJRefreshStateIdle];
            [_refreshFooter setTitle:digestModel.cardTitle forState:MJRefreshStatePulling];
            [_refreshFooter setTitle:digestModel.cardTitle forState:MJRefreshStateRefreshing];
        }else {
            [_refreshHeader setTitle:digestModel.cardTitle forState:MJRefreshStateIdle];
            [_refreshHeader setTitle:digestModel.cardTitle forState:MJRefreshStatePulling];
            [_refreshHeader setTitle:digestModel.cardTitle forState:MJRefreshStateRefreshing];
        }
    }
}

- (DigestModel *)digestModelLocatedByCurrentDigestId:(NSNumber *)curId forNextPage:(BOOL)isNextPage {
    __block DigestModel *resultModel = nil;
    __weak NSArray *tempList = self.digestList;
    
    [tempList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        DigestModel *model = (DigestModel *)obj;
        if ([model.id isEqualToNumber:self.curDigestId]) {
            *stop = YES;
                if (isNextPage) {
                    if (idx < tempList.count-1) {
                         DigestModel *result = tempList[idx+1];
                        resultModel= [result copy];
                        resultModel.cardTitle = [NSString stringWithFormat:@"下一篇:%@",resultModel.cardTitle];
                    }
                }else {
                    if (idx>=1) {
                        DigestModel *result = tempList[idx-1];
                        resultModel= [result copy];
                        resultModel.cardTitle = [NSString stringWithFormat:@"上一篇:%@",resultModel.cardTitle];
                    }
                    
                }
            }
    }];
    
    return resultModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
