//
//  OrdersViewController.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-31.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "OrdersViewController.h"
#import "OrderTableViewCell.h"
@interface OrdersViewController ()

@end

@implementation OrdersViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    _bl=[[LMShopBL alloc] init];
    _bl.delegate=self;
   
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
    _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"未付款", @"已付款",@"已发货",@"已收货"]];
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
-(void)viewWillAppear:(BOOL)animated{
    [_bl getOrdersWithStatus:@"1"];
    [_bl getOrdersWithStatus:@"2"];
    [_bl getOrdersWithStatus:@"3"];
    [_bl getOrdersWithStatus:@"4"];
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
//    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    switch (tableView.tag) {
        case 1:{
            NSDictionary* received=[_noPayArray objectAtIndex:indexPath.row];
            
            UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ReceiverOrderDetailTableViewController *tabVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"NoPaidPage"];
            tabVC.dict=received;
            [self.navigationController pushViewController:tabVC animated:YES];
            break;
        }
        case 2:{
            NSDictionary* received=[_paidArray objectAtIndex:indexPath.row];

                UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                ReceiverOrderDetailTableViewController *tabVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"PaidOrderPage"];
                tabVC.dict=received;
                [self.navigationController pushViewController:tabVC animated:YES];

            break;
        }
        case 3:{
            NSDictionary* received=[_sendArray objectAtIndex:indexPath.row];

                UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                SendOrderTableViewController *tabVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"SendOrderPage"];
                tabVC.dict=received;
                [self.navigationController pushViewController:tabVC animated:YES];
            
            break;
        }
        case 4:{
            NSDictionary* received=[_receivedArray objectAtIndex:indexPath.row];
            if([[received objectForKey:@"type"] intValue]==2){
                UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                ReceiverOrderDetailTableViewController *tabVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"ReceiverOrderPage"];
                tabVC.dict=received;
                [self.navigationController pushViewController:tabVC animated:YES];
            }
            break;
        }
        default:
            break;
    }
}

