//
//  MainViewController.m
//  Feature
//
//  Created by sa.xiong on 15/9/13.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "MainViewController.h"
#import "SingleDetailViewController.h"

#import "SuspendView.h"
#import "LeftMenuView.h"
#import "CardCell.h"
#import "SMTCurrentIsDay.h"

#import "RootModel.h"

#import "SMTHomePageListRequest.h"
#import "SMTListByAuthorRequest.h"
#import "SMTListBySignRequest.h"


typedef NS_ENUM(NSInteger,HomePageListRequestType)
{
    HomePageListRequestTypeDefault,
    HomePageListRequestTypeRefresh,
    HomePageListRequestTypeLoadMore
};

static CGFloat const kAnimationDuration = .2;

@interface MainViewController()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableData;
@property (nonatomic, assign) CGFloat oldOffsetY;
@property (nonatomic, strong) SuspendView *suspendView;
@property (nonatomic, strong) LeftMenuView *leftMenu;

// 判断是主页列表还是按Author或Sign分类展示的列表
@property (nonatomic, assign) BOOL isMainList;
@property (nonatomic, assign) ListType listType;
@property (nonatomic, strong) NSNumber *listId;
@end

@implementation MainViewController

#pragma mark -
//- 默认主页列表使用
- (id)init {
    if (self = [super init]) {
        self.isMainList = YES;
    }
    return self;
}

// - 按类型列表 使用
- (id)initWithListType:(ListType)listType listId:(NSNumber *)listId title:(NSString *)title
{
    if (self = [super init]) {
        self.title = title;
        self.listType = listType;
        self.listId = listId;
        self.isMainList = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    [self commonSet];
    
    if (self.isMainList) {
        
        UserDefaultsRemoveObjectForKey(kDay);
       NSString *dayOrNight =  [SMTCurrentIsDay currentTimeIsDay]?@"day":@"night";
        [self requestHomePageListWithAct:@"new" dayOrNight:dayOrNight sortPage:nil requestType:HomePageListRequestTypeDefault];
    }else {
        [self requestListDataByListType:self.listType listId:self.listId];
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = self.isMainList;
}

#pragma mark - 数据请求

//  按类型列表
- (void)requestListDataByListType:(ListType)listType listId:(NSNumber *)listId
{
    [self.tableData removeAllObjects];
    [SvGifView startGifAddedToView:self.view];
    __weak typeof(self)weakSelf = self;
    if (listType == ListTypeByAuthor) {
        SMTListByAuthorRequest *authorRequest = [[SMTListByAuthorRequest alloc] initWithAuthorId:listId];
        [authorRequest startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            [SvGifView stopGifForView:self.view];
            NSError* err = nil;
            RootModel *rootModel = [[RootModel alloc] initWithString:request.responseString error:&err];
            weakSelf.tableData = [NSMutableArray arrayWithArray:rootModel.data.digestList];
            [weakSelf.tableView reloadData];
        } failure:^(YTKBaseRequest *request) {
            [SvGifView stopGifForView:self.view];
        }];
    }else {
        SMTListBySignRequest *signRequest = [[SMTListBySignRequest alloc] initWithSignId:listId];
        [signRequest startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            [SvGifView stopGifForView:self.view];
            
            NSError* err = nil;
            RootModel *rootModel = [[RootModel alloc] initWithString:request.responseString error:&err];
            weakSelf.tableData = [NSMutableArray arrayWithArray:rootModel.data.digestList];
            [weakSelf.tableView reloadData];
            
        } failure:^(YTKBaseRequest *request) {
            [SvGifView stopGifForView:self.view];
        }];
    }
}

