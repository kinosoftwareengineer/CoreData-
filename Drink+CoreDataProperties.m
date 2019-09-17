//
//  Drink+CoreDataProperties.m
//  coreData的使用
//
//  Created by kino on 2019/9/11.
//  Copyright © 2019 kino. All rights reserved.
//
//

#import "Drink+CoreDataProperties.h"

@implementation Drink (CoreDataProperties)

+ (NSFetchRequest<Drink *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Drink"];
}

@dynamic name;
@dynamic price;
@dynamic count;

@end
