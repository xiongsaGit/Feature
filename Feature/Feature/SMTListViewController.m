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

#import "RootModel.h"

#import "CardCell.h"

@interface SMTListViewController()<UITableViewDataSource,UITableViewDelegate>

//@property (nonatomic, assign) ListType listType;
//@property (nonatomic, strong) NSNumber *listId;
//@property (nonatomic, strong) UITableView *listTableView;
//@property (nonatomic, strong) NSMutableArray *listMutArray;
@end

@implementation SMTListViewController

//- (void)viewDidLoad
//{
//    self.listMutArray = [NSMutableArray array];
//    
//    [self.view addSubview:self.listTableView];
//    
//    [self requestListDataByListType:self.listType listId:self.listId];
//}
//
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = NO;
//}
//
//- (id)initWithListType:(ListType)listType listId:(NSNumber *)listId
//{
//    if (self = [super init]) {
//        
//        self.listType = listType;
//        self.listId = listId;
//    }
//    return self;
//}
//
//- (void)requestListDataByListType:(ListType)listType listId:(NSNumber *)listId
//{
//    [SvGifView startGifAddedToView:self.view];
//    __weak typeof(self)weakSelf = self;
//    if (listType == ListTypeByAuthor) {
//        SMTListByAuthorRequest *authorRequest = [[SMTListByAuthorRequest alloc] initWithAuthorId:listId];
//        [authorRequest startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
//            [SvGifView stopGifForView:self.view];
//            NSError* err = nil;
//            RootModel *rootModel = [[RootModel alloc] initWithString:request.responseString error:&err];
//            weakSelf.listMutArray = [NSMutableArray arrayWithArray:rootModel.data.digestList];
//            [weakSelf.listTableView reloadData];
//        } failure:^(YTKBaseRequest *request) {
//            [SvGifView stopGifForView:self.view];
//        }];
//    }else {
//        SMTListBySignRequest *signRequest = [[SMTListBySignRequest alloc] initWithSignId:listId];
//        [signRequest startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
//            [SvGifView stopGifForView:self.view];
//
//            NSError* err = nil;
//            RootModel *rootModel = [[RootModel alloc] initWithString:request.responseString error:&err];
//            weakSelf.listMutArray = [NSMutableArray arrayWithArray:rootModel.data.digestList];
//            [weakSelf.listTableView reloadData];
//            
//        } failure:^(YTKBaseRequest *request) {
//            [SvGifView stopGifForView:self.view];
//        }];
//    }
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return self.listMutArray.count;
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 200;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    DigestModel *model = self.listMutArray[indexPath.row];
//    
//    CardType theType;
//    switch ([model.cardType intValue]) {
//        case 0:
//            theType = CardTypeText;
//            break;
//        case 1:
//            theType = CardTypeMixture;
//            break;
//        case 2:
//            theType = CardTypeImage;
//            break;
//        case 3:
//            theType = CardTypeMutilImages;
//        default:
//            break;
//    }
//    
//    CardCell *cell = (CardCell *)[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%ld",theType]];
//    if (!cell)
//    {
//        cell = [[CardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%ld",theType] cellType:theType];
//        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
//    }
//    [cell showDataForCellType:theType WithDataModel:model];
//    
////    [self blockForCell:cell withModel:model];
//    
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //    NSIndexPath *
//}
//
//#pragma mark - getter&&setter
//- (UITableView *)listTableView
//{
//    if (!_listTableView)
//    {
//        _listTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
//        _listTableView.delegate = self;
//        _listTableView.dataSource = self;
//    }
//    return _listTableView;
//}

@end
