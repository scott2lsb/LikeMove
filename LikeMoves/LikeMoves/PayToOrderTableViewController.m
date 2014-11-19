//
//  PayToOrderTableViewController.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-11-11.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "PayToOrderTableViewController.h"
#import "PartnerConfig.h"
#import "DataSigner.h"
#import "AlixPayResult.h"
#import "DataVerifier.h"
#import "AlixPayOrder.h"
#import "AlixLibService.h"
@interface PayToOrderTableViewController ()
{
    SEL _result;
}
@end

@implementation PayToOrderTableViewController
@synthesize result = _result;
NSString* orderID;
CGFloat realPrice;
User* user;
- (void)viewDidLoad
{
    [super viewDidLoad];
    _result = @selector(paymentResult:);
    _userBl=[[LMUserActBL alloc] init];
    
    _bl=[[LMShopBL alloc] init];
    _bl.delegate=self;
    UIView*view =[ [UIView alloc]init];
    view.backgroundColor= [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
    user=[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults                                                            standardUserDefaults] objectForKey:mUserInfo]];
    _userBalance.text=[NSString stringWithFormat:@"￥%0.2f",[user.balance floatValue]];
    _totalPrice.text=[NSString stringWithFormat:@"￥%0.2f",[[_dict objectForKey:@"total_price"] floatValue]];
    _deduction.text=[NSString stringWithFormat:@"￥%0.2f",[[_dict objectForKey:@"deduction_coins"] floatValue]/100];
    realPrice=[[_dict objectForKey:@"real_price"] floatValue];
    _realPrice.text=[NSString stringWithFormat:@"￥%0.2f",realPrice];
    orderID=[_dict objectForKey:@"order_id"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


#pragma mark - TableView Delegate
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    if (indexPath.section==1&indexPath.row==0) {
        //TODO:余额支付
        NSString* md5=@"111111";
        NSString*pwd=[self md5:md5];
        DLog(@"余额支付=%@=%@",user.password,pwd);
        UIAlertView* alertDesc=[[UIAlertView alloc] initWithTitle:@"请输入登陆密码" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertDesc.alertViewStyle=UIAlertViewStyleSecureTextInput;
        alertDesc.delegate=self;
        alertDesc.tag=1024;
        [alertDesc show];

    }else if (indexPath.section==1&indexPath.row==1){
        //TODO:支付宝支付
        DLog(@"支付宝支付");
        /*
         *生成订单信息及签名
         *由于demo的局限性，采用了将私钥放在本地签名的方法，商户可以根据自身情况选择签名方法(为安全起见，在条件允许的前提下，我们推荐从商户服务器获取完整的订单信息)
         */
        
        NSString *appScheme = @"LikeMoves";
        NSString* orderInfo = [self getOrderInfo:indexPath.row];
        NSString* signedStr = [self doRsa:orderInfo];
        
        
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                                 orderInfo, signedStr, @"RSA"];

        [AlixLibService payOrder:orderString AndScheme:appScheme seletor:_result target:self];

    }else{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow]animated:YES];
    }
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

- (IBAction)cancelPayTo:(id)sender {
    int index=[[self.navigationController viewControllers]indexOfObject:self];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index-2]animated:YES];
}
#pragma mark - SHOPBL Delegate
-(void)payWithBalanceSuccess{
    [_userBl refreshMyself];
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"付款成功!" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
    alert.tag=1025;
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==1025&buttonIndex==0) {
        
        int index=[[self.navigationController viewControllers]indexOfObject:self];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index-2]animated:YES];
        
    }else if(alertView.tag==1024&buttonIndex==1){//输入密码进行付费
        NSString* pwd=[self md5:[alertView textFieldAtIndex:0].text];
        DLog(@"md5-----%@===%@",[alertView textFieldAtIndex:0].text,pwd);
        if([user.password isEqualToString:pwd]){
            [_bl payOrderWithOrderID:orderID];
        }else{
            UIAlertView* alertWaring=[[UIAlertView alloc] initWithTitle:@"密码错误!" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alertWaring show];
        }
    }

}
-(void)payWithAlipaySuccess{
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"付款成功!" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
    alert.tag=0;
    [alert show];
}
#pragma mark - alipay-method

-(NSString*)getOrderInfo:(NSInteger)index
{
    /*
	 *点击获取prodcut实例并初始化订单信息
	 */

    AlixPayOrder *order = [[AlixPayOrder alloc] init];
    order.partner = PartnerID;
    order.seller = SellerID;
    
    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
	order.productName = @"里环王特价优惠商品"; //商品标题
	order.productDescription = @"里环王特价优惠折扣商品"; //商品描述
	order.amount = [NSString stringWithFormat:@"%.2f",realPrice]; //商品价格
	order.notifyURL =  @"http%3A%2F%2Fwwww.xxx.com"; //回调URL
	
	return [order description];
}

- (NSString *)generateTradeNO
{
	return orderID;
}

-(NSString*)doRsa:(NSString*)orderInfo
{
    id<DataSigner> signer;
    signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:orderInfo];
    return signedString;
}

-(void)paymentResultDelegate:(NSString *)result
{
    DLog(@"pay-result-Delegate=%@",result);
}
//wap回调函数
-(void)paymentResult:(NSString *)resultd
{
    //结果处理

    AlixPayResult* result = [[AlixPayResult alloc] initWithString:resultd];

	if (result)
    {
		
		if (result.statusCode == 9000)
        {
			/*
			 *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
			 */
            
            //交易成功
            NSString* key = AlipayPubKey;//签约帐户后获取到的支付宝公钥
			id<DataVerifier> verifier;
            verifier = CreateRSADataVerifier(key);
            
			if ([verifier verifyString:result.resultString withSign:result.signString])
            {
                //验证签名成功，交易结果无篡改
                DLog(@"交易成功！");
                [_bl payOrderWithOrderID:orderID alipay:_realPrice.text];
//                int index=[[self.navigationController viewControllers]indexOfObject:self];
//                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index-2]animated:YES];
			}
        }
        else
        {
            //TODO:交易失败
        }
    }
    else
    {
        //失败
    }
    
}

//md5 32位 加密 （小写）
-(NSString *)md5:(NSString *)str {
    
    
    
    const char *cStr = [str UTF8String];
    
    
    
    unsigned char result[32];
    
    
    
    CC_MD5( cStr, strlen(cStr), result );
    
    
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0],result[1],result[2],result[3],
            
            result[4],result[5],result[6],result[7],
            
            result[8],result[9],result[10],result[11],
            
            result[12],result[13],result[14],result[15]];
    
}
@end
