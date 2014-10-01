//
//  CompanyDataModel.m
//  ILJSONData
//
//  Created by Edgar Paz on 01/10/14.
//  Copyright (c) 2014 Edgar Paz. All rights reserved.
//

#import "CompanyDataModel.h"

@implementation CompanyDataModel

- (NSDictionary *)matchPropertyClasses{
    return @{@"Employees": [EmployeeDataModel class],
             @"CEO" : [CEODataModel class]};
}

- (NSDictionary *)matchPropertyNames{
    return @{
             @"description" : @"dEscription",
             @"email" : @"email",
             @"country" : @"country",
             @"company" : @"company",
             @"Employees" : @"Employees",
             @"CEO" : @"CEO"
             };
}

@end
