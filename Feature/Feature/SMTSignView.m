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
    [self configureUI];
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
        make.bottom.mas_equalTo(self.mas_bottom);
        make.width.mas_equalTo(self.signImageView.mas_height);

    }];

    [self.signImageView setFrame:CGRectMake(kSpaceX/2, 0, 2*kSpaceX, CGRectGetHeight(self.frame))];
    
}

- (void)configureUI
{
    UIButton *lastButton = nil;
    for (int i = 0; i < self.signList.count; i ++) {
        UIButton *button = [self factoryForSignButtonWithTag:i];
        [self addSubview:button];
      
        [button setFrame:CGRectMake(CGRectGetMaxX(self.signImageView.frame)+kSpaceX/2+i*(100+kSpaceX/2), 0, 100, CGRectGetHeight(self.frame))];
        
        [button mas_remakeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(self.signImageView.mas_top).offset(kSpaceX/4);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-kSpaceX/4);
            if (i == 0) {
                make.left.mas_equalTo(self.signImageView.mas_right).offset(kSpaceX/2);
            }else {
                make.left.mas_equalTo(lastButton.mas_right).offset(kSpaceX/2);
            }
        }];
        if (i != 0) {
            lastButton = button;
        }
        SignModel *signModel = self.signList[i];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:[NSString stringWithFormat:@"  %@  ",signModel.name] forState:UIControlStateNormal];
    }
}

- (UIImageView *)signImageView
{
    if (!_signImageView)
    {
        _signImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_type"]];
    }
    return _signImageView;
}

- (UIButton *)factoryForSignButtonWithTag:(NSInteger)tag
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTag:tag+1000];
    [btn.titleLabel setFont:kFONT_MAIN];
    [btn.layer setCornerRadius:10];
    [btn setBackgroundColor:[SMTRandomColor randomColor]];
    [btn addTarget:self action:@selector(handleSignButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
@end
