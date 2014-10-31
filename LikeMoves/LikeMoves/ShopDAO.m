//
//  ShopDAO.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-6.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "ShopDAO.h"

@implementation ShopDAO

/**
 *  将金币赠送给朋友
 *
 *  @param friendID 目标朋友的id
 *  @param coinNum  赠送的金币数量
 */
-(void)giveCoinsToFriend:(NSString*)friendID withCoins:(NSString*)coinNum{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=giveCoins&friend_id=%@&coins=%@",friendID,coinNum];//在请求的后面添加请求参数
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"give-coin-JSON: %@", operation.responseString);
        //请求成功，回调的BL的delegate
        //[_delegate XXX];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error: %@", error);
        //请求失败，回调BL的delegate
        //[_delegate XXX];
    }];
    
};
/**
 *  获得赠送金币的记录
 */
-(void)getGivedCoinsRecord{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=getGivedCoins"];//在请求的后面添加请求参数
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"give-coin-record-JSON: %@", operation.responseString);
        NSArray* array=[self jsonListToFriendArray:operation.responseString];
        //请求成功，回调的BL的delegate
        [_delegate getGivedCoinsRecordSuccess:array];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error: %@", error);
        //请求失败，回调BL的delegate
        //[_delegate XXX];
    }];

};
/**
 *  获得接收金币的记录
 */
-(void)getRecievedCoinsRecord{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=getRecievedCoins"];//在请求的后面添加请求参数
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"recie-coin-JSON: %@", operation.responseString);
        NSArray* array=[self jsonListToFriendArray:operation.responseString];
        //请求成功，回调的BL的delegate
        [_delegate getReceivedCoinsRecordSuccess:array];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error: %@", error);
        //请求失败，回调BL的delegate
        //[_delegate XXX];
    }];

};

/**
 *  获得商品类别
 */
-(void)getCategories{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=getCategories"];//在请求的后面添加请求参数
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"category-JSON: %@", operation.responseString);
        //请求成功，回调的BL的delegate
        //[_delegate XXX];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error: %@", error);
        //请求失败，回调BL的delegate
        //[_delegate XXX];
    }];

};
/**
 *  获得推广的商品内容
 */
-(void)getProductsInPromotion{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    //TODO: 进行排序，添加promotion字段
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=getProducts&promotion=1"];//在请求的后面添加请求参数
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"推广商品-JSON: %@", operation.responseString);
        
        //请求成功，回调的BL的delegate
        [_delegate getProductInPromotionSuccess:[self jsonListToFriendArray:operation.responseString]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error: %@", error);
        //请求失败，回调BL的delegate
        //[_delegate XXX];
    }];

};
/**
 *  将商品评论添加到商品中
 *
 *  @param productID 商品的编号
 *  @param desc      商品评论
 */
-(void)addProductCommentToProduct:(NSString*)productID withDesc:(NSString*)desc{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=addProductComment&product_id=%@&desc=%@",productID,desc];//在请求的后面添加请求参数
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"添加评论-JSON: %@", operation.responseString);
        //请求成功，回调的BL的delegate
        //[_delegate XXX];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error: %@", error);
        //请求失败，回调BL的delegate
        //[_delegate XXX];
    }];

};
/**
 *  获得商品的评论
 *
 *  @param productID 商品的id
 */
-(void)getProductComments:(NSString*)productID{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=getProductComments&product_id=%@",productID];//在请求的后面添加请求参数
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"获得商品评论-JSON: %@", operation.responseString);
        //请求成功，回调的BL的delegate
        //[_delegate XXX];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error: %@", error);
        //请求失败，回调BL的delegate
        //[_delegate XXX];
    }];

};
/**
 *  添加收货人信息
 *
 *  @param name  收货人姓名
 *  @param addr  收货人地址
 *  @param phone 收货人手机号
 */
-(void)addReceiverWithName:(NSString*)name address:(NSString*)addr phone:(NSString*)phone{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=addReceiver&address=%@&receiver=%@&phone=%@",addr,name,phone];//在请求的后面添加请求参数
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"添加收货人JSON: %@", operation.responseString);
        //请求成功，回调的BL的delegate
        //[_delegate XXX];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error: %@", error);
        //请求失败，回调BL的delegate
        //[_delegate XXX];
    }];

};
/**
 *  删除收货人信息
 *
 *  @param receiverID 收货人信息的ID
 */
