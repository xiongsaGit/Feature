//
//  SingleDetailViewController.m
//  Feature
//
//  Created by sa.xiong on 15/9/14.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "SingleDetailViewController.h"

@interface SingleDetailViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation SingleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = [UIColor yellowColor];
    
    [self configureUI];
    [self configureFrame];
    
//    NSURL *url = [NSURL URLWithString:@"http://e.dangdang.com/media/api2.go?action=getDigestContentForH5&digestId=506062"];//http://e.dangdang.com/media/api2.go?action=getDigestContentForH5&digestId=2105
     NSURL *url = [NSURL URLWithString:@"http://e.dangdang.com/media/api2.go?action=getDigestContentForH5&digestId=2105"];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    self.webView.scalesPageToFit=YES;
    
    [self.webView loadRequest:request];
}

- (void)configureUI
{
    [self.view addSubview:self.webView];
}

- (void)configureFrame
{
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
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



- (UIWebView *)webView
{
    if (!_webView)
    {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
    }
    return _webView;
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
