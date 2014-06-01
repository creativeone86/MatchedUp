//
//  CCProfileViewController.m
//  MatchedUp
//
//  Created by Yordan Georgiev on 5/31/14.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import "CCProfileViewController.h"

@interface CCProfileViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageViewProfilePictureImageView;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;
@property (strong, nonatomic) IBOutlet UILabel *tagLineLabel;

@end

@implementation CCProfileViewController

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
    
    PFFile *pictureFile = self.photo[kCCPhotoPictureKey];
    [pictureFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
       
        self.imageViewProfilePictureImageView.image = [UIImage imageWithData:data];
        
        PFUser *user = self.photo[kCCPhotoUserKey];
        self.locationLabel.text = user[kCCuserProfileKey][kCCuserProfileLocationKey];
        self.ageLabel.text = [NSString stringWithFormat:@"%@", user[kCCuserProfileKey][kCCuserProfileAgeKey]];
        self.tagLineLabel.text = user[kCCuserProfileBioKey];
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
