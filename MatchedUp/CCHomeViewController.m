//
//  CCHomeViewController.m
//  MatchedUp
//
//  Created by Vincent Inverso on 2/25/14.
//  Copyright (c) 2014 Vincent Inverso. All rights reserved.
//

#import "CCHomeViewController.h"

@interface CCHomeViewController ()

@property (strong, nonatomic) IBOutlet UIBarButtonItem *chatBarButtonItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *settingsBarButtonItem;
@property (strong, nonatomic) IBOutlet UIImageView *photoImageView;
@property (strong, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;
@property (strong, nonatomic) IBOutlet UILabel *tagLineLable;
@property (strong, nonatomic) IBOutlet UIButton *likeButton;
@property (strong, nonatomic) IBOutlet UIButton *infoButton;
@property (strong, nonatomic) IBOutlet UIButton *dislikeButton;

@property (strong, nonatomic) NSArray * photos;
@property (strong, nonatomic) PFObject * photo;
@property (strong, nonatomic) NSMutableArray * activities;

@property (nonatomic) int currentPhotoIndex;
@property (nonatomic) BOOL isLikedByCurrentUser;
@property (nonatomic) BOOL isDislikedByCurrentUser;





@end

@implementation CCHomeViewController

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
    self.likeButton.enabled = NO;
    self.dislikeButton.enabled = NO;
    self.infoButton.enabled = NO;
    
    self.currentPhotoIndex = 0;
    
    PFQuery * query = [PFQuery queryWithClassName:kCCPhotoClassKey];
    [query includeKey:kCCPhotoUserKey];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error){
            self.photos = objects;
            [self queryForCurrentPhotoIndex];
        }
        else {
            NSLog(@"%@", error);
        }
    }];
    
    PFQuery * queryForLike = [PFQuery queryWithClassName:kCCActivityClassKey];
    [queryForLike whereKey:kCCActivityTypeKey equalTo:kCCActivityTypeLikeKey];
    [queryForLike whereKey:kCCActivityPhotoKey equalTo:self.photo];
    [queryForLike whereKey:kCCActivityFromUserKey equalTo:[PFUser currentUser]];
    
    PFQuery * queryForDislike = [PFQuery queryWithClassName:kCCActivityClassKey];
    [queryForDislike whereKey:kCCActivityTypeKey equalTo:kCCActivityTypeDislikeKey];
    [queryForDislike whereKey:kCCActivityPhotoKey equalTo:self.photo];
    [queryForDislike whereKey:kCCActivityFromUserKey equalTo:[PFUser currentUser]];
    
    PFQuery * likeDislikeQuery = [PFQuery orQueryWithSubqueries:@[queryForLike, queryForDislike]];
    [likeDislikeQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.activities = [objects mutableCopy];
            
            if ([self.activities count]==0){
                self.isLikedByCurrentUser = NO;
                self.isDislikedByCurrentUser = NO;
            }
            else {
                PFObject * activity = self.activities[0];
                
                if ([activity[kCCActivityTypeKey] isEqualToString:kCCActivityTypeLikeKey]){
                    self.isLikedByCurrentUser = YES;
                    self.isDislikedByCurrentUser = NO;
                }
                else if ([activity[kCCActivityTypeKey] isEqualToString:kCCActivityTypeDislikeKey]){
                    self.isLikedByCurrentUser = NO;
                    self.isDislikedByCurrentUser = YES;
                }
                else {
                    //some other activity
                }
            }
            self.likeButton.enabled = YES;
            self.dislikeButton.enabled = YES;
        }
        
    }];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - IBActions
- (IBAction)likeButtonPressed:(UIButton *)sender
{
    [self checkLike];
}


- (IBAction)dislikeButtonPressed:(UIButton *)sender
{
    [self checkDislike];
}


- (IBAction)infoButtonPressed:(UIButton *)sender
{
    
}


- (IBAction)settingsBarButtonItemPressed:(UIBarButtonItem *)sender
{
    
}


- (IBAction)chatBarButtonItemPressed:(UIBarButtonItem *)sender
{
    
}


-(void)queryForCurrentPhotoIndex {
    if ([self.photos count] > 0) {
        self.photo = self.photos[self.currentPhotoIndex];
        PFFile * file = self.photo[kCCPhotoPictureKey];
        [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                UIImage * image = [UIImage imageWithData:data];
                self.photoImageView.image = image;
                [self updateView];
            }
            else NSLog(@"%@", error);
        }];
        
        
        
    }
}

-(void)updateView
{
    self.firstNameLabel.text = self.photo[kCCPhotoUserKey][kCCUserProfileKey][kCCUserProfileFirstNameKey];
    self.ageLabel.text = [NSString stringWithFormat:@"%@", self.photo[kCCPhotoUserKey][kCCUserProfileKey][kCCUserProfileAgeKey]];
    self.tagLineLable.text = self.photo[kCCPhotoUserKey][kCCUserTagLineKey];
}


-(void)setupNextPhoto
{
    if ((self.currentPhotoIndex + 1) < [self.photos count])
    {
        self.currentPhotoIndex++;
        [self queryForCurrentPhotoIndex];
    }
    else {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"no more to view" message:@"check back later" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
    }
}


-(void)saveLike
{
    PFObject * likeActivity = [PFObject objectWithClassName:kCCActivityClassKey];
    [likeActivity setObject:kCCActivityTypeLikeKey forKey:kCCActivityTypeKey];
    [likeActivity setObject:[PFUser currentUser] forKey:kCCActivityFromUserKey];
    [likeActivity setObject:[self.photo objectForKey:kCCPhotoUserKey] forKey:kCCActivityToUserKey];
    [likeActivity setObject:self.photo forKey:kCCActivityPhotoKey];
    [likeActivity saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        self.isLikedByCurrentUser = YES;
        self.isDislikedByCurrentUser = NO;
        [self.activities addObject:likeActivity];
        [self setupNextPhoto];
    }];
}

-(void)saveDislike
{
    PFObject * dislikeActivity = [PFObject objectWithClassName:kCCActivityClassKey];
    [dislikeActivity setObject:kCCActivityTypeDislikeKey forKey:kCCActivityTypeKey];
    [dislikeActivity setObject:[PFUser currentUser] forKey:kCCActivityFromUserKey];
    [dislikeActivity setObject:[self.photo objectForKey:kCCPhotoUserKey] forKey:kCCActivityToUserKey];
    [dislikeActivity setObject:self.photo forKey:kCCActivityPhotoKey];
    [dislikeActivity saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        self.isLikedByCurrentUser = NO;
        self.isDislikedByCurrentUser = YES;
        [self.activities addObject:dislikeActivity];
        [self setupNextPhoto];
    }];
}

-(void)checkLike
{
    if (self.isLikedByCurrentUser){
        [self setupNextPhoto];
        return;
    }
    else if (self.isDislikedByCurrentUser) {
        for (PFObject * activity in self.activities){
            [activity deleteInBackground];
        }
        [self.activities removeLastObject];
        [self saveLike];
    }
    else {
        [self saveLike];
    }
}

-(void) checkDislike
{
    if (self.isDislikedByCurrentUser){
        [self setupNextPhoto];
        return;
    }
    else if (self.isLikedByCurrentUser) {
        for (PFObject * activity in self.activities){
            [activity deleteInBackground];
        }
        [self.activities removeLastObject];
        [self saveDislike];
    }
    else {
        [self saveDislike];
    }
    
}











@end
