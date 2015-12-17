//
//  SingleDetailViewController.m
//  Feature
//
//  Created by sa.xiong on 15/9/14.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "SingleDetailViewController.h"
#import "MainViewController.h"
#import "SMTPageDetatilRequest.h"

#import "SuspendView.h"
#import "TitleView.h"
#import "SMTEBookInfoView.h"

#import "SMTDetailModel.h"

// 每次缩放倍数
#define kSCALE_PER_TIME  10
// 最大倍数--太大太小无实际意义
#define kMAX_SCALE   130
// 最小倍数
#define kMIN_SCALE   70

@interface SingleDetailViewController ()<UIWebViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) NSNumber *digestId;
@property (nonatomic, strong) NSMutableURLRequest *urlRequest;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) TitleView *titleView;
@property (nonatomic, strong) UIWebView *contentWebView;

@property (nonatomic, strong) SMTEBookInfoView *bookInfoView;
@property (nonatomic, strong) SuspendView *suspendView;
@property (nonatomic, assign) CGFloat offsetY;
@property (nonatomic, assign) int currentScale;

@end

@implementation SingleDetailViewController


- (id)initWithDigestId:(NSNumber *)digestId
{
    if (self = [super init]) {
        self.digestId = digestId;
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
    
    NSLog(@"urlString:%@",[NSString stringWithFormat:@"%@?action=%@&digestId=%@",kBaseURL,kDigestContentForH5,[self.digestId stringValue]]);
    
    [self requestDigestDetail];
    [self.contentWebView loadRequest:self.urlRequest];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)requestDigestDetail {
    __weak typeof(self)weakSelf = self;
    [SvGifView startGifAddedToView:self.view];
    SMTPageDetatilRequest *detailRequest = [[SMTPageDetatilRequest alloc] initWithDigestId:self.digestId];
    [detailRequest startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [SvGifView stopGifForView:self.view];
        
        NSError* err = nil;
        SMTDetailModel *detailModel = [[SMTDetailModel alloc] initWithString:request.responseString error:&err];
        [weakSelf.titleView setTitleViewDataWithDigestDetailModel:detailModel.data.digestDetail];
        [weakSelf.bookInfoView showBookInfoWithDigestModel:detailModel.data.digestDetail];
        
    } failure:^(YTKBaseRequest *request) {
        [SvGifView stopGifForView:self.view];
    }];
    
}

- (void)configureUI
{
    self.view.backgroundColor = kCOLOR_DAY_BACKGROUND;
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.titleView];
    [self.scrollView addSubview:self.contentWebView];
    [self.scrollView addSubview:self.bookInfoView];
    [self.view addSubview:self.suspendView];
}

- (void)configureFrame
{
    self.titleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120);
    self.contentWebView.frame = CGRectMake(0, CGRectGetMaxY(self.titleView.frame), SCREEN_WIDTH, 0);
    self.bookInfoView.frame = CGRectMake(0, CGRectGetMaxY(self.contentWebView.frame), SCREEN_WIDTH, 250);
    self.suspendView.frame = CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50);
}


- (void)configureFrameWithHeight:(int)height
{
   
    CGRect webViewRect = self.contentWebView.frame;
    webViewRect.size.height = height;
    self.contentWebView.frame = webViewRect;
    
    CGRect bookInfoViewRect = self.bookInfoView.frame;
    bookInfoViewRect.origin.y = CGRectGetMaxY(self.contentWebView.frame);
    self.bookInfoView.frame = bookInfoViewRect;
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetMaxY(self.bookInfoView.frame));
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{

}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust = '140%'"];
    
    int height_str = [[webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.scrollHeight"] intValue];
    NSLog(@"first height_str:%d",height_str);
    [self configureFrameWithHeight:height_str];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)reduceTextFont
{
    NSLog(@"%s",__func__);
    if (self.currentScale-kSCALE_PER_TIME>=kMIN_SCALE) {
        self.currentScale -= kSCALE_PER_TIME;
        [self scaleWebViewFontWithScalePercent:self.currentScale];
    }
    
}

- (void)scaleWebViewFontWithScalePercent:(int)percent
{
    NSString *sizeAdjust = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust = '%d%%'",percent];
    [self.contentWebView stringByEvaluatingJavaScriptFromString:sizeAdjust];
    
    int height_str = [[self.contentWebView stringByEvaluatingJavaScriptFromString:@"document.documentElement.scrollHeight"] intValue];
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

- (UIWebView *)contentWebView
{
    if (!_contentWebView)
    {
        _contentWebView = [[UIWebView alloc] init];
        _contentWebView.delegate = self;
        _contentWebView.scalesPageToFit=YES;
        _contentWebView.userInteractionEnabled = NO;
        _contentWebView.scrollView.scrollEnabled = NO;
        _contentWebView.scrollView.bounces = NO;
        _contentWebView.scrollView.showsVerticalScrollIndicator = NO;
        [_contentWebView sizeToFit];
    }
    return _contentWebView;
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

- (TitleView *)titleView
{
    if (!_titleView)
    {
        __weak typeof(self)weakSelf = self;
        _titleView = [[TitleView alloc] initWithToAuthorListBlock:^(AuthorModel *authorModel) {
            MainViewController *mainViewCtrl = [[MainViewController alloc] initWithListType:ListTypeByAuthor listId:authorModel.authorId title:authorModel.name];
            [weakSelf.navigationController pushViewController:mainViewCtrl animated:YES];
        }];
    }
    return _titleView;
}

- (NSMutableURLRequest *)urlRequest
{
    if (!_urlRequest) {
        
        NSString *urlString = [NSString stringWithFormat:@"%@?action=%@&digestId=%@",kBaseURL,kDigestContentForH5,[self.digestId stringValue]];
        NSURL *url = [NSURL URLWithString:urlString];
        _urlRequest = [NSMutableURLRequest requestWithURL:url];
    }
    return _urlRequest;
}

- (SMTEBookInfoView *)bookInfoView {
    if (!_bookInfoView) {
        __weak typeof(self)weakSelf = self;
        _bookInfoView = [[SMTEBookInfoView alloc] initWithToTypeListBlock:^(SignModel *signModel) {
            MainViewController *mainViewCtrl = [[MainViewController alloc] initWithListType:ListTypeBySign listId:signModel.id title:signModel.name];
            [weakSelf.navigationController pushViewController:mainViewCtrl animated:YES];
        }];
    }
    return _bookInfoView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.delegate = self;
    }
    return _scrollView;
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
