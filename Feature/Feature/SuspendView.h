//
//  SuspendView.h
//  TestNetwork
//
//  Created by sa.xiong on 15/9/10.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void(^SuspendViewReturnBackBlock)();
//typedef void(^SuspendViewMagnifyBlock)();
//typedef void(^SuspendViewMinifyBlock)();

typedef void(^SuspendViewItemClickBlock)(UIButton *itemBtn);

@interface SuspendView : UIView

@property (nonatomic, strong) NSArray *itemArray;

@property (nonatomic, copy) SuspendViewItemClickBlock itemClickBlock;

- (instancetype)initWithFrame:(CGRect)frame menuItemsArray:(NSArray *)menuItems;


- (void)setHidden:(BOOL)hidden WithButtonTag:(NSInteger)btnTag;


@end
