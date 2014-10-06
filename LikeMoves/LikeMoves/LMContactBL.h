//
//  LMFriendBL.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-14.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMContactBLDelegate.h"
#import "LMContactDAODelegate.h"
#import "ContactDAO.h"
@interface LMContactBL : NSObject<LMContactDAODelegate>

@property (weak,nonatomic) id<LMContactBLDelegate> delegate;
@property (strong,nonatomic)    ContactDAO* dao;

@end
