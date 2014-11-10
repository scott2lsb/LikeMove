//
//  CrowdfundViewController.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-30.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "CrowdfundViewController.h"
#import "UMSocial_Sdk_Extra_Frameworks/UMSocial_ScreenShot_Sdk/UMSocialScreenShoter.h"
@interface CrowdfundViewController ()

@end

@implementation CrowdfundViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    _bl=[[LMShopBL alloc]init];
    _bl.delegate=self;
    [_bl getGivedCoinsRecord];
    [_bl getRecievedCoinsRecord];
    /**
     *  自定义赠送列表
     */
    _givedTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height-64-44-49)];
    _givedTableView.tag=0;
    _givedTableView.delegate=self;
    _givedTableView.dataSource=self;
    UIView*view =[ [UIView alloc]init];
    view.backgroundColor= [UIColor clearColor];
    [self.givedTableView setTableFooterView:view];
    /**
     自定义收取列表
     */
    _receivedTableView=[[UITableView alloc]initWithFrame:CGRectMake(320, 0, 320, [UIScreen mainScreen].bounds.size.height-64-44-49)];
    _receivedTableView.tag=1;
    _receivedTableView.delegate=self;
    _receivedTableView.dataSource=self;
    [self.receivedTableView setTableFooterView:view];
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat yDelta;
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending) {
        yDelta = 20.0f;
    } else {
        yDelta = 0.0f;
    }
    
    /**
     顶部滑动栏
     
     :returns: NO
     */
    _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"赠送列表", @"接受列表"]];
    _segmentedControl.frame = CGRectMake(0, 0 +44+ yDelta, 320, 44);
    _segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segmentedControl.selectionIndicatorColor=[UIColor orangeColor];
    [_segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:_segmentedControl];
    
    
    __weak typeof(self) weakSelf = self;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(320 * index, 0, 320, [[UIScreen mainScreen] bounds].size.height-20-44-44-49) animated:YES];
    }];
    
    [self.view addSubview:self.segmentedControl];
    /**
     滑动页面
     
     :returns: none
     */
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,108, 320, [[UIScreen mainScreen]bounds].size.height-20-44-44-49)];
    self.scrollView.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(640, [[UIScreen mainScreen]bounds].size.height-20-44-44-49);
    self.scrollView.delegate = self;
    [self.scrollView scrollRectToVisible:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height-20-44-44-49) animated:NO];
    [self.view addSubview:self.scrollView];
    [_scrollView addSubview:_givedTableView];
    [_scrollView addSubview:_receivedTableView];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

#pragma mark - TableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CrowdfundTableViewCell *cell ;
    if (tableView.tag==0) {
        //TODO: givedtableview
        // 为表格行定义一个静态字符串作为标识符
        static NSString* cellIdentifier = @"GivedCell";
        // 从可重用表格行的队列中取出一个表格行
        cell = [tableView dequeueReusableCellWithIdentifier:
                                 cellIdentifier ];
        if (cell == nil) {
            cell = [[CrowdfundTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                          reuseIdentifier: cellIdentifier];
        }
        NSDictionary* dict=[_givedArray objectAtIndex:_givedArray.count-1-indexPath.row];
        cell.nickname.text=[NSString stringWithFormat:@"赠予 -> %@",[dict objectForKey:@"nickname"]];
        cell.coinNum.text=[NSString stringWithFormat:@"- %@",[dict objectForKey:@"coins_paid"]];
        cell.coinNum.textColor=[UIColor redColor];
        

    }else{
        //TODO: received-tableview
        // 为表格行定义一个静态字符串作为标识符
        static NSString* cellIdentifierReceiver = @"ReceiveCell";
        // 从可重用表格行的队列中取出一个表格行
        cell = [tableView dequeueReusableCellWithIdentifier:
                                 cellIdentifierReceiver ];
        if (cell == nil) {
            cell = [[CrowdfundTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                          reuseIdentifier: cellIdentifierReceiver];
        }
        NSDictionary* dict=[_receivedArray objectAtIndex:_receivedArray.count-1-indexPath.row];
        cell.nickname.text=[NSString stringWithFormat:@"接收 <- %@",[dict objectForKey:@"nickname"]];
        cell.coinNum.text=[NSString stringWithFormat:@"+ %@",[dict objectForKey:@"coins_received"]];
        cell.coinNum.textColor=[UIColor greenColor];
        

    }
    return cell;
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag==0) {
        return _givedArray.count;
    }else{
        return _receivedArray.count;
    }

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x/ pageWidth;
    
    [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
}
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
	DLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
}
#pragma mark - ShopBLDelegate
-(void)getReceivedCoinsRecordSuccess:(NSArray *)array{
    _receivedArray=[array copy];
    [_receivedTableView reloadData];
}
-(void)getGivedCoinsRecordSuccess:(NSArray *)array{
    _givedArray=[array copy];
    [_givedTableView reloadData];
}
- (IBAction)share:(id)sender {
    [_bl startCrowdfund];
    
    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
    
    [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeImage;
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
    NSArray* array;
    if ([WXApi isWXAppInstalled]) {
        array=[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,nil];
    }else{
        array=[NSArray arrayWithObjects:UMShareToSina,UMShareToQzone,UMShareToQQ,nil];
    }
    UIImage *image = [[UMSocialScreenShoterDefault screenShoter] getScreenShot];
    
    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
    User* user=[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:mUserInfo]];
    NSString* name=user.nickName;
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:nil
                                      shareText:[NSString stringWithFormat:@"木有金币啦，求赞助，求包养，快来加入里环王吧！%@",name]
                                     shareImage:image
                                shareToSnsNames:array
                                       delegate:nil];
}
@end