#pragma mark - TableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderTableViewCell*cell;
    static NSString*              cellIdentifier;
    switch (tableView.tag) {
        case 1:{
            
        
            cellIdentifier = @"noPaidCell";
            cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[OrderTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                              reuseIdentifier: cellIdentifier];
            }
            NSDictionary* dictNO=            [_noPayArray objectAtIndex:indexPath.row];
            cell.orderNO.text=[NSString stringWithFormat:@"订单号:%@",[dictNO objectForKey:@"order_no"]];
            cell.createTime.text=[NSString stringWithFormat:@"创建时间:%@",[dictNO objectForKey:@"create_time"]];
            cell.totalPrice.text=[NSString stringWithFormat:@"总价:%@",[dictNO objectForKey:@"total_price"]];
            NSArray* num=(NSArray*)[dictNO objectForKey:@"shopping_carts"];
            if(![num isKindOfClass:[NSNull class]]){
            cell.productNO.text=[NSString stringWithFormat:@"商品数量:%d",num.count];
            }else{
              cell.productNO.text=@"商品数量:0";
            }
            break;
            }
        case 2:{
            cellIdentifier = @"paidCell";
            cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[OrderTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                              reuseIdentifier: cellIdentifier];
            }
            NSDictionary* dictNO=            [_paidArray objectAtIndex:indexPath.row];
            cell.orderNO.text=[NSString stringWithFormat:@"订单号:%@",[dictNO objectForKey:@"order_no"]];
            cell.createTime.text=[NSString stringWithFormat:@"创建时间:%@",[dictNO objectForKey:@"create_time"]];
            cell.totalPrice.text=[NSString stringWithFormat:@"总价:%@",[dictNO objectForKey:@"total_price"]];
            NSArray* num=(NSArray*)[dictNO objectForKey:@"shopping_carts"];
            if(![num isKindOfClass:[NSNull class]]){
                cell.productNO.text=[NSString stringWithFormat:@"商品数量:%d",num.count];
            }else{
                cell.productNO.text=@"商品数量：0";
            }
            break;
            }
        case 3:{
            cellIdentifier = @"sendCell";
            cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[OrderTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                              reuseIdentifier: cellIdentifier];
            }
            NSDictionary* dictNO=            [_sendArray objectAtIndex:indexPath.row];
            cell.orderNO.text=[NSString stringWithFormat:@"订单号:%@",[dictNO objectForKey:@"order_no"]];
            cell.createTime.text=[NSString stringWithFormat:@"创建时间：%@",[dictNO objectForKey:@"create_time"]];
            cell.totalPrice.text=[NSString stringWithFormat:@"总价:%@",[dictNO objectForKey:@"total_price"]];
            NSArray* num=(NSArray*)[dictNO objectForKey:@"shopping_carts"];
            if(![num isKindOfClass:[NSNull class]]){
                cell.productNO.text=[NSString stringWithFormat:@"商品数量:%d",num.count];
            }else{
                cell.productNO.text=@"商品数量:0";
            }            break;}
        case 4:{
            cellIdentifier = @"receivedCell";
            cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[OrderTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                              reuseIdentifier: cellIdentifier];
            }
            NSDictionary* dictNO=            [_receivedArray objectAtIndex:indexPath.row];
            cell.orderNO.text=[NSString stringWithFormat:@"订单号:%@",[dictNO objectForKey:@"order_no"]];
            cell.createTime.text=[NSString stringWithFormat:@"创建时间:%@",[dictNO objectForKey:@"create_time"]];
            cell.totalPrice.text=[NSString stringWithFormat:@"总价:%@",[dictNO objectForKey:@"total_price"]];
            NSArray* num=(NSArray*)[dictNO objectForKey:@"shopping_carts"];
            if(![num isKindOfClass:[NSNull class]]){
                cell.productNO.text=[NSString stringWithFormat:@"商品数量:%d",num.count];
            }else{
                cell.productNO.text=@"商品数量:0";
            }
            break;
        }
        default:
            break;
    }
    return cell;
    
    
    
    
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
    if ([array isKindOfClass:[NSNull class]]) {
        _noPayTableView.hidden=YES;
        UILabel* label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height-64-49)];
        label.textAlignment=NSTextAlignmentCenter;
        label.text=@"你还没有订单哦！";
        label.textColor=[UIColor grayColor];
                label.backgroundColor=[UIColor whiteColor];
        [self.scrollView addSubview:label];

        _noPayArray=nil;
    }else{
                _noPayTableView.hidden=NO;
        _noPayArray=[array mutableCopy];
        [_noPayTableView reloadData];
        
    }
    
};
-(void)getPaidOrdersSuccess:(NSArray*)array{
    if ([array isKindOfClass:[NSNull class]]) {
        _paidTableView.hidden=YES;
        UILabel* label=[[UILabel alloc] initWithFrame:CGRectMake(320, 0, 320, [UIScreen mainScreen].bounds.size.height-64-49)];
        label.textAlignment=NSTextAlignmentCenter;
        label.text=@"你还没有订单哦！";
        label.textColor=[UIColor grayColor];
                label.backgroundColor=[UIColor whiteColor];
        [self.scrollView addSubview:label];

        
        _noPayArray=nil;
    }else{
        _paidTableView.hidden=NO;
        _paidArray=[array mutableCopy];
        [_paidTableView reloadData];
        
    }
    
};
-(void)getSendOrdersSuccess:(NSArray*)array{
    if ([array isKindOfClass:[NSNull class]]) {
        _sendTableView.hidden=YES;
        UILabel* label=[[UILabel alloc] initWithFrame:CGRectMake(640, 0, 320, [UIScreen mainScreen].bounds.size.height-64-49)];
        label.textAlignment=NSTextAlignmentCenter;
        label.text=@"你还没有订单哦！";
        label.textColor=[UIColor grayColor];
                label.backgroundColor=[UIColor whiteColor];
        [self.scrollView addSubview:label];

        
        _sendArray=nil;
    }else{
        _sendTableView.hidden=NO;
        _sendArray=[array mutableCopy];
        [_sendTableView reloadData];
    }
    
    
};
-(void)getReceivedOrdersSuccess:(NSArray*)array{
    if ([array isKindOfClass:[NSNull class]]) {
        _receivedTableView.hidden=YES;
        UILabel* label=[[UILabel alloc] initWithFrame:CGRectMake(960, 0, 320, [UIScreen mainScreen].bounds.size.height-64-49)];
        label.textAlignment=NSTextAlignmentCenter;
        label.text=@"你还没有订单哦！";
        label.textColor=[UIColor grayColor];
        label.backgroundColor=[UIColor whiteColor];
        [self.scrollView addSubview:label];

        
        _receivedArray=nil;

    }else{
        _receivedTableView.hidden=NO;
        _receivedArray=[array mutableCopy];
        [_receivedTableView reloadData];
    }
};
@end
