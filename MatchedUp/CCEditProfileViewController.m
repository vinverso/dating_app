//
//  CCEditProfileViewController.m
//  MatchedUp
//
//  Created by Vincent Inverso on 2/25/14.
//  Copyright (c) 2014 Vincent Inverso. All rights reserved.
//

#import "CCEditProfileViewController.h"

@interface CCEditProfileViewController ()

@property (strong, nonatomic) IBOutlet UITextView *tagline;
@property (strong, nonatomic) IBOutlet UIImageView *profilePic;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions


- (IBAction)savePressed:(UIBarButtonItem *)sender {
}

@end
