//
//  TableSectionModel.m
//  iOS
//
//  Created by aStudyer on 2019/9/10.
//  Copyright © 2019 com.aStudyer. All rights reserved.
//

#import "TableSectionModel.h"

@implementation TableSectionModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             HC_KP(TableSectionModel, items): [TableRowModel class]
             };
}

@end