-(void)delReceiver:(NSString*)receiverID{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=delReceiver&receiver_id=%@",receiverID];//在请求的后面添加请求参数
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"删除收货人JSON: %@", operation.responseString);
        //请求成功，回调的BL的delegate
        //[_delegate XXX];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error: %@", error);
        //请求失败，回调BL的delegate
        //[_delegate XXX];
    }];

};
/**
 *  编辑收货人信息
 *
 *  @param receiverID 收货人信息的id
 *  @param name       收货人姓名
 *  @param addr       收货人地址
 *  @param phone      收货人联系电话
 */
-(void)modifyReceiver:(NSString*)receiverID name:(NSString*)name address:(NSString*)addr phone:(NSString*)phone{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=modifyReceiver&receiver_id=%@&receiver=%@&address=%@&phone=%@",receiverID,name,addr,phone];//在请求的后面添加请求参数
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"编辑收货人JSON: %@", operation.responseString);
        //请求成功，回调的BL的delegate
        //[_delegate XXX];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error: %@", error);
        //请求失败，回调BL的delegate
        //[_delegate XXX];
    }];

};
/**
 *  获得收货人信息
 */
-(void)getReceiver{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=getReceivers"];//在请求的后面添加请求参数
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"获得收货人JSON: %@", operation.responseString);
        //请求成功，回调的BL的delegate
        //if result为1进行这个操作，不是1则操作失败
        NSArray* array=[self jsonListToFriendArray:operation.responseString];
        [_delegate getReceiversSuccess:array];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error: %@", error);
        //请求失败，回调BL的delegate
        //[_delegate XXX];
    }];

};
/**
 *  将商品添加到购物车中
 *
 *  @param productID 商品id
 *  @param num       商品数量
 *  @param comment   商品备注
 */
-(void)addShoppingCartWithProductID:(NSString*)productID number:(NSString*)num comment:(NSString*)comment{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=addShoppingCart&product_id=%@&number=%@",productID,num];//在请求的后面添加请求参数
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"添加商品到购物车JSON: %@", operation.responseString);
        //请求成功，回调的BL的delegate
        //[_delegate XXX];
        [_delegate addToCartSuccess];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error: %@", error);
        //请求失败，回调BL的delegate
        //[_delegate XXX];
    }];

};
/**
 *  从购物车中删除商品
 *
 *  @param shopID 购物车中商品编号
 */
-(void)delShoppingCartWithShopID:(NSString*)shopID{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=delShoppingCart&shopping_id=%@",shopID];//在请求的后面添加请求参数
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"从购物车中删除商品JSON: %@", operation.responseString);
        //请求成功，回调的BL的delegate
        //[_delegate XXX];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error: %@", error);
        //请求失败，回调BL的delegate
        //[_delegate XXX];
    }];

};
/**
 *  编辑购物车信息
 *
 *  @param shopID  商品编号
 *  @param number  商品数量
 *  @param comment 备注
 */
-(void)modifyShoppingCartWithShopID:(NSString*)shopID number:(NSString*)number comment:(NSString*)comment{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=modifyShoppingCart&shopping_id=%@&number=%@",shopID,number];//在请求的后面添加请求参数
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"编辑购物车信息JSON: %@", operation.responseString);
        //请求成功，回调的BL的delegate
        //[_delegate XXX];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error: %@", error);
        //请求失败，回调BL的delegate
        //[_delegate XXX];
    }];

};
/**
 *  获得所有购物车信息
 */
-(void)getShoppingCarts{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=getShoppingCarts&page=1&per_page=10"];//在请求的后面添加请求参数
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"获得购物车信息JSON: %@", operation.responseString);
        NSArray* array=[self jsonListToFriendArray:operation.responseString];
        //请求成功，回调的BL的delegate
        [_delegate getShopingCartsSuccess:array];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error: %@", error);
        //请求失败，回调BL的delegate
        //[_delegate XXX];
    }];

};

