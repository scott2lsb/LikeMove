//
//  User.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-16.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "User.h"


@implementation User

@synthesize  userId;
@synthesize userName;
@synthesize password;
@synthesize userType;
@synthesize phone;
@synthesize nickName;
@synthesize coins;
@synthesize balance;
@synthesize age;
@synthesize trainAddress;
@synthesize homeAddress;
-(id)init{
    if (!self) {
        self=[super init];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)coder  {
    [coder encodeObject:userId  forKey:@"userId"];
    [coder encodeObject:userName  forKey:@"userName"];
    [coder encodeObject:password  forKey:@"password"];
    [coder encodeObject:userType  forKey:@"userType"];
    [coder encodeObject:phone  forKey:@"phone"];
    [coder encodeObject:nickName  forKey:@"nickName"];
    [coder encodeObject:coins  forKey:@"coins"];
    [coder encodeObject:balance  forKey:@"balance"];
    [coder encodeObject:age  forKey:@"age"];
    [coder encodeObject:trainAddress forKey:@"trainAddress"];
    [coder encodeObject:homeAddress forKey:@"homeAddress"];
    
};
- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super init])
    {
        
        userId   = [coder decodeObjectForKey:@"userId"];
        userName = [coder decodeObjectForKey:@"userName"];
        password = [coder decodeObjectForKey:@"password"];
        userType = [coder decodeObjectForKey:@"userType"];
        phone    = [coder decodeObjectForKey:@"phone"];
        nickName = [coder decodeObjectForKey:@"nickName"];
        coins    = [coder decodeObjectForKey:@"coins"];
        balance  = [coder decodeObjectForKey:@"balance"];
        age      =[coder decodeObjectForKey:@"age"];
        trainAddress=[coder decodeObjectForKey:@"trainAddress"];
        homeAddress=[coder decodeObjectForKey:@"homeAddress"];
    }
    return self;
};

@end
