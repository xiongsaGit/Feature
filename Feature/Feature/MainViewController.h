//
//  MainViewController.h
//  Feature
//
//  Created by sa.xiong on 15/9/13.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "SMTBaseViewController.h"

typedef NS_ENUM(NSInteger,ListType)
{
    ListTypeByAuthor,
    ListTypeBySign
};

@interface MainViewController : SMTBaseViewController

- (id)initWithListType:(ListType)listType listId:(NSNumber *)listId title:(NSString *)title;

@end
