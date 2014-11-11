//
//  LMShopBL.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-14.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "LMShopBL.h"

@implementation LMShopBL
-(id)init{
    self = [super init];
    
    if (self) {
        _dao = [ShopDAO new];
        _dao.delegate=self;
    }
    return self;
}
/**
 *  将金币赠送给朋友
 *
 *  @param friendID 目标朋友的id
 *  @param coinNum  赠送的金币数量
 */
-(void)giveCoinsToFriend:(NSString*)friendID withCoins:(NSString*)coinNum{
    [_dao giveCoinsToFriend:friendID withCoins:coinNum];
};
/**
 *  获得赠送金币的记录
 */
-(void)getGivedCoinsRecord{
    [_dao getGivedCoinsRecord];
};
/**
 *  获得接收金币的记录
 */
-(void)getRecievedCoinsRecord{
    [_dao getRecievedCoinsRecord];
};
/**
 *  开启众筹
 */
-(void)startCrowdfund{
    [_dao startCrowdfund];
};
/**
 *  获得商品类别
 */
-(void)getCategories{
    
};
/**
 *  获得推广的商品内容
 */
-(void)getProductsInPromotion{
    [_dao getProductsInPromotion];
};
/**
 *  将商品评论添加到商品中
 *
 *  @param productID 商品的编号
 *  @param desc      商品评论
 */
-(void)addProductCommentToProduct:(NSString*)productID withDesc:(NSString*)desc{
    [_dao addProductCommentToProduct:productID withDesc:desc];
};
/**
 *  获得商品的评论
 *
 *  @param productID 商品的id
 */
-(void)getProductComments:(NSString*)productID{
    [_dao getProductComments:productID];
};
/**
 *  添加收货人信息
 *
 *  @param name  收货人姓名
 *  @param addr  收货人地址
 *  @param phone 收货人手机号
 */
-(void)addReceiverWithName:(NSString*)name address:(NSString*)addr phone:(NSString*)phone{
    [_dao addReceiverWithName:name address:addr phone:phone];
};
/**
 *  删除收货人信息
 *
 *  @param receiverID 收货人信息的ID
 */
-(void)delReceiver:(NSString*)receiverID{
    [_dao delReceiver:receiverID];
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
    
};
/**
 *  获得收货人信息
 */
-(void)getReceiver{
    [_dao getReceiver];
};
/**
 *  将商品添加到购物车中
 *
 *  @param productID 商品id
 *  @param num       商品数量
 *  @param comment   商品备注
 */
-(void)addShoppingCartWithProductID:(NSString*)productID number:(NSString*)num comment:(NSString*)comment{
    [_dao addShoppingCartWithProductID:productID number:num comment:comment];
};
/**
 *  从购物车中删除商品
 *
 *  @param shopID 购物车中商品编号
 */
-(void)delShoppingCartWithShopID:(NSString*)shopID{
    [_dao delShoppingCartWithShopID:shopID];
};
/**
 *  编辑购物车信息
 *
 *  @param shopID  商品编号
 *  @param number  商品数量
 *  @param comment 备注
 */
-(void)modifyShoppingCartWithShopID:(NSString*)shopID number:(NSString*)number comment:(NSString*)comment{
    [_dao modifyShoppingCartWithShopID:shopID number:number comment:comment];
};
/**
 *  获得所有购物车信息
 */
-(void)getShoppingCarts{
    [_dao getShoppingCarts];
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
    [_dao addOrderWithShopIds:shopIDs receiverID:receiverID coins:coinNum comment:comment shipingMethod:shipMethod phoneConfirm:phoneConfirm userID:userID];
};
/**
 *  订单付费
 *
 *  @param orderID 订单号
 */
//TODO: 暂时存在问题
-(void)payOrderWithOrderID:(NSString*)orderID {
    [_dao payOrderWithOrderID:orderID];
};
-(void)payOrderWithOrderID:(NSString *)orderID alipay:(NSString *)alipayNum{
    [_dao payOrderWithOrderID:orderID alipay:alipayNum];
};
/**
 *  获得各种状态订单
 *
 *  @param status 订单状态0:保留, 1:未付款, 2:已付款 3:已发货 4:已收货 5:已取消
 */
-(void)getOrdersWithStatus:(NSString*)status{
    [_dao getOrdersWithStatus:status];
};
/**
 *  确认收货
 *
 *  @param orderID 订单id
 */
-(void)confirmReceiptWithOrderID:(NSString*)orderID{
    [_dao confirmReceiptWithOrderID:orderID];
};
/**
 *  获得金币折算比例
 */
-(void)getCoinsRate{
    
};
/**
 *  添加金币
 *
 *  @param coinsNum 要添加的金币数量
 */
-(void)addCoins:(NSString*)coinsNum{
    
};
/**
 *  通过订单ID获得订单
 *
 *  @param orderID 订单ID
 */
-(void)getOrderByOrderID:(NSString*)orderID{
    
};
#pragma mark - DaoDelegate
-(void)getProductInPromotionSuccess:(NSArray *)array{
    [_delegate getProductInPromotionSuccess:array];
}
-(void)addToCartSuccess{
    [_delegate addToCartSuccess];
}
-(void)getShopingCartsSuccess:(NSArray*)array{
    [_delegate getShopingCartsSuccess:array];
};
-(void)getReceiversSuccess:(NSArray *)array{
    [_delegate getReceiversSuccess:array];
}
-(void)getGivedCoinsRecordSuccess:(NSArray*)array{
    [_delegate getGivedCoinsRecordSuccess:array];
};
-(void)getReceivedCoinsRecordSuccess:(NSArray*)array{
    [_delegate getReceivedCoinsRecordSuccess:array];
};
-(void)getNoPayOrdersSuccess:(NSArray*)array{
    [_delegate getNoPayOrdersSuccess:array];
};
-(void)getPaidOrdersSuccess:(NSArray*)array{
    [_delegate getPaidOrdersSuccess:array];
};
-(void)getSendOrdersSuccess:(NSArray*)array{
    [_delegate getSendOrdersSuccess:array];
};
-(void)getReceivedOrdersSuccess:(NSArray*)array{
    [_delegate getReceivedOrdersSuccess:array];
};
-(void)giveCoinsToFriendSuccess{
    [_delegate giveCoinsToFriendSuccess];
}
-(void)getProductCommentsSuccess:(NSArray *)comments{
    [_delegate getProductCommentsSuccess:comments];
}
-(void)modifyShoppingCartSuccess{
    [_delegate modifyShoppingCartSuccess];
};
-(void)delShoppingCartSuccess{
    [_delegate delShoppingCartSuccess];
};
-(void)addCartToOrderSuccess:(NSDictionary*)data{
    [_delegate addCartToOrderSuccess:(NSDictionary*)data];
}
-(void)payWithBalanceSuccess{
    [_delegate payWithBalanceSuccess];
}
@end



