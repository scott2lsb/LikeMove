//
//  OrdersViewController.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-31.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "OrdersViewController.h"

@interface OrdersViewController ()

@end

@implementation OrdersViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    _bl=[[LMShopBL alloc] init];
    _bl.delegate=self;
    [_bl getOrdersWithStatus:@"1"];
    [_bl getOrdersWithStatus:@"2"];
    [_bl getOrdersWithStatus:@"3"];
    [_bl getOrdersWithStatus:@"4"];
    /**
     顶部滑动栏
     
     :returns: NO
     */
    CGFloat yDelta;
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending) {
        yDelta = 20.0f;
    } else {
        yDelta = 0.0f;
    }
    _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"未付款", @"已付款",@"未发货",@"已发货"]];
    _segmentedControl.frame = CGRectMake(0, 0 +44+ yDelta, 320, 44);
    _segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
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
    self.scrollView.contentSize = CGSizeMake(1280, [[UIScreen mainScreen]bounds].size.height-20-44-44-49);
    self.scrollView.delegate = self;
    [self.scrollView scrollRectToVisible:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height-20-44-44-49) animated:NO];
    [self.view addSubview:self.scrollView];
    
    UIView*view =[ [UIView alloc]init];
    view.backgroundColor= [UIColor clearColor];//用作tableview
    /**
     未付款列表
     */
    _noPayTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height-64-49)];
    _noPayTableView.tag=1;
    _noPayTableView.delegate=self;
    _noPayTableView.dataSource=self;
    [self.noPayTableView setTableFooterView:view];
    /**
     已付款列表
     */
    _paidTableView=[[UITableView alloc]initWithFrame:CGRectMake(320, 0, 320, [UIScreen mainScreen].bounds.size.height-64-49)];
    _paidTableView.tag=2;
    _paidTableView.delegate=self;
    _paidTableView.dataSource=self;
    [_paidTableView setTableFooterView:view];
    /**
     已发货列表
     */
    _sendTableView=[[UITableView alloc]initWithFrame:CGRectMake(640, 0, 320, [UIScreen mainScreen].bounds.size.height-64-49)];
    _sendTableView.tag=3;
    _sendTableView.delegate=self;
    _sendTableView.dataSource=self;
    [_sendTableView setTableFooterView:view];
    /**
     已收货列表
     */
    _receivedTableView=[[UITableView alloc]initWithFrame:CGRectMake(960, 0, 320, [UIScreen mainScreen].bounds.size.height-64-49)];
    _receivedTableView.tag=4;
    _receivedTableView.delegate=self;
    _receivedTableView.dataSource=self;
    _receivedTableView.separatorInset=UIEdgeInsetsZero;
    [_receivedTableView setTableFooterView:view];

    [self.scrollView addSubview:_noPayTableView];
    [self.scrollView addSubview:_paidTableView];
    [self.scrollView addSubview:_sendTableView];
    [self.scrollView addSubview:_receivedTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
	DLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    
    [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
}
#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

#pragma mark - TableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    CrowdfundTableViewCell *cell ;
//    if (tableView.tag==0) {
//        //TODO: givedtableview
//        // 为表格行定义一个静态字符串作为标识符
//        static NSString* cellIdentifier = @"GivedCell";
//        // 从可重用表格行的队列中取出一个表格行
//        cell = [tableView dequeueReusableCellWithIdentifier:
//                cellIdentifier ];
//        if (cell == nil) {
//            cell = [[CrowdfundTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
//                                                 reuseIdentifier: cellIdentifier];
//        }
//        NSDictionary* dict=[_givedArray objectAtIndex:indexPath.row];
//        cell.nickname.text=[NSString stringWithFormat:@"赠予->%@",[dict objectForKey:@"nickname"]];
//        cell.coinNum.text=[NSString stringWithFormat:@"- %@",[dict objectForKey:@"coins_paid"]];
//        cell.coinNum.textColor=[UIColor redColor];
//        
//        
//    }else{
//        //TODO: received-tableview
//        // 为表格行定义一个静态字符串作为标识符
//        static NSString* cellIdentifier = @"ReceiveCell";
//        // 从可重用表格行的队列中取出一个表格行
//        cell = [tableView dequeueReusableCellWithIdentifier:
//                cellIdentifier ];
//        if (cell == nil) {
//            cell = [[CrowdfundTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
//                                                 reuseIdentifier: cellIdentifier];
//        }
//        NSDictionary* dict=[_givedArray objectAtIndex:indexPath.row];
//        cell.nickname.text=[NSString stringWithFormat:@"接收<-%@",[dict objectForKey:@"nickname"]];
//        cell.coinNum.text=[NSString stringWithFormat:@"+ %@",[dict objectForKey:@"coins_paid"]];
//        cell.coinNum.textColor=[UIColor greenColor];
//        
//        
//    }
    switch (tableView.tag) {
        case 1:
            ;
            break;
        case 2:
            ;
            break;
        case 3:
            ;
            break;
        case 4:
            ;
            break;
            
        default:
            break;
    }

    return nil;
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rowNum;
    switch (tableView.tag) {
        case 1:
            rowNum=_noPayArray.count;
            break;
        case 2:
            rowNum= _paidArray.count;
            break;
        case 3:
            rowNum= _sendArray.count;
            break;
        case 4:
            rowNum= _receivedArray.count;
            break;
            
        default:
            break;
    }
    return rowNum;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
#pragma mark - BLDelegate
-(void)getNoPayOrdersSuccess:(NSArray*)array{
    _noPayArray=array;
    [_noPayTableView reloadData];
};
-(void)getPaidOrdersSuccess:(NSArray*)array{
    _paidArray=array;
    [_paidTableView reloadData];
};
-(void)getSendOrdersSuccess:(NSArray*)array{
    _sendArray=array;
    [_sendTableView reloadData];
};
-(void)getReceivedOrdersSuccess:(NSArray*)array{
    _receivedArray=array;
    [_receivedTableView reloadData];
};
@end
