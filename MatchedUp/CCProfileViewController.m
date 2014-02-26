//
//  CCProfileViewController.m
//  MatchedUp
//
//  Created by Vincent Inverso on 2/25/14.
//  Copyright (c) 2014 Vincent Inverso. All rights reserved.
//

#import "CCProfileViewController.h"

@interface CCProfileViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *profilePic;
@property (strong, nonatomic) IBOutlet UILabel *location;
@property (strong, nonatomic) IBOutlet UILabel *age;
@property (strong, nonatomic) IBOutlet UILabel *status;
@property (strong, nonatomic) IBOutlet UILabel *tagline;



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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
