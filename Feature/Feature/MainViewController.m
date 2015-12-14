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

#import "RootModel.h"

#import "SMTHomePageListRequest.h"
#import "SMTListViewController.h"

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

@end

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kCOLOR_VIEW_BACKGROUND;
    
    [self commonSet];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self requestHomePageListWithAct:@"new" dayOrNight:@"day" sortPage:nil requestType:HomePageListRequestTypeDefault];
  
}


#pragma mark -
#pragma mark - 数据请求
- (void)requestHomePageListWithAct:(NSString *)act dayOrNight:(NSString *)dayOrNight sortPage:(NSNumber *)sortPage requestType:(HomePageListRequestType)requestType
{
    SMTHomePageListRequest *homePageListRequest = [[SMTHomePageListRequest alloc] initWithAct:act dayOrNight:dayOrNight sortPage:sortPage];
    [homePageListRequest startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [SvGifView startGifAddedToView:self.view];
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
        [SNLog Log:@"request fail"];
    }];
}

#pragma mark -
#pragma mark - 刷新列表数据
- (void)refreshDataInTableView
{
    
    DigestModel *digestModel = self.tableData[0];
    
    [self requestHomePageListWithAct:@"new" dayOrNight:@"day" sortPage:digestModel.sortPage requestType:HomePageListRequestTypeRefresh];
}

#pragma mark - 
#pragma mark - 加载更多数据
- (void)loadMoreDataInTableView
{
    DigestModel *digestModel = self.tableData[self.tableData.count-1];

    [self requestHomePageListWithAct:@"old" dayOrNight:@"day" sortPage:digestModel.sortPage requestType:HomePageListRequestTypeLoadMore];
}

- (void)commonSet
{
    _tableData = [NSMutableArray array];
    
    [self.view addSubview:self.tableView];
    [self.tableView setFrame:self.view.bounds];

    self.oldOffsetY = 0;

    NSArray *items = [NSArray arrayWithObjects:@"card_1_03",@"card_1_03", nil];
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
    
    [self.leftMenu setFrame:CGRectMake(-LEFT_MENU_WIDTH, 0, LEFT_MENU_WIDTH, self.view.frame.size.height)];
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableData.count;
}

#pragma mark - 这个地方要如何根据数据计算高度呢
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
    
    CardCell *cell = (CardCell *)[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%ld",theType]];
    if (!cell)
    {
        cell = [[CardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%ld",theType] cellType:theType];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        [self blockForCell:cell];
    }
    [cell showDataForCellType:theType WithDataModel:model];
   
    return cell;
}

- (void)blockForCell:(CardCell *)theCell
{
    __weak typeof(self)weakSelf = self;
    
    AuthorModel *authorModel = theCell.digestModel.authorList[0];
    SignModel *signModel = theCell.digestModel.signList[0];

    theCell.toAuthorPageBlock = ^(){
   
        SMTListViewController *listViewCtrl = [[SMTListViewController alloc] initWithListType:ListTypeByAuthor listId:authorModel.authorId];
        [weakSelf.navigationController pushViewController:listViewCtrl animated:YES];
    
    };
  
    theCell.toSignPageBlock = ^()
    {
        SMTListViewController *listViewCtrl = [[SMTListViewController alloc] initWithListType:ListTypeByAuthor listId:signModel.id];
        [weakSelf.navigationController pushViewController:listViewCtrl animated:YES];
        
    };
    
}

#pragma mark - 跳转详情页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DigestModel *digestModel = [self.tableData objectAtIndex:indexPath.row];
    SingleDetailViewController *viewCtrl = [[SingleDetailViewController alloc] initWithDigestId:digestModel.id];
    [self presentViewController:viewCtrl animated:YES completion:^{}];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
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
            
            if (btn.tag == kFEEDBACK_TAG) {
                NSLog(@"click feedback");
            }else
            {
                NSLog(@"click return day");
            }
            // 弹出意见反馈页面
            
            
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
