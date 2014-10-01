//
//  FirstViewController.m
//  ILJSONData
//
//  Created by Edgar Paz on 01/10/14.
//  Copyright (c) 2014 Edgar Paz. All rights reserved.
//

#import "FirstViewController.h"
#import "DetailViewController.h"
#import "CompanyDataModel.h"

@interface FirstViewController ()

@property (strong, nonatomic) CompanyDataModel* companyModel;

@end

@implementation FirstViewController

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
    self.companyModel = [[CompanyDataModel alloc] initWithDictionary:[self loadLocalJson:@"JSONExample"]];
    NSLog(@"Data Model to JSON: %@", [self.companyModel convertDataModelToJSON]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    [segue.destinationViewController setCompanyModel:self.companyModel];
    if ([segue.identifier isEqualToString:@"CEO"]) {
        [segue.destinationViewController setTypeSegue:TypeSegueCEO];
    }
    else if ([segue.identifier isEqualToString:@"Company"]) {
        [segue.destinationViewController setTypeSegue:TypeSegueCompany];
    }
}



#pragma mark - Private Metods

- (NSDictionary*) loadLocalJson: (NSString*) fileName{
    NSString* pathOfFile = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSData* jsonData = [[NSData alloc] initWithContentsOfFile:pathOfFile];
    NSError* error;
    NSDictionary* dico = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    return dico;
}

@end
