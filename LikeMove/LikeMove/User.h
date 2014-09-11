//
//  User.h
//  LikeMove
//
//  Created by 粒橙Leo on 14-9-11.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * nickName;
@property (nonatomic, retain) NSString * phone;

@end
