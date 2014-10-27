//
//  LMShopDAODelegate.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-6.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LMShopDAODelegate <NSObject>
@optional
-(void)getProductInPromotionSuccess:(NSArray*)array;

@end
