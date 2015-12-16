//
//  Util.h
//  Feature
//
//  Created by sa.xiong on 15/9/14.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#ifndef Util_h
#define Util_h



#define kDAY_FROM_TIME       @"05:59:59"
#define kNIGHT_FROM_TIME   @"19:59:59"


#define UserDefaultsSetObjectForKey(object,key)  [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];  [[NSUserDefaults standardUserDefaults] synchronize];

#define UserDefaultsGetObjectForKey(key)     [[NSUserDefaults standardUserDefaults] objectForKey:key]

#define UserDefaultsRemoveObjectForKey(key) [[NSUserDefaults standardUserDefaults]removeObjectForKey:key]; [[NSUserDefaults standardUserDefaults] synchronize];

/****************************************************************************/


typedef NS_ENUM(NSInteger,CardType)
{
    CardTypeText=0,// 纯文字
    CardTypeMixture,// 文字图片共存,一段文字一张图片
    CardTypeImage, // 纯图片，一张大图片
    CardTypeMutilImages // 多张图片
};


/****************************************************************************/


#define UIColorFromHex(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]

#define kCOLOR_DAY_BACKGROUND    UIColorFromHex(0xffffff)
#define kCOLOR_NIGHT_BACKGROUND  UIColorFromHex(0x222222)

#define kCOLOR_DAY_SEPARATOR        UIColorFromHex(0xf2f2f2)
#define kCOLOR_NIGHT_SEPARATOR       UIColorFromHex(0x232323)

#define kTEXT_COLOR_DAY        UIColorFromHex(0x444444)
#define kTEXT_COLOR_NIGHT      kCOLOR_DAY_BACKGROUND

#define kCOLOR_MENU_BACKGROUND   UIColorFromHex(0x2c2c2c)


/****************************************************************************/

// 文章内容字体及标签字体
#define kFONT_MAIN  [UIFont systemFontOfSize:12]
// 作者名字字体
#define kFONT_AUTHORNAME [UIFont systemFontOfSize:14]
// 文章标题字体
#define kFONT_TITLE [UIFont systemFontOfSize:16]


#define kCardTitleFont       [UIFont systemFontOfSize:20]
#define kCardRemarkFont       [UIFont systemFontOfSize:14]
#define kCardTitleTextColor     [UIColor blackColor]

#define kTEXT_COLOR_DAY_CARD_TITLE
#define kCardRemarkTextColor     [UIColor lightGrayColor]



/****************************************************************************/

static CGFloat const kHeight = 40;
static CGFloat const kSpaceX = 20;
static CGFloat const kSpaceY = 20;
static CGFloat const kSmallImageWidth = 120;

#define kHEIGHT_OF_LABEL  30

// 反馈信息按钮
#define kBUTTON_FEEDBACK_TAG  1000
// 返回白天按钮
#define kBUTTON_RETURN_DAY_TAG 1001
// 进入黑夜按钮
#define kBUTTON_ENTER_NIGHT_TAG 1002

/*
 *屏幕宽度
 */
#define SCREEN_WIDTH ([[UIScreen mainScreen]bounds].size.width)

/*
 *屏幕高度
 */
#define SCREEN_HEIGHT ([[UIScreen mainScreen]bounds].size.height)

/*
 *左侧抽屉宽度
 */
#define LEFT_MENU_WIDTH 3*SCREEN_WIDTH/4


/****************************************************************************/


#endif /* Util_h */