//  主页列表数据请求
- (void)requestHomePageListWithAct:(NSString *)act dayOrNight:(NSString *)dayOrNight sortPage:(NSNumber *)sortPage requestType:(HomePageListRequestType)requestType
{
    [SvGifView startGifAddedToView:self.view];

    SMTHomePageListRequest *homePageListRequest = [[SMTHomePageListRequest alloc] initWithAct:act dayOrNight:dayOrNight sortPage:sortPage];
    [homePageListRequest startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [SvGifView stopGifForView:self.view];

        NSError* err = nil;
        RootModel *rootModel = [[RootModel alloc] initWithString:request.responseString error:&err];
        
        if (requestType == HomePageListRequestTypeLoadMore) {
            [self.tableView.mj_footer endRefreshing];
        }else
            [self.tableView.mj_header endRefreshing];

        
        if (rootModel != nil) {
            if (requestType == HomePageListRequestTypeLoadMore) {
                [self.tableData addObjectsFromArray:rootModel.data.digestList];
            }else {
                if (rootModel.data.digestList.count>0) {
                    self.tableData = [NSMutableArray arrayWithArray:rootModel.data.digestList];
                }
            }
            [self.tableView reloadData];
        }
        
    } failure:^(YTKBaseRequest *request) {
        [SvGifView stopGifForView:self.view];

    }];
}

//  刷新列表数据
- (void)refreshDataInTableView
{
        NSString *dayOrNight =  [SMTCurrentIsDay currentTimeIsDay]?@"day":@"night";
        DigestModel *digestModel = self.tableData[0];
    
        [self requestHomePageListWithAct:@"new" dayOrNight:dayOrNight sortPage:digestModel.sortPage requestType:HomePageListRequestTypeRefresh];
}

//  加载更多数据
- (void)loadMoreDataInTableView
{
    NSString *dayOrNight =  [SMTCurrentIsDay currentTimeIsDay]?@"day":@"night";

        DigestModel *digestModel = self.tableData[self.tableData.count-1];
        [self requestHomePageListWithAct:@"old" dayOrNight:dayOrNight sortPage:digestModel.sortPage requestType:HomePageListRequestTypeLoadMore];
 }

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableData.count;
}

