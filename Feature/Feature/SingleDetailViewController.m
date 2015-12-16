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

#import "SMTDetailModel.h"

@interface SingleDetailViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) NSNumber *digestId;
@property (nonatomic, strong) NSMutableURLRequest *urlRequest;

@property (nonatomic, strong) TitleView *titleView;
@property (nonatomic, strong) UIWebView *contentWebView;

@property (nonatomic, strong) UIView *bookInfoView;
@property (nonatomic, strong) SuspendView *suspendView;
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
    
    [self configureUI];
    [self configureFrame];
    
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
        
        
    } failure:^(YTKBaseRequest *request) {
        [SvGifView stopGifForView:self.view];
    }];
    
}

- (void)configureUI
{
    self.view.backgroundColor = kCOLOR_DAY_BACKGROUND;
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.contentWebView];
    [self.view addSubview:self.suspendView];
}

- (void)configureFrame
{
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(120);
    }];
    [self.contentWebView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.titleView.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    [self.suspendView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{

}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)reduceTextFont
{
    NSLog(@"%s",__func__);
}

- (void)enlageTextFont
{
    NSLog(@"%s",__func__);
}

- (UIWebView *)contentWebView
{
    if (!_contentWebView)
    {
        _contentWebView = [[UIWebView alloc] init];
        _contentWebView.delegate = self;
        _contentWebView.scalesPageToFit=YES;

    }
    return _contentWebView;
}

- (SuspendView *)suspendView
{
    if (!_suspendView)
    {
        _suspendView = [[SuspendView alloc] initWithFrame:CGRectZero menuItemsArray:[NSArray arrayWithObjects:@"001",@"002",@"003",@"004", nil]];
       
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
