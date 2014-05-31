//
//  CCSecondViewController.m
//  MatchedUp
//
//  Created by Yordan Georgiev on 5/30/14.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import "CCSecondViewController.h"

@interface CCSecondViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *profilePictureImageView;

@end

@implementation CCSecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    PFQuery *query = [PFQuery queryWithClassName:kCCPhotoClassKey];
    [query whereKey:kCCPhotoUserKey equalTo:[PFUser currentUser]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if ([objects count] > 0) {
            //hardcoded the first element
            //because we know we have only one picture saved
            PFObject *photo = objects[0];
            
            PFFile *pictureFile = photo[kCCPhotoPictureKey];
            [pictureFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                self.profilePictureImageView.image = [UIImage imageWithData:data];
            }];
            
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
