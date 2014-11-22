//
//  MoreTableViewController.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-29.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
@interface MoreTableViewController : UITableViewController<MFMailComposeViewControllerDelegate>

- (IBAction)emailUS:(id)sender;

- (IBAction)commentAPP:(id)sender;
@end
