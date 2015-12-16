//
//  SMTSignView.m
//  Feature
//
//  Created by sa.xiong on 15/12/16.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "SMTSignView.h"
#import "SignModel.h"

@interface SMTSignView()
@property (nonatomic, strong) UIImageView *signImageView;
@property (nonatomic, copy) SignViewClickToSignListBlock toSignListBlock;
@property (nonatomic, strong) SignModel *signModel;
@property (nonatomic, strong) NSArray *signList;

@end

@implementation SMTSignView

- (id)initWithClickToSignListBlock:(SignViewClickToSignListBlock)toSignListBlock
{
    if (self = [super init]) {
        self.toSignListBlock = toSignListBlock;
    }
    return self;
}

- (void)showSignViewDataWithSignList:(NSArray *)signList
{
    self.signList = signList;
    [self commonSetting];
}

- (void)showSignViewDataWithSignModel:(SignModel *)signModel
{
    self.signModel = signModel;
    [self configureUI];
}

- (void)handleSignButtonClicked:(UIButton *)button
{
    if (self.toSignListBlock) {
        self.toSignListBlock(self.signList[button.tag-1000]);
    }
}

- (void)commonSetting
{
    [self addSubview:self.signImageView];
    [self.signImageView mas_remakeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left).offset(kSpaceX/2);
        make.width.mas_equalTo(kSpaceX);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];

}

- (void)configureUI
{
    UIButton *lastButton = nil;
    for (int i = 0; i < self.signList.count; i ++) {
        UIButton *button = [self factoryForSignButtonWithTag:i];
        [self addSubview:button];
      
        [button mas_remakeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(self.signImageView.mas_top);
            make.bottom.mas_equalTo(self.mas_bottom);
            if (i == 0) {
                make.left.mas_equalTo(self.signImageView.mas_right).offset(kSpaceX/2);
            }else
                make.left.mas_equalTo(lastButton.mas_right).offset(kSpaceX/2);
        }];
        if (i != 0) {
            lastButton = button;
        }
        SignModel *signModel = self.signList[i];
        [button setTitle:signModel.name forState:UIControlStateNormal];
    }
}

- (UIImageView *)signImageView
{
    if (!_signImageView)
    {
        _signImageView = [[UIImageView alloc] init];
        [_signImageView setBackgroundColor:[UIColor redColor]];
    }
    return _signImageView;
}

- (UIButton *)factoryForSignButtonWithTag:(NSInteger)tag
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = tag+1000;
    [btn addTarget:self action:@selector(handleSignButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
@end
