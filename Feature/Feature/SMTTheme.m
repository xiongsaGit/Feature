//
//  SMTTheme.m
//  Feature
//
//  Created by sa.xiong on 15/12/18.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "SMTTheme.h"

@implementation SMTTheme

+ (UIColor *)cellContentViewColor {
    return [SMTCurrentIsDay currentTimeIsDay]?kDAY_COLOR_CELL_BACKGROUND:kNIGHT_COLOR_CELL_BACKGROUND;
}

+ (UIColor *)viewBackgroundColor {
    return [SMTCurrentIsDay currentTimeIsDay]?kDAY_COLOR_CARD_BACKGROUND:kNIGHT_COLOR_CARD_BACKGROUND;
}

+ (UIColor *)cardTitleColor {
    return [SMTCurrentIsDay currentTimeIsDay]?kDAY_COLOR_CARD_TITLE:kNIGHT_COLOR_CARD_TITLE;
}

+ (UIColor *)cardRemarkColor {
    return [SMTCurrentIsDay currentTimeIsDay]?kDAY_COLOR_CARD_REMARK:kNIGHT_COLOR_CARD_REMARK;
}

+ (UIColor *)cardAuthorColor {
    return [SMTCurrentIsDay currentTimeIsDay]?kDAY_COLOR_CARD_AUTHOR:kNIGHT_COLOR_CARD_AUTHOR;
}

+ (UIColor *)detailTitleColor {
    return [SMTCurrentIsDay currentTimeIsDay]?kDAY_COLOR_DETAIL_TITLE:kNIGHT_COLOR_DETAIL_TITLE;
}

+ (UIColor *)detailBookTitleColor {
    return [SMTCurrentIsDay currentTimeIsDay]?kDAY_COLOR_DETAIL_BOOKTITLE:kNIGHT_COLOR_DETAIL_BOOKTITLE;
}

+ (UIColor *)detailBookAuthorColor {
    return [SMTCurrentIsDay currentTimeIsDay]?kDAY_COLOR_DETAIL_BOOKAUTHOR:kNIGHT_COLOR_DETAIL_BOOKAUTHOR;
}

+ (UIColor *)detailBookRemarkColor {
    return [SMTCurrentIsDay currentTimeIsDay]?kDAY_COLOR_DETAIL_BOOKREMARK:kNIGHT_COLOR_DETAIL_BOOKREMARK;
}

@end
