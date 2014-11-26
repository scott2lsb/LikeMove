//
//  CompanyIntroViewController.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-11-26.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "CompanyIntroViewController.h"

@interface CompanyIntroViewController ()

@end

@implementation CompanyIntroViewController

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
    //背景图片设置
    UIImageView* img=[[UIImageView alloc] initWithFrame:self.view.bounds];
    img.image=[[UIImage imageNamed:@"launch2"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    [self.view addSubview:img];
    [self.view sendSubviewToBack:img];
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

- (IBAction)backTo:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)backToPast:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
