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
#import "TimerView.h"
#import "CardCell.h"

#import "RootModel.h"



static CGFloat const kAnimationDuration = .2;
static CGFloat const LeftMenuWidth = 200;//3*(self.view.frame.size.width)/4;

@interface MainViewController()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableData;
@property (nonatomic, assign) CGFloat oldOffsetY;

@property (nonatomic, strong) SuspendView *suspendView;

@property (nonatomic, strong) LeftMenuView *leftMenu;

@property (nonatomic, strong) TimerView *timerView;

@end

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self commonSet];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[MGJRequestManager sharedInstance] POST:@"http://e.dangdang.com/media/api2.go" parameters:
     @{@"act": @"new",
       @"action":@"getDigestHomePageList",
       @"dayOrNight":@"day",
       @"pageSize":@"10"} startImmediately:YES
                        configurationHandler:nil completionHandler:^(NSError *error, id<NSObject> result, BOOL isFromCache, AFHTTPRequestOperation *operation) {
                            
                            
                            NSError* err = nil;
                            
                            RootModel *rootModel = [[RootModel alloc] initWithDictionary:(NSDictionary *)result error:&err];
                            
                            self.tableData = [NSMutableArray arrayWithArray:rootModel.data.digestList];
                            
                            [self.tableView reloadData];
                            
                            
                        }];
    
}

/**
 *  何时请求
 */
- (void)loadNewData
{
    NSLog(@"%s",__func__);
}

- (void)loadMoreData
{
    NSLog(@"%s",__func__);
}

- (void)commonSet
{
    _tableData = [NSMutableArray array];
    
    [self.view addSubview:self.tableView];
//    [self.tableView setFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-100)];
    [self.tableView setFrame:self.view.bounds];

    self.oldOffsetY = 0;
    
    
    
    NSArray *items = [NSArray arrayWithObjects:@"001",@"005", nil];
    self.suspendView = [[SuspendView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-60, self.view.frame.size.width, 60) menuItemsArray:items];
    self.suspendView.backgroundColor = [UIColor clearColor];
    
    __weak typeof(self) weakSelf = self;
    self.suspendView.itemClickBlock = ^(UIButton *itemBtn){
        NSLog(@"click btn tag:%ld",itemBtn.tag);
        
        switch (itemBtn.tag)
        {
            case 0:
            {
                
                [UIView animateWithDuration:kAnimationDuration animations:^{
                    CGRect rect =  weakSelf.leftMenu.frame;
                    rect.origin.x = weakSelf.leftMenu.isOpen?-LeftMenuWidth:0;
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
    
    [self.leftMenu setFrame:CGRectMake(-LeftMenuWidth, 0, LeftMenuWidth, self.view.frame.size.height)];
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableData.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DigestModel *model = self.tableData[indexPath.row];
    CardCellType theType = [model.cardType intValue];
    if (theType == CardCellTypeImage)
    {
        return 280;
    }else
        return 200.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *textCellId = @"textCell";
    static NSString *mixtureCellId = @"mixtureCell";
    static NSString *imageCellId = @"imageCell";
    
    
    DigestModel *model = self.tableData[indexPath.row];
    CardCellType theType;
    if ([model.cardType intValue]==0)
    {
        // 文字
        theType = CardCellTypeText;
    }else if ([model.cardType intValue] == 1)
    {
        // 文字图片
        theType = CardCellTypeMixture;
    }else
    {
        // 图片
        theType = CardCellTypeImage;
    }
    switch (theType) {
        case CardCellTypeText:
        {
            CardCell *cell = (CardCell *)[tableView dequeueReusableCellWithIdentifier:textCellId];
            if (!cell)
            {
                cell = [[CardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:textCellId cellType:theType];
                cell.selectionStyle = UITableViewCellSeparatorStyleNone;
                [self blockForCell:cell];
            }
            [cell showDataForCellType:theType WithDataModel:model];
            return cell;
        }
            break;
         case CardCellTypeMixture:
        {
            CardCell *cell = (CardCell *)[tableView dequeueReusableCellWithIdentifier:mixtureCellId];
            if (!cell)
            {
                cell = [[CardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mixtureCellId cellType:theType];
                cell.selectionStyle = UITableViewCellSeparatorStyleNone;
                [self blockForCell:cell];

            }
            [cell showDataForCellType:theType WithDataModel:model];
            return cell;
        
        }
            break;
            case CardCellTypeImage:
        {
            CardCell *cell = (CardCell *)[tableView dequeueReusableCellWithIdentifier:imageCellId];
            if (!cell)
            {
                cell = [[CardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:imageCellId cellType:theType];
                cell.selectionStyle = UITableViewCellSeparatorStyleNone;
                [self blockForCell:cell];

            }
            [cell showDataForCellType:theType WithDataModel:model];
            return cell;
        }
            break;
        default:
            break;
    }
    
    return nil;
}

- (void)blockForCell:(CardCell *)theCell
{
    theCell.toAuthorPageBlock = ^()
    {
        NSLog(@"to-page");
    };
    theCell.toSignPageBlock = ^()
    {
        NSLog(@"to-author");

    };
    
}

#pragma mark - 跳转详情页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSIndexPath *
    SingleDetailViewController *viewCtrl = [[SingleDetailViewController alloc] init];
    CATransition *animation = [CATransition animation];
    
    animation.duration = 1.0;
    
//    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    
    animation.type = kCATransitionMoveIn;//kCATransitionPush;//@"pageCurl";
    
    //animation.type = kCATransitionPush;
    
    animation.subtype = kCATransitionFromRight;
    
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self presentViewController:viewCtrl animated:YES completion:^{
        
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView.contentOffset.y > self.oldOffsetY) {//如果当前位移大于缓存位移，说明scrollView向上滑动
        
        
        NSLog(@"scroll up");
        //        self.suspendView.alpha = 0;
        
        [UIView animateWithDuration:.1 animations:^{

            [self.suspendView setHidden:YES WithButtonTag:[self.suspendView.itemArray count]-1];
            
        }];
        
    }else
    {
        NSLog(@"scroll down");
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

        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
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
                rect.origin.x = -LeftMenuWidth;
                weakSelf.leftMenu.frame = rect;
                weakSelf.leftMenu.isOpen = NO;
                
                [weakSelf.leftMenu closeFrame:rect];
            }];
            
        };
        _leftMenu.buttonClickBlock = ^(){
            
            // 弹出意见反馈页面
            
            NSLog(@"click feedback");
            
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
