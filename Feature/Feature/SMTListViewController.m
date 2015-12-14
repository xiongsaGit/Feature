//
//  SMTListViewController.m
//  Feature
//
//  Created by sa.xiong on 15/12/12.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "SMTListViewController.h"
#import "SMTListByAuthorRequest.h"
#import "SMTListBySignRequest.h"

@interface SMTListViewController()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) ListType listType;
@property (nonatomic, strong) NSNumber *listId;
@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) NSMutableArray *listMutArray;
@end

@implementation SMTListViewController

- (void)viewDidLoad
{
    self.listMutArray = [NSMutableArray array];
    
    [self.view addSubview:self.listTableView];
    NSLog(@"%s",__func__);
    
    [self requestListDataByListType:self.listType listId:self.listId];
}

- (id)initWithListType:(ListType)listType listId:(NSNumber *)listId
{
    NSLog(@"%s",__func__);

    if (self = [super init]) {
        
        self.listType = listType;
        self.listId = listId;
    }
    return self;
}

- (void)requestListDataByListType:(ListType)listType listId:(NSNumber *)listId
{
    __weak typeof(self)weakSelf = self;
    if (listType == ListTypeByAuthor) {
        SMTListByAuthorRequest *authorRequest = [[SMTListByAuthorRequest alloc] initWithAuthorId:listId];
        [authorRequest startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            
            NSLog(@"request data:%@",request.responseString);
//            [weakSelf.listTableView reloadData];
        } failure:^(YTKBaseRequest *request) {
            
        }];
        
    }else {
        SMTListBySignRequest *signRequest = [[SMTListBySignRequest alloc] initWithSignId:listId];
        [signRequest startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            
        } failure:^(YTKBaseRequest *request) {
            
        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listMutArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSIndexPath *
}

#pragma mark - getter&&setter
- (UITableView *)listTableView
{
    if (!_listTableView)
    {
        _listTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
    }
    return _listTableView;
}

@end
