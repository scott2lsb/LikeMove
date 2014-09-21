//
//  UserDA.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-15.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "UserActDA.h"
#import <AFNetworking.h>
#import "JSONKit.h"
#import "User.h"
@implementation UserActDA

//+(UserActDA *)sharedManager{
//    static UserActDA* action;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        action=[[UserActDA alloc] init];
//    });
//    return action;
//}

-(User *)login:(NSString *)phone withPassword:(NSString *)pwd{
    AFHTTPRequestOperationManager *manager= [AFHTTPRequestOperationManager manager];
    manager.responseSerializer= [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=login&login_name=%@&login_password=%@",phone,pwd];
    NSString* requestUrl                                                 =[BaseURLString stringByAppendingString:suffix];
    [manager POST:requestUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:BaseURLString]];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookies];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:mUserDefaultsCookie];
        
        
        
                DLog(@"JSON: %@",operation.responseString);
        
       /*

        //获得用户cookie，有效期一个月
        NSDictionary *fields= [operation.response allHeaderFields];
        NSString *cookie= [fields valueForKey:@"Set-Cookie"];// It is your cookie
        [[NSUserDefaults standardUserDefaults] setObject:cookie forKey:mUserDefaultsCookie];
        DLog(@"cookie:%@",cookie);
        */
        // 使用jsonkit进行json解析
        int result=[self jsonToUserDefault:operation];
        //使用BL的delegate loginFinished方法udObject
        if (result==1) {
            [_delegate loginSuccess];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error: %@", error);
        // 使用Bl的 loginfailed方法
        [_delegate loginFail];
    }];
    
    return nil;
    
}

-(BOOL)regist:(NSString *)phone withPassword:(NSString *)pwd{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                       = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=register&phone=%@&password=%@&user_type=4",phone,pwd];
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    [manager POST:requestUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"JSON: %@", operation.responseString);
        //注册成功BL的delegate registSuccess
        [_delegate registSuccess];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        //注册失败BL的delegate registFail
        [_delegate registFail];
    }];
    return 1;
}
-(BOOL)editUserInfo:(NSString *)nickName sex:(NSString*)sex age:(NSString*)age{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                       = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    
    /**添加cookie
    NSData *cookiesdata = [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie];
    if([cookiesdata length]) {
        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesdata];
        NSHTTPCookie *cookie;
        for (cookie in cookies) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        }
    }
    */
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=edit&nickname=%@&sex=%@&age=%@",nickName,sex,age];
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    [manager POST:requestUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"JSON: %@", operation.responseString);
        //编辑成功BL的delegate editSuccess
        [_delegate editUserInfoSuccess];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        //编辑失败BL的delegate editFail
        [_delegate editUserInfoFail];
    }];
    return 1;

}

-(void)resetPwd:(NSString *)phone withNewPwd:(NSString *)pwd{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                       = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=edit&password=%@",pwd];
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    [manager POST:requestUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"JSON: %@", operation.responseString);
        //修改密码成功BL的delegate editSuccess
        [_delegate resetPwdSuccess];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        //修改密码失败BL的delegate editFail
        [_delegate resetPwdFail];
    }];
}
/**
 *  将获得的json形式user信息转化为user对象，存入NSUserDefaults中
 *
 *  @param operation AFNetworking请求返回AFHTTPRequestOperation对象
 *
 *  @return resultCode：{1，代表成功返回；0，代表失败
 */
-(int)jsonToUserDefault:(AFHTTPRequestOperation*) operation {
    //TODO: 使用jsonkit进行json解析
    NSDictionary* resInfo=[operation.responseString objectFromJSONString];
    NSDictionary* userInfo=[resInfo objectForKey:@"data"];
    int result=[[resInfo objectForKey:@"result"] intValue];
    
    User* user=[[User alloc]init];
    user.userId=[userInfo objectForKey:@"id"];
    user.nickName=[userInfo objectForKey:@"nickname"];
    user.password=[userInfo objectForKey:@"password"];
    user.phone=[userInfo objectForKey:@"phone"];
    user.coins=[userInfo objectForKey:@"coins"];
    user.balance=[userInfo objectForKey:@"balance"];

    user.age=[userInfo objectForKey:@"age"];
    
    user.userType=[userInfo objectForKey:@"user_type"];
    user.userName=[userInfo objectForKey:@"username"];
    user.sex=[userInfo objectForKey:@"sex"];
    user.homeAddress=[userInfo objectForKey:@"home_address"];
    user.trainAddress=[userInfo objectForKey:@"training_address"];
    NSData *userObject = [NSKeyedArchiver archivedDataWithRootObject:user];
    [[NSUserDefaults standardUserDefaults] setObject:userObject forKey:mUserInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];//同步NSUserDefaults中的数据
    
    return result;
}
@end
