//
//  SMTMainTableViewController.m
//  Feature
//
//  Created by sa.xiong on 15/12/25.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "SMTMainTableViewController.h"
#import "DetailViewController.h"

#import "SuspendView.h"
#import "LeftMenuView.h"
#import "CardCell.h"
#import "SMTNetworkErrorView.h"

#import "SMTCurrentIsDay.h"
#import "RootModel.h"

#import "SMTHomePageListRequest.h"
#import "SMTListByAuthorRequest.h"
#import "SMTListBySignRequest.h"

#import "UITableView+FDTemplateLayoutCell.h"


@interface SMTMainTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *tableData;
@property (nonatomic, assign) CGFloat oldOffsetY;

// 判断是主页列表还是按Author或Sign分类展示的列表
@property (nonatomic, assign) BOOL isMainList;
@property (nonatomic, assign) ListRequestType listType;
@property (nonatomic, strong) NSNumber *listId;

@end

@implementation SMTMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.fd_debugLogEnabled = NO;//YES;
    
    self.tableData = [NSMutableArray array];
    
    [self.tableView registerClass:[CardCell class] forCellReuseIdentifier:@"0"];
    [self.tableView registerClass:[CardCell class] forCellReuseIdentifier:@"1"];
    [self.tableView registerClass:[CardCell class] forCellReuseIdentifier:@"2"];
    [self.tableView registerClass:[CardCell class] forCellReuseIdentifier:@"3"];

    UserDefaultsRemoveObjectForKey(kDay);
    NSString *dayOrNight =  [SMTCurrentIsDay currentTimeIsDay]?@"day":@"night";
    [self requestHomePageListWithAct:@"new" dayOrNight:dayOrNight sortPage:nil requestType:ListRequestTypeDefault];
    
}

//  主页列表数据请求
- (void)requestHomePageListWithAct:(NSString *)act dayOrNight:(NSString *)dayOrNight sortPage:(NSNumber *)sortPage requestType:(ListRequestType)requestType
{
    
    SMTHomePageListRequest *homePageListRequest = [[SMTHomePageListRequest alloc] initWithAct:act dayOrNight:dayOrNight sortPage:sortPage];
    [homePageListRequest startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        
        NSError* err = nil;
        RootModel *rootModel = [[RootModel alloc] initWithString:request.responseString error:&err];
        
        if (requestType == ListRequestTypeLoadMore) {
            [self.tableView.mj_footer endRefreshing];
        }else
            [self.tableView.mj_header endRefreshing];
        
        
        if (rootModel != nil) {
            if (requestType == ListRequestTypeLoadMore) {
                [self.tableData addObjectsFromArray:rootModel.data.digestList];
            }else {
                if (rootModel.data.digestList.count>0) {
                    self.tableData = [NSMutableArray arrayWithArray:rootModel.data.digestList];
                }
            }
            [self.tableView reloadData];
        }
        
    } failure:^(YTKBaseRequest *request) {
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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
    cell.digestModel = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
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
    return [tableView fd_heightForCellWithIdentifier:[NSString stringWithFormat:@"%d",(int)theType] configuration:^(CardCell *cell) {
//        [self configureCell:cell atIndexPath:indexPath];
        cell.digestModel = model;
    }];

}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
