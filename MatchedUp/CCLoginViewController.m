//
//  CCLoginViewController.m
//  MatchedUp
//
//  Created by Yordan Georgiev on 5/30/14.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import "CCLoginViewController.h"


@interface CCLoginViewController ()
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) NSMutableData *imageData;

@end

@implementation CCLoginViewController

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
    
    
    self.activityIndicator.hidden = YES;
}

-(void)viewDidAppear:(BOOL)animated
{
    if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
        
        [self updateUserInformation];
        [self performSegueWithIdentifier:@"loginToHomeSegue" sender:self];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -IBActions

- (IBAction)loginButtonPressed:(UIButton *)sender {
    
    NSArray *permissionsArray = @[@"email"];
    
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        self.activityIndicator.hidden = NO;
        [self.activityIndicator startAnimating];
        if (!user) {
            [self.activityIndicator stopAnimating];
            self.activityIndicator.hidden = YES;
            if (!error) {
                UIAlertView *alertView  = [[UIAlertView alloc] initWithTitle:@"Login Error" message:@"The Facebook login was canceled" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alertView show];
            }
            else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Login Error" message:[error description] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alertView show];
            }
        }
        else{
            [self updateUserInformation];
            [self performSegueWithIdentifier:@"loginToHomeSegue" sender:self];
        }
        
    }];
}

#pragma mark - Helper Method

-(void)updateUserInformation
{
    FBRequest *request = [FBRequest requestForMe];
    
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        
        if (!error) {
            NSDictionary *userDictionary = (NSDictionary *)result;
            NSMutableDictionary *userProfile = [[NSMutableDictionary alloc] initWithCapacity:8];
            
            NSLog(@"%@", result);
            //create URL
            
            NSString *facebookId = userDictionary[@"id"];
            NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookId]];
            
        
            
            
            
            if (userDictionary[@"last_name"]) {
                userProfile[kCCuserProfileLastNameKey] = userDictionary[@"last_name"];
            }
            if (userDictionary[@"first_name"]) {
                userProfile[kCCuserProfileFistNameKey] = userDictionary[@"first_name"];
            }
            if (userDictionary[@"location"][@"name"]){
                userProfile[kCCuserProfileLocationKey] = userDictionary[@"location"][@"name"];
            }
            if (userDictionary[@"gender"]) {
                userProfile[kCCuserProfileGenderKey] = userDictionary[@"gender"];
            }
            if (userDictionary[@"birthday"]) {
                userProfile[kCCuserProfileBirthDayKey] = userDictionary[@"birthday"];
                //format to age
                
                NSDateFormatter *formatted = [[NSDateFormatter alloc] init];
                [formatted setDateStyle:NSDateFormatterShortStyle];
                NSDate *date = [formatted dateFromString:userDictionary[@"birthday"]];
                NSDate *now = [NSDate date];
                NSTimeInterval seconds = [now timeIntervalSinceDate:date];
                int age = seconds / 31536000;
                
                //convert int to NSNumber
                userProfile[kCCuserProfileAgeKey] = @(age);
                
                
            }
            if (userDictionary[@"bio"]) {
                userProfile[kCCuserProfileBioKey] = userDictionary[@"bio"];
            }
            if (userDictionary[@"email"]) {
                userProfile[kCCuserProfileEmailKey] = userDictionary[@"email"];
            }
            if ([pictureURL absoluteString]) {
                userProfile[kCCuserProfilePictureUrlKey] = [pictureURL absoluteString];
            }
            
            //save info to current user
            [[PFUser currentUser] setObject:userProfile forKey:kCCuserProfileKey];
            [[PFUser currentUser] saveInBackground];
            [self requestImage];
            
        }
        else{
            NSLog(@"Error in FB request %@", error);
        }
        
    }];
    
}

-(void)uploadPFFileToParse:(UIImage *)image
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
    if (!imageData) {
        NSLog(@"Image data was not found!");
        return;
    }
    
    //evaluate if success
    
    PFFile *photoFile = [PFFile fileWithData:imageData];
    
    [photoFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded) {
            //@"Photo"
            PFObject *photo = [PFObject objectWithClassName:kCCPhotoClassKey];
            [photo setObject:[PFUser currentUser] forKey:kCCPhotoUserKey];
            [photo setObject:photoFile forKey:kCCPhotoPictureKey];
            [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                NSLog(@"Photo saved with success");
                
            }];
        }
    }];
    
}

-(void)requestImage
{
    PFQuery *query = [PFQuery queryWithClassName:kCCPhotoClassKey];
    [query whereKey:kCCPhotoUserKey equalTo:[PFUser currentUser]];
    
    [query countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
       
        if (number == 0) {
            //no photos saved
            PFUser *user = [PFUser currentUser];
            self.imageData = [[NSMutableData alloc] init];
            
            NSURL *profilePictureUrl = [NSURL URLWithString:user[kCCuserProfileKey][kCCuserProfilePictureUrlKey]];
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL:profilePictureUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:4.0f];
            NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
            
            if (!urlConnection) {
                NSLog(@"Failed to download picture");
            }
            
            
                              
        }
    }];
    
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //build file with chunks
    [self.imageData appendData:data];
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIImage *profileImage = [UIImage imageWithData:self.imageData];
    [self uploadPFFileToParse:profileImage];
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
