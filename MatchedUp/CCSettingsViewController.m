//
//  CCSettingsViewController.m
//  MatchedUp
//
//  Created by Yordan Georgiev on 5/31/14.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import "CCSettingsViewController.h"

@interface CCSettingsViewController ()
@property (strong, nonatomic) IBOutlet UISlider *ageSlider;
@property (strong, nonatomic) IBOutlet UISwitch *menSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *womenSwitch;
@property (strong, nonatomic) IBOutlet UIButton *logoutButton;
@property (strong, nonatomic) IBOutlet UIButton *editProfile;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;

@end

@implementation CCSettingsViewController

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
    
    self.ageSlider.value = [[NSUserDefaults standardUserDefaults] integerForKey:kCCAgeMaxKey];
    self.menSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kCCMenEnabledKey];
    self.womenSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kCCWomenEnabledKey];
    
    [self.ageSlider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.menSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.womenSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    self.ageLabel.text = [NSString stringWithFormat:@"%i", (int)self.ageSlider.value];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (IBAction)logoutButtonPressed:(UIButton *)sender
{
    [PFUser logOut];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)editProfileButtonPressed:(UIButton *)sender
{
    
}

#pragma mark - Helper

-(void)valueChanged:(id)sender
{
    if (sender == self.ageSlider) {
        [[NSUserDefaults standardUserDefaults] setInteger:(int)self.ageSlider.value forKey:kCCAgeMaxKey];
        self.ageLabel.text = [NSString stringWithFormat:@"%i", (int)self.ageSlider.value];
        
        
        
    }
    else if (sender == self.menSwitch){
        [[NSUserDefaults standardUserDefaults] setBool:self.menSwitch.isOn forKey:kCCMenEnabledKey];
        
    }
    else if (sender == self.womenSwitch){
        [[NSUserDefaults standardUserDefaults] setBool:self.womenSwitch.isOn forKey:kCCWomenEnabledKey];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

@end
