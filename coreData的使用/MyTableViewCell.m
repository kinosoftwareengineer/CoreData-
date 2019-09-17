//
//  MyTableViewCell.m
//  coreData的使用
//
//  Created by kino on 2019/9/11.
//  Copyright © 2019 kino. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
   self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUpBackgroundColor];
   
}
-(void)setUpBackgroundColor{
    NSInteger red   = arc4random() % 255;
    NSInteger green = arc4random() % 255;
    NSInteger blue  = arc4random() % 255;
    self.contentView.backgroundColor=[UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
