//
//  MoreTableViewController.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-29.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "MoreTableViewController.h"

@interface MoreTableViewController ()

@end

@implementation MoreTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView*view =[ [UIView alloc]init];
    view.backgroundColor= [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

- (IBAction)emailUS:(id)sender {
    
    if (![MFMailComposeViewController canSendMail]) {
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"用户没有设置邮件账户" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }else{
            MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
        mailPicker.mailComposeDelegate=self;
            //设置主题
            [mailPicker setSubject: @"里环王应用相关"];
            //添加收件人
            NSArray *toRecipients = [NSArray arrayWithObject: @"lihuanone@yeah.net"];
            [mailPicker setToRecipients: toRecipients];
            //添加抄送
//            NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
            [mailPicker setCcRecipients:nil];
            //添加密送
//            NSArray *bccRecipients = [NSArray arrayWithObjects:@"fourth@example.com", nil];
            [mailPicker setBccRecipients:nil];
        
            NSString *emailBody = @"<font color='orange'>里环王</font>";
            [mailPicker setMessageBody:emailBody isHTML:YES];
        [self presentViewController:mailPicker animated:YES completion:nil];
    }
}

- (IBAction)commentAPP:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/jia-zai-lin-yi/id792621424?mt=8"]];

}


#pragma mark - 实现 MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    //关闭邮件发送窗口

    [controller dismissViewControllerAnimated:YES completion:Nil];

}
@end
