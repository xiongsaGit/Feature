//
//  LeftMenuView.h
//  TestNetwork
//
//  Created by sa.xiong on 15/9/10.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LeftMenuViewSwipeBlock)();
typedef void(^LeftMenuViewButtonBlock)();

@interface LeftMenuView : UIView

@property (nonatomic, copy) LeftMenuViewSwipeBlock swipeBlock;
@property (nonatomic, copy) LeftMenuViewButtonBlock buttonClickBlock;

@property (nonatomic, assign) BOOL isOpen;
-(void)showFrame:(CGRect)rect;
-(void)closeFrame:(CGRect)rect;


@end
