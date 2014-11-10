//
//  ShopDAO.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-6.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"
#import "LMShopDAODelegate.h"
#import "AFNetworking.h"
@interface ShopDAO : NSObject
@property(weak,nonatomic) id<LMShopDAODelegate> delegate;
/**
 *  将金币赠送给朋友
 *
 *  @param friendID 目标朋友的id
 *  @param coinNum  赠送的金币数量
 */
-(void)giveCoinsToFriend:(NSString*)friendID withCoins:(NSString*)coinNum;
/**
 *  获得赠送金币的记录
 */
-(void)getGivedCoinsRecord;
/**
 *  获得接收金币的记录
 */
-(void)getRecievedCoinsRecord;
/**
 *  开启众筹
 */
-(void)startCrowdfund;
/**
 *  获得商品类别
 */
-(void)getCategories;
/**
 *  获得推广的商品内容
 */
-(void)getProductsInPromotion;
/**
 *  将商品评论添加到商品中
 *
 *  @param productID 商品的编号
 *  @param desc      商品评论
 */
-(void)addProductCommentToProduct:(NSString*)productID withDesc:(NSString*)desc;
/**
 *  获得商品的评论
 *
 *  @param productID 商品的id
 */
-(void)getProductComments:(NSString*)productID;
/**
 *  添加收货人信息
 *
 *  @param name  收货人姓名
 *  @param addr  收货人地址
 *  @param phone 收货人手机号
 */
-(void)addReceiverWithName:(NSString*)name address:(NSString*)addr phone:(NSString*)phone;
/**
 *  删除收货人信息
 *
 *  @param receiverID 收货人信息的ID
 */
-(void)delReceiver:(NSString*)receiverID;
/**
 *  编辑收货人信息
 *
 *  @param receiverID 收货人信息的id
 *  @param name       收货人姓名
 *  @param addr       收货人地址
 *  @param phone      收货人联系电话
 */
-(void)modifyReceiver:(NSString*)receiverID name:(NSString*)name address:(NSString*)addr phone:(NSString*)phone;
/**
 *  获得收货人信息
 */
-(void)getReceiver;
/**
 *  将商品添加到购物车中
 *
 *  @param productID 商品id
 *  @param num       商品数量
 *  @param comment   商品备注
 */
-(void)addShoppingCartWithProductID:(NSString*)productID number:(NSString*)num comment:(NSString*)comment;
/**
 *  从购物车中删除商品
 *
 *  @param shopID 购物车中商品编号
 */
-(void)delShoppingCartWithShopID:(NSString*)shopID;
/**
 *  编辑购物车信息
 *
 *  @param shopID  商品编号
 *  @param number  商品数量
 *  @param comment 备注
 */
-(void)modifyShoppingCartWithShopID:(NSString*)shopID number:(NSString*)number comment:(NSString*)comment;
/**
 *  获得所有购物车信息
 */
-(void)getShoppingCarts;

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
-(void)addOrderWithShopIds:(NSString*)shopIDs receiverID:(NSString*)receiverID coins:(NSString*)coinNum comment:(NSString*)comment shipingMethod:(NSString*)shipMethod phoneConfirm:(NSString*)phoneConfirm userID:(NSString*)userID;
/**
 *  订单付费
 *
 *  @param orderID 订单号
    @param 支付宝付款
 */
 //TODO: 暂时存在问题
-(void)payOrderWithOrderID:(NSString*)orderID  alipay:(NSString*)alipayNum;
/**
 *  获得各种状态订单
 *
 *  @param status 订单状态0:保留, 1:未付款, 2:已付款 3:已发货 4:已收货 5:已取消
 */
-(void)getOrdersWithStatus:(NSString*)status;
/**
 *  确认收货
 *
 *  @param orderID 订单id
 */
-(void)confirmReceiptWithOrderID:(NSString*)orderID;
/**
 *  获得金币折算比例
 */
-(void)getCoinsRate;
/**
 *  添加金币
 *
 *  @param coinsNum 要添加的金币数量
 */
-(void)addCoins:(NSString*)coinsNum;
/**
 *  通过订单ID获得订单
 *
 *  @param orderID 订单ID
 */
-(void)getOrderByOrderID:(NSString*)orderID;
@end