// - 这个地方要如何根据数据计算高度呢
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DigestModel *model = self.tableData[indexPath.row];
    CardType theType = [model.cardType intValue];
    if (theType == CardTypeImage)
    {
        return 300;
    }else if (theType == CardTypeMutilImages)
        return 200;
    else
        return 220;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DigestModel *model = self.tableData[indexPath.row];
    
    CardType theType;
    switch ([model.cardType intValue]) {
        case 0:
            theType = CardTypeText;
            break;
        case 1:
            theType = CardTypeMixture;
            break;
        case 2:
            theType = CardTypeImage;
            break;
        case 3:
            theType = CardTypeMutilImages;
        default:
            break;
    }
    
    CardCell *cell = (CardCell *)[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%d",(int)theType]];
    if (!cell)
    {
        cell = [[CardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%d",(int)theType] cellType:theType];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    }
    [cell showDifferColorByCurrentTime];
    [cell showDataForCellType:theType WithDataModel:model];

    [self blockForCell:cell withModel:model];
   
    return cell;
}

//- 跳转详情页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DigestModel *digestModel = [self.tableData objectAtIndex:indexPath.row];
    SingleDetailViewController *viewCtrl = [[SingleDetailViewController alloc] initWithDigestId:digestModel.id];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

#pragma mark - cell右上角 作者 类型 点击事件
- (void)blockForCell:(CardCell *)theCell withModel:(DigestModel *)model
{
    __weak typeof(self)weakSelf = self;
    
    AuthorModel *authorModel = model.authorList[0];
    SignModel *signModel = model.signList[0];

    theCell.toAuthorPageBlock = ^(){
   
        MainViewController *listViewCtrl = [[MainViewController alloc] initWithListType:ListTypeByAuthor listId:authorModel.authorId title:authorModel.name];
        [weakSelf.navigationController pushViewController:listViewCtrl animated:YES];
    
    };
  
    theCell.toSignPageBlock = ^()
    {
        MainViewController *listViewCtrl = [[MainViewController alloc] initWithListType:ListTypeBySign listId:signModel.id title:signModel.name];
        [weakSelf.navigationController pushViewController:listViewCtrl animated:YES];
        
    };
    
}

#pragma mark - others
- (void)commonSet
{
    _tableData = [NSMutableArray array];
    
    [self.view addSubview:self.tableView];
    [self.tableView setFrame:self.view.bounds];
    
    self.oldOffsetY = 0;
    
    if (self.isMainList) {
        NSArray *items = [NSArray arrayWithObjects:@"icon_leftMenu",@"icon_toTop", nil];
        self.suspendView = [[SuspendView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-60, self.view.frame.size.width, 60) menuItemsArray:items];
        self.suspendView.backgroundColor = [UIColor clearColor];
        
        __weak typeof(self) weakSelf = self;
        self.suspendView.itemClickBlock = ^(UIButton *itemBtn){
            switch (itemBtn.tag)
            {
                case 0:
                {
                    [UIView animateWithDuration:kAnimationDuration animations:^{
                        CGRect rect =  weakSelf.leftMenu.frame;
                        rect.origin.x = weakSelf.leftMenu.isOpen?-LEFT_MENU_WIDTH:0;
                        weakSelf.leftMenu.frame = rect;
                        if (!weakSelf.leftMenu.isOpen)
                        {
                            [weakSelf.leftMenu showFrame:rect];
                        }else
                        {
                            [weakSelf.leftMenu closeFrame:rect];
                        }
                    }];
                    weakSelf.leftMenu.isOpen = !weakSelf.leftMenu.isOpen;
                    
                }
                    break;
                case 1:
                {
                    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
                    [weakSelf.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
                }
                    break;
                default:
                    break;
            }
            
        };
        [self.view addSubview:self.suspendView];
        
        [self.leftMenu setFrame:CGRectMake(-LEFT_MENU_WIDTH, 0, LEFT_MENU_WIDTH, SCREEN_HEIGHT)];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.isMainList) {

    if (scrollView.contentOffset.y > self.oldOffsetY) {//如果当前位移大于缓存位移，说明scrollView向上滑动
        
        [UIView animateWithDuration:.1 animations:^{

            [self.suspendView setHidden:YES WithButtonTag:[self.suspendView.itemArray count]-1];
            
        }];
        
    }else
    {
        [UIView animateWithDuration:.1 animations:^{

            [self.suspendView setHidden:NO WithButtonTag:[self.suspendView.itemArray count]-1];
            
        }];
    }
    
    self.oldOffsetY = scrollView.contentOffset.y;//将当前位移变成缓存位移
        
    }
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshDataInTableView)];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDataInTableView)];
    }
    return _tableView;

}

- (LeftMenuView *)leftMenu
{
    if (!_leftMenu)
    {
        _leftMenu = [[LeftMenuView alloc] initWithFrame:CGRectZero];
        __weak typeof(self) weakSelf = self;
        _leftMenu.swipeBlock = ^(){
            
            [UIView animateWithDuration:kAnimationDuration animations:^{
                CGRect rect =  weakSelf.leftMenu.frame;
                rect.origin.x = -LEFT_MENU_WIDTH;
                weakSelf.leftMenu.frame = rect;
                weakSelf.leftMenu.isOpen = NO;
                
                [weakSelf.leftMenu closeFrame:rect];
            }];
            
        };
        _leftMenu.buttonClickBlock = ^(UIButton *btn){
            
            if (btn.tag == kBUTTON_FEEDBACK_TAG) {
                DLog(@"click feedback");
            }else {
                DLog(@"click return day");

                [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                
                CGRect rect = weakSelf.tableView.frame;
                rect.origin.y = 0;
                weakSelf.tableView.frame = rect;
                if (btn.tag == kBUTTON_RETURN_DAY_TAG) {

                    [weakSelf requestHomePageListWithAct:@"new" dayOrNight:@"night" sortPage:nil requestType:HomePageListRequestTypeDefault];
                }else {
                        // 进入黑夜
                    [weakSelf requestHomePageListWithAct:@"new" dayOrNight:@"day" sortPage:nil requestType:HomePageListRequestTypeDefault];
                        
                    }
                }
        };
    }
    return _leftMenu;
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
