//
//  Drink+CoreDataProperties.h
//  coreData的使用
//
//  Created by kino on 2019/9/11.
//  Copyright © 2019 kino. All rights reserved.
//
//

#import "Drink+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Drink (CoreDataProperties)

+ (NSFetchRequest<Drink *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *price;
@property (nullable, nonatomic, copy) NSString *count;

@end

NS_ASSUME_NONNULL_END
