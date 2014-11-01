//
//  LMShopBLDelegate.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-15.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LMShopBLDelegate <NSObject>

@optional
-(void)getProductInPromotionSuccess:(NSArray*)array;
-(void)addToCartSuccess;
-(void)getShopingCartsSuccess:(NSArray*)array;
-(void)getReceiversSuccess:(NSArray*)array;
-(void)getGivedCoinsRecordSuccess:(NSArray*)array;
-(void)getReceivedCoinsRecordSuccess:(NSArray*)array;


-(void)getNoPayOrdersSuccess:(NSArray*)array;
-(void)getPaidOrdersSuccess:(NSArray*)array;
-(void)getSendOrdersSuccess:(NSArray*)array;
-(void)getReceivedOrdersSuccess:(NSArray*)array;
@end
