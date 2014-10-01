//
//  CompanyDataModel.h
//  ILJSONData
//
//  Created by Edgar Paz on 01/10/14.
//  Copyright (c) 2014 Edgar Paz. All rights reserved.
//

#import "ILJSONData.h"
#import "CEODataModel.h"
#import "EmployeeDataModel.h"

@interface CompanyDataModel : ILJSONData

@property (strong, nonatomic) NSString* dEscription;
@property (strong, nonatomic) NSString* email;
@property (strong, nonatomic) NSString* country;
@property (strong, nonatomic) NSString* company;
@property (strong, nonatomic) NSArray* Employees;
@property (strong, nonatomic) CEODataModel* CEO;


@end
