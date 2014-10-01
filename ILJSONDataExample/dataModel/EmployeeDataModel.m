//
//  EmployeeDataModel.m
//  ILJSONData
//
//  Created by Edgar Paz on 01/10/14.
//  Copyright (c) 2014 Edgar Paz. All rights reserved.
//

#import "EmployeeDataModel.h"

@implementation EmployeeDataModel

- (NSDictionary *)matchPropertyNames{
    return @{@"id": @"ID",
//             @"first_name" : @"first_name",
             @"description" : @"dEscription",
//             @"email" : @"email",
             @"country" : @"country"};
}

@end
