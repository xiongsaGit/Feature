//
//  MainViewController.h
//  Feature
//
//  Created by sa.xiong on 15/9/13.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ListType)
{
    ListTypeByAuthor,
    ListTypeBySign
};

@interface MainViewController : UIViewController

- (id)initWithListType:(ListType)listType listId:(NSNumber *)listId;

@end
