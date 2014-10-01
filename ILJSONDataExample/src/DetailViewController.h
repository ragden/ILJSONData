//
//  DetailViewController.h
//  ILJSONData
//
//  Created by Edgar Paz on 01/10/14.
//  Copyright (c) 2014 Edgar Paz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyDataModel.h"


typedef enum{
    TypeSegueCompany,
    TypeSegueCEO,
    TypeSegueEmployee
}TypeSegue;

@interface DetailViewController : UIViewController

@property (strong, nonatomic) CompanyDataModel* companyModel;
@property (nonatomic) TypeSegue typeSegue;
@property (nonatomic) NSInteger employeeIndex;
//UI
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblCountry;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;

@property (weak, nonatomic) IBOutlet UILabel *lblNameText;
@property (weak, nonatomic) IBOutlet UILabel *lblCountryText;
@property (weak, nonatomic) IBOutlet UILabel *lblEmailText;
@property (weak, nonatomic) IBOutlet UILabel *lblDescriptionText;


@end
