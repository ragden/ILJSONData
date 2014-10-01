//
//  CEODataModel.m
//  ILJSONData
//
//  Created by Edgar Paz on 01/10/14.
//  Copyright (c) 2014 Edgar Paz. All rights reserved.
//

#import "CEODataModel.h"

@implementation CEODataModel

//It's not necesary match property if has the same name as json property and yo don't want convert model into JSON
- (NSDictionary *)matchPropertyNames{
    return @{@"id": @"ID",
//             @"first_name" : @"first_name",
//             @"telephone" : @"telephone",
//             @"email" : @"email",
             @"country" : @"country"};
}

@end
