//
//  DetailViewController.m
//  ILJSONData
//
//  Created by Edgar Paz on 01/10/14.
//  Copyright (c) 2014 Edgar Paz. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];


}

- (void) initController{
    switch (self.typeSegue) {
        case TypeSegueCEO:{
            self.lblDescription.text = @"Telephone:";
            
            CEODataModel* ceo = self.companyModel.CEO;
            self.lblDescriptionText.text = ceo.telephone;
            [self.lblDescriptionText sizeToFit];
            
            self.lblCountryText.text = ceo.country;
            self.lblEmailText.text = ceo.email;
            self.lblNameText.text = ceo.first_name;
            break;
        }
        case TypeSegueCompany:{
            self.lblDescription.text = @"Description:";
            
            self.lblDescriptionText.text = self.companyModel.dEscription;
            [self.lblDescriptionText sizeToFit];
            
            self.lblCountryText.text = self.companyModel.country;
            self.lblEmailText.text = self.companyModel.email;
            self.lblNameText.text = self.companyModel.company;
            break;
        }
        case TypeSegueEmployee:{
            self.lblDescription.text = @"Description:";
            EmployeeDataModel* employee = [self.companyModel.Employees objectAtIndex:self.employeeIndex];
            self.lblDescriptionText.text = employee.dEscription;
            [self.lblDescriptionText sizeToFit];
            
            self.lblCountryText.text = employee.country;
            self.lblEmailText.text = employee.email;
            self.lblNameText.text = employee.first_name;
            
            break;
        }
        default:
            break;
    }
}
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
