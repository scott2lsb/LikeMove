//
//  SportDAO.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-6.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "SportDAO.h"

@implementation SportDAO
/**
 *  添加金币
 *
 *  @param coinsNum 要添加的金币数量
 */
-(void)addCoins:(NSString*)coinsNum{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=addCoins&coins=%@",coinsNum];//在请求的后面添加请求参数
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"add-coin-JSON: %@", operation.responseString);
        [self jsonToUserDefault:operation];
        //请求成功，回调的BL的delegate
        //[_delegate XXX];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error: %@", error);
        //请求失败，回调BL的delegate
        //[_delegate XXX];
    }];
    
};
/**
 *  添加运动时间，运动时长
 *
 *  @param duration 运动的时长，秒钟
 */
-(void) addMoveRecord:(NSTimeInterval)duration withSteps:(NSInteger)steps{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=addMoveRecord&duration=%f&steps=%ld",duration,(long)steps];
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"move-record-JSON: %@", operation.responseString);
        //编辑成功BL的delegate editSuccess
        //        [_delegate editUserInfoSuccess];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        //编辑失败BL的delegate editFail
        //        [_delegate editUserInfoFail];
    }];
    
};
/**
 *  查询过去7天的运动记录，返回内容？
 *
 *  @param startTime 开始时间：2014-09-07
 *  @param endTime   结束时间：2014-09-07
 */
-(void) getMoveWeekRecords:(NSString*)startTime withEndTime:(NSString*)endTime{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=getMonthMoveDays&start_time=%@&end_time=%@",startTime,endTime];
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"JSON: %@", operation.responseString);
        //TODO: 转化星期几
        NSArray* weekName=[self toWeekName:startTime];
        //TODO: 转化为锻炼步数的数组
        NSArray* sportDetail=[self jsonToSport:operation withFirst:startTime];
        //TODO:编辑成功BL的delegate editSuccess
        [_delegate getWeekRecordSuccess:sportDetail withWeeks:weekName];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        //编辑失败BL的delegate editFail
        //        [_delegate editUserInfoFail];
    }];
    
};
/**
 *  30天的运动时间
 *
 *  @param startDate 开始时间“2014-09-12”
 *  @param endDate   结束时间“2014-09-18”
 */
-(void)getThirtyDaysMoveWithStart:(NSString*)startDate end:(NSString*)endDate{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=getMonthMoveDays&start_time=%@&end_time=%@",startDate,endDate];
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    DLog(@"month-move-days:%@",utf8);
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"30-days-move-JSON: %@", operation.responseString);
        NSDictionary* resInfo=[operation.responseString objectFromJSONString];
        //        NSDictionary* userInfo=[resInfo objectForKey:@"data"];
        NSInteger total=[[resInfo objectForKey:@"total_count"] intValue];
        
        //编辑成功BL的delegate editSuccess
        [_delegate getMonthMoveDaysSuccess:total];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        //编辑失败BL的delegate editFail
        //        [_delegate editUserInfoFail];
    }];
    

};
/**
 *  获得月份的运动天数
 *
 *  @param month @“2014-09”月份格式
 */
-(void) getMonthMoveDays:(NSString*)month{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=getMonthMoveDays&month=%@",month];
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    DLog(@"month-move-days:%@",utf8);
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"month-move-days-JSON: %@", operation.responseString);
        NSDictionary* resInfo=[operation.responseString objectFromJSONString];
        //        NSDictionary* userInfo=[resInfo objectForKey:@"data"];
        NSInteger total=[[resInfo objectForKey:@"total_count"] intValue];
        
        //编辑成功BL的delegate editSuccess
        [_delegate getMonthMoveDaysSuccess:total];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        //编辑失败BL的delegate editFail
        //        [_delegate editUserInfoFail];
    }];
    
};
-(NSArray*)jsonToSport:(AFHTTPRequestOperation*) operation withFirst:(NSString*)start{
    int weekday=[self weekday:start];
    //TODO: 使用jsonkit进行json解析
    NSDictionary* resInfo=[operation.responseString objectFromJSONString];
    NSArray* weeks=[resInfo objectForKey:@"list"];
    
        

    NSMutableArray* target=[[NSMutableArray alloc] init];
    int num=0;
    for(int i=0;i<7;i++){
        if(![weeks isKindOfClass:[NSNull class]]){
        NSDictionary* week=[weeks objectAtIndex:num];
        int weekn;
        if((weekday+i)%7==0){
            weekn=7;
        }else{
            weekn=(weekday+i)%7;
        }
        if(weekn==[self weekday:[week objectForKey:@"date"]]){
            [target addObject:[NSNumber numberWithInt:[[week objectForKey:@"duration"] intValue]]];

            if(num<weeks.count-1){
                num++;
            }
        }else{
            [target addObject:@0];
        }
        }else{
            [target addObject:@0];
        }
    }
    return [target copy];
}
-(NSArray*)toWeekName:(NSString*)firstDay{
    NSArray* weekName=@[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    int weekday=[self weekday:firstDay];
    NSMutableArray* use=[[NSMutableArray alloc] init];
    for(int i=0;i<7;i++){
        [use addObject:[ weekName objectAtIndex:(i+weekday-1)%7]];
    }
    return [use copy] ;
}
/**
 *  判断是星期几，星期一代表1
 *
 *  @param dateString @"yyyy-MM-dd“
 *
 *  @return 星期几
 */
-(int)weekday:(NSString*)dateString{
    
    
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //用[NSDate date]可以获取系统当前时间
    NSDate* date=[dateFormatter dateFromString:dateString];
    
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *weekdayComponents =[gregorian components:NSWeekdayCalendarUnit fromDate:date];
    
    long weekday = [weekdayComponents weekday];
    DLog(@"%@==%ld,today is%@,,,,%@",date,weekday,[NSDate date],dateString);
    return (int)weekday;
}
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

@end
