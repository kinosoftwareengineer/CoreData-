//
//  MyTableViewCell.h
//  coreData的使用
//
//  Created by kino on 2019/9/11.
//  Copyright © 2019 kino. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *count;

@end

NS_ASSUME_NONNULL_END
