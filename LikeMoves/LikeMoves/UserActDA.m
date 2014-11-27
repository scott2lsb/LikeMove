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
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误

    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        /**
         *  从response的HeaderField获得头文件，从头文件中通过NSHTTPCookie的cookiesWithResponseHeaderFields组成cookie的NSArray，将生成cookie的array，使用NSHttpCookie的reqeustHeaderFieldsWithCookies方法拼接成合法的http header field。最后set到request中即可。
         [manager.requestSerializer setValue:[requestFields objectForKey:@"Cookie"] forHTTPHeaderField:@"Cookie"];
         */
        NSDictionary *fields= [operation.response allHeaderFields];
        NSArray *cookies=[NSHTTPCookie cookiesWithResponseHeaderFields:fields forURL:[NSURL URLWithString:BaseURLString]];
        NSDictionary* requestFields=[NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
        [[NSUserDefaults standardUserDefaults] setObject:[requestFields objectForKey:@"Cookie"] forKey:mUserDefaultsCookie];
        
        

        // 使用jsonkit进行json解析
        NSDictionary*dict=[operation.responseString objectFromJSONString];
        NSString* status=        [dict objectForKey:@"result"];

        
        //使用BL的delegate loginFinished方法udObject
        if ([status intValue]==1) {
            [_delegate loginSuccess];
            [self jsonToUserDefault:operation];
        }else{
            [_delegate loginFail];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error: %@", error);
        // 使用Bl的 loginfailed方法
        [_delegate loginFail];
    }];
    
    return nil;
    
}

-(BOOL)regist:(NSString *)phone withPassword:(NSString *)pwd withTrainPlace:(NSString *)trainPlace{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                       = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=register&phone=%@&password=%@&training_address=%@&user_type=4",phone,pwd,[trainPlace stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误

    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"JSON: %@", operation.responseString);
        //注册成功BL的delegate registSuccess
        [_delegate registSuccess];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error: %@", error);
        //注册失败BL的delegate registFail
        [_delegate registFail];
    }];
    return 1;
}
-(BOOL)editUserInfo:(NSString *)nickName sex:(NSString*)sex age:(NSString*)age trainAddr:(NSString *)trainAdr{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                       = [AFJSONResponseSerializer serializer];
      [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=edit&nickname=%@&age=%@&sex=%@&training_address=%@",nickName,age,sex,trainAdr];
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];

    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary* resInfo=[operation.responseString objectFromJSONString];
        int result=[[resInfo objectForKey:@"result"] intValue];
        
        //使用BL的delegate loginFinished方法udObject
        if (result==1) {
            [_delegate editUserInfoSuccess];
        }else{
            [_delegate editUserInfoFail];
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error: %@", error);
        //编辑失败BL的delegate editFail
        [_delegate editUserInfoFail];
    }];
    return 1;

}

-(void)resetPwd:(NSString *)phone withNewPwd:(NSString *)pwd{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                       = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=resetPassword&phone=%@&password=%@",phone,pwd];
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    [manager POST:requestUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"JSON: %@", operation.responseString);
        //修改密码成功BL的delegate editSuccess
        // 使用jsonkit进行json解析
        NSDictionary* resInfo=[operation.responseString objectFromJSONString];
        int result=[[resInfo objectForKey:@"result"] intValue];

        //使用BL的delegate loginFinished方法udObject
        if (result==1) {
            [_delegate resetPwdSuccess];
        }else{
            [_delegate resetPwdFail];
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error: %@", error);
        //修改密码失败BL的delegate editFail
        [_delegate resetPwdFail];
    }];
}
-(void)refreshMyself{
    AFHTTPRequestOperationManager *manager= [AFHTTPRequestOperationManager manager];
    manager.responseSerializer= [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    User* user=[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:mUserInfo]];
    /**
     *  个人中心信息
     */
    NSString* username=user.userName;

        NSString* suffix=[NSString stringWithFormat:@"?m=user&a=search&username=%@",username];
    NSString* requestUrl                                                 =[BaseURLString stringByAppendingString:suffix];
    DLog(@"更新用户信息-request-url=%@",requestUrl);
    [manager POST:requestUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"更新用户信息-json:%@",operation.responseString);
        // 使用jsonkit进行json解析
        [self jsonToDefaultUser:operation];
        //使用BL的delegate loginFinished方法udObject
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error: %@", error);
        // 使用Bl的 loginfailed方法
//        [_delegate loginFail];
    }];
    


};
-(void)addCoins:(NSInteger)coins{
User* user=[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:mUserInfo]];
    coins=[user.coins intValue]+coins;
    
        AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer                       = [AFJSONResponseSerializer serializer];
        [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
        manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
        NSString* suffix=[NSString stringWithFormat:@"?m=user&a=edit&coins=%ld",(long)coins];
        NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
        
        NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
        [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            DLog(@"增加金币-JSON: %@", operation.responseString);
            //编辑成功BL的delegate editSuccess

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            DLog(@"Error: %@", error);
            //编辑失败BL的delegate editFail

        }];

};
/**
 *  查询用户手机号是否已经注册
 *
 *  @param phoneNum 手机号
 */
-(void)phoneIsExist:(NSString*)phoneNum{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                       = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=getPhoneInfo&phone=%@",phoneNum];
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        //编辑成功BL的delegate editSuccess
        NSDictionary* dict=[operation.responseString objectFromJSONString];
        int isExist=[[dict objectForKey:@"phone_registered"] intValue];
        DLog(@"是否存在；%d",isExist);
        if (isExist==0) {
            [_delegate phoneIsNotExist];
        }else{
            [_delegate phoneIsExist];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        //编辑失败BL的delegate editFail
        
    }];
};

/**
 *  将获得的json形式user信息转化为user对象，存入NSUserDefaults中
 *
 *  @param operation AFNetworking请求返回AFHTTPRequestOperation对象
 *
 *  @return resultCode：{1，代表成功返回；0，代表失败
 */
-(int)jsonToUserDefault:(AFHTTPRequestOperation*) operation {
    // 使用jsonkit进行json解析
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
-(void)jsonToDefaultUser:(AFHTTPRequestOperation*) operation {
    //TODO: 使用jsonkit进行json解析
    NSDictionary* resInfo=[operation.responseString objectFromJSONString];
    NSArray* userInfos=[resInfo objectForKey:@"list"];
    NSDictionary* userInfo=    [userInfos objectAtIndex:0];
    User* user=[[User alloc] init];
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
    
}

@end
