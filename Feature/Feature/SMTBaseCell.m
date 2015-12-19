//
//  SMTBaseCell.m
//  Feature
//
//  Created by sa.xiong on 15/12/18.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "SMTBaseCell.h"

@implementation SMTBaseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        NSLog(@"LOG BASE CELL");
//        self.contentView.backgroundColor = [SMTTheme cellContentViewColor];
    }
    return self;
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
