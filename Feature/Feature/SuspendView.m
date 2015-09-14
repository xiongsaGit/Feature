//
//  SuspendView.m
//  TestNetwork
//
//  Created by sa.xiong on 15/9/10.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "SuspendView.h"
#import "Masonry.h"


static CGFloat const offsetX = 10;
static CGFloat const itemWidthHeight = 40;

@interface SuspendView()
@end


@implementation SuspendView

- (instancetype)initWithFrame:(CGRect)frame menuItemsArray:(NSArray *)menuItems
{
    if (self = [super initWithFrame:frame])
    {
        for (int i = 0; i < menuItems.count; i++)
        {
            UIButton *btn = [self factoryForButtonImageName:menuItems[i] buttonTag:i];
            [self addSubview:btn];
        }
        [self commonSetting];
        self.itemArray = [NSArray arrayWithArray:menuItems];
    }
    return self;
}


/**
 *  第一个按钮靠屏幕左侧，其余按钮靠屏幕右侧排列
 *  保证宽高相同
 *  itemWidthHeight 超过superView高度时，宽高不受控制了。。。
 */
- (void)commonSetting
{
    NSArray *array = [self subviews];
   
    
    if (array.count>0)
    {
        UIButton *btn = (UIButton *)array[0];
        
      [btn mas_makeConstraints:^(MASConstraintMaker *make){
          make.left.mas_equalTo(self.mas_left).offset(offsetX);
          make.centerY.mas_equalTo(self.mas_centerY);
          make.size.mas_lessThanOrEqualTo(CGSizeMake(itemWidthHeight, itemWidthHeight));
      }];
    }
    
    
    if (array.count > 1)
    {
        for (NSInteger i = 1; i < array.count; i ++)
        {
            UIButton *btn = (UIButton *)array[i];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {

                make.centerY.mas_equalTo(self.mas_centerY);
                make.size.mas_lessThanOrEqualTo(CGSizeMake(itemWidthHeight, itemWidthHeight));
                make.right.mas_equalTo(self.mas_right).offset(-((array.count-i)*offsetX+(array.count-i-1)*itemWidthHeight));
            }];
        }
    }
    
}



- (void)handleButtonClicked:(UIButton *)btn
{
    if (self.itemClickBlock)
    {
        self.itemClickBlock(btn);
    }
}

- (void)setHidden:(BOOL)hidden WithButtonTag:(NSInteger)btnTag
{
    if (btnTag > self.itemArray.count)
    {
        
    }else
    {
        for (id object in [self subviews])
        {
            UIButton *btn = (UIButton *)object;
            if (btnTag == btn.tag)
            {
                [btn setHidden:hidden];
            }
        }
    }
    
    
}


- (UIButton *)factoryForButtonImageName:(NSString *)imageName buttonTag:(NSInteger)btnTag
{
    UIButton *tempButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tempButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    tempButton.tag = btnTag;
    [tempButton addTarget:self action:@selector(handleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    return tempButton;
}


- (UIButton *)factoryForButtonWithTag:(NSInteger)btnTag;//SelectorString:(NSString *)selectorString
{
    UIButton *tempButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tempButton.tag = btnTag;
    [tempButton setBackgroundColor:[UIColor yellowColor]];
    [tempButton addTarget:self action:@selector(handleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    return tempButton;
}


/**
 *  传入按钮事件名
 *
 *  @param selectorString 事件字符串
 *
 *  @return 按钮
 */
- (UIButton *)factoryForButtonWithSelectorString:(NSString *)selectorString
{
    UIButton *tempButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tempButton addTarget:self action:NSSelectorFromString(selectorString) forControlEvents:UIControlEventTouchUpInside];
    [tempButton addTarget:self action:@selector(handleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    return tempButton;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
