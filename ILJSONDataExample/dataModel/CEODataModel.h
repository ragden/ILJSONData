//
//  CEODataModel.h
//  ILJSONData
//
//  Created by Edgar Paz on 01/10/14.
//  Copyright (c) 2014 Edgar Paz. All rights reserved.
//

#import "ILJSONData.h"

@interface CEODataModel : ILJSONData

@property (strong, nonatomic) NSNumber* ID;
@property (strong, nonatomic) NSString* first_name;
@property (strong, nonatomic) NSString* telephone;
@property (strong, nonatomic) NSString* email;
@property (strong, nonatomic) NSString* country;

@end
