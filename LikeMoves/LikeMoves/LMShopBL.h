//
//  LMShopBL.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-14.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopDAO.h"
#import "LMShopDAODelegate.h"
#import "LMShopBLDelegate.h"
@interface LMShopBL : NSObject<LMShopDAODelegate>
@property (strong,nonatomic) ShopDAO* dao;
@property (weak,nonatomic) id<LMShopBLDelegate> delegate;
@end
