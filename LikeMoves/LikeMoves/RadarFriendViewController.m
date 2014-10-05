//
//  RadarFriendViewController.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-4.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "RadarFriendViewController.h"
@interface RadarFriendViewController ()

@end

@implementation RadarFriendViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStylePulse color:[UIColor emerlandColor]];
    
    spinner.center = CGPointMake(160,189);
    
    [self.view addSubview:spinner];
    [self.view bringSubviewToFront:spinner];
    [spinner stopAnimating];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
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

- (IBAction)backTo:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)radarSearch:(id)sender {
        [spinner startAnimating];
}

@end
