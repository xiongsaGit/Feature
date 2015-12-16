//
//  SMTSignView.h
//  Feature
//
//  Created by sa.xiong on 15/12/16.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SignModel.h"

typedef void(^SignViewClickToSignListBlock)(SignModel *signModel);

@interface SMTSignView : UIView

- (id)initWithClickToSignListBlock:(SignViewClickToSignListBlock)toSignListBlock;

@end