/**
 *  将购物车添加到订单中
 *
 *  @param shopIDs      购物车id，多个id使用“，”分割
 *  @param receiverID   收货人信息id
 *  @param coinNum      抵扣金币数量
 *  @param comment      备注
 *  @param shipMethod   收货方式0:保留, 1:送货, 2:自提
 *  @param phoneConfirm 是否进行电话确认
 *  @param userID       用户id
 */
-(void)addOrderWithShopIds:(NSString*)shopIDs receiverID:(NSString*)receiverID coins:(NSString*)coinNum comment:(NSString*)comment shipingMethod:(NSString*)shipMethod phoneConfirm:(NSString*)phoneConfirm userID:(NSString*)userID{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=addOrder&shopping_ids=%@&receiver_id=%@&coins=%@&shiping_method=%@&comment=%@",shopIDs,receiverID,coinNum,shipMethod,comment];//在请求的后面添加请求参数
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"将购物车添加到订单JSON: %@", operation.responseString);
        //请求成功，回调的BL的delegate
        //[_delegate XXX];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error: %@", error);
        //请求失败，回调BL的delegate
        //[_delegate XXX];
    }];

};
/**
 *  订单付费
 *
 *  @param orderID 订单号
 */
//TODO: 暂时存在问题
-(void)payOrderWithOrderID:(NSString*)orderID alipay:(NSString*)alipayNum{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=payOrder&order_id=%@&paid_other=%@",orderID,alipayNum];//在请求的后面添加请求参数
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"pay-JSON: %@", operation.responseString);
        //请求成功，回调的BL的delegate
        //[_delegate XXX];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error: %@", error);
        //请求失败，回调BL的delegate
        //[_delegate XXX];
    }];

};
/**
 *  获得各种状态订单
 *
 *  @param status 订单状态0:保留, 1:未付款, 2:已付款 3:已发货 4:已收货 5:已取消
 */
-(void)getOrdersWithStatus:(NSString*)status{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=getOrders&status=%@",status];//在请求的后面添加请求参数
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"order-status-JSON: %@", operation.responseString);
        //请求成功，回调的BL的delegate
        //[_delegate XXX];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error: %@", error);
        //请求失败，回调BL的delegate
        //[_delegate XXX];
    }];

};

/**
 *  确认收货
 *
 *  @param orderID 订单id
 */
-(void)confirmReceiptWithOrderID:(NSString*)orderID{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=confirmReceipt&order_id=%@",orderID];//在请求的后面添加请求参数
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"receipt-JSON: %@", operation.responseString);
        //请求成功，回调的BL的delegate
        //[_delegate XXX];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error: %@", error);
        //请求失败，回调BL的delegate
        //[_delegate XXX];
    }];

};
/**
 *  获得金币折算比例
 */
-(void)getCoinsRate{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=getCoinsRate"];//在请求的后面添加请求参数
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"coin-rate-JSON: %@", operation.responseString);
        //请求成功，回调的BL的delegate
        //[_delegate XXX];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error: %@", error);
        //请求失败，回调BL的delegate
        //[_delegate XXX];
    }];

};
/**
 *  添加金币
 *
 *  @param coinsNum 要添加的金币数量
 */
-(void)addCoins:(NSString*)coinsNum{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=addCoins&coins=%@",coinsNum];//在请求的后面添加请求参数
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"add-coin-JSON: %@", operation.responseString);
        //请求成功，回调的BL的delegate
        //[_delegate XXX];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error: %@", error);
        //请求失败，回调BL的delegate
        //[_delegate XXX];
    }];

};
/**
 *  通过订单ID获得订单
 *
 *  @param orderID 订单ID
 */
-(void)getOrderByOrderID:(NSString*)orderID{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=getOrders=%@",orderID];//在请求的后面添加请求参数
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"order-id-JSON: %@", operation.responseString);
        //请求成功，回调的BL的delegate
        //[_delegate XXX];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error: %@", error);
        //请求失败，回调BL的delegate
        //[_delegate XXX];
    }];
    

};
/**
 *  json字符串转化为数组
 *
 *  @param json json字符串
 *
 *  @return 数组
 */
-(NSArray*)jsonListToFriendArray:(NSString*)json{
    NSDictionary* dict=[json objectFromJSONString];
    NSArray* friends=[dict objectForKey:@"list"];
    return friends;
}
@end

