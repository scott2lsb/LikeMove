//
//  User.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-16.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSObject<NSCoding>

@property (nonatomic, retain) NSNumber * userId;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSNumber * userType;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * nickName;
@property (nonatomic, retain) NSNumber * coins;
@property (nonatomic, retain) NSNumber * balance;
@property (nonatomic,retain ) NSString * age;
@property (nonatomic,retain ) NSString * trainAddress;
@property (nonatomic,retain ) NSString * homeAddress;
@end
