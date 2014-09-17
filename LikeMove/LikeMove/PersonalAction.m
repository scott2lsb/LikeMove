//
//  PersonalAction.m
//  LikeMove
//
//  Created by 粒橙Leo on 14-9-12.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "PersonalAction.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>


@implementation PersonalAction

+(PersonalAction *)sharePersonalAction{
    static PersonalAction* action;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    action=[[PersonalAction alloc] init];
});
    return action;
}

-(User *)login:(NSString *)phone withPassword:(NSString *)pwd{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer             = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
//    NSDictionary *parameters               = @{@"m": @"user",@"a":@"login",@"login_name":phone,@"login_password":pwd};

    __block BOOL isReg                     = true;
    NSString* url=@"http://www.haoapp123.com/app/localuser/aidongdong/api.php?m=user&a=login&login_name=a1&login_password=111111";
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSArray* cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:[responseObject allHeaderFields] forURL:[NSURL URLWithString:url]];
    isReg                                  = true;

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    isReg                                  = false;
    }];

    return nil;
}

-(BOOL)regist:(NSString *)phone withPassword:(NSString *)pwd{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer             = [AFJSONResponseSerializer serializer];

    NSDictionary *parameters               = @{@"m": @"user",@"a":@"register",@"phone":phone,@"password":pwd};
//    NSString* url=[NSString stringWithFormat:@"%@api.php",BaseURLString];
    __block BOOL isReg                     = true;

    [manager POST:BaseURLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    isReg                                  = true;

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    isReg                                  = false;
    }];
    return isReg;
}
@end
