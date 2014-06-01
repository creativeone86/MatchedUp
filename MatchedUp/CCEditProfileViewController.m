//
//  CCEditProfileViewController.m
//  MatchedUp
//
//  Created by Yordan Georgiev on 5/31/14.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import "CCEditProfileViewController.h"

@interface CCEditProfileViewController ()
@property (strong, nonatomic) IBOutlet UITextView *tagLineTextView;
@property (strong, nonatomic) IBOutlet UIImageView *profilePictureImageView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *saveBarButtonItem;

@end

@implementation CCEditProfileViewController

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
    
    PFQuery *query = [PFQuery queryWithClassName:kCCPhotoClassKey];
    [query whereKey:kCCPhotoUserKey equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    
        NSLog(@"my object %@", objects);
        if (objects.count > 0) {
            PFObject *photo = objects[0];
            PFFile *pictureFile = photo[kCCPhotoPictureKey];
            [pictureFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            
                self.profilePictureImageView.image = [UIImage imageWithData:data];
            }];
            
        }
    }];
    
    self.tagLineTextView.text = [[PFUser currentUser] objectForKey:kCCuserProfileBioKey];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions
- (IBAction)saveBarButtonItemPressed:(UIBarButtonItem *)sender {
    
    [[PFUser currentUser] setObject:self.tagLineTextView.text forKey:kCCuserProfileBioKey];
    [[PFUser currentUser] saveInBackground];
    [self.navigationController popViewControllerAnimated:YES];
    
}



@end
