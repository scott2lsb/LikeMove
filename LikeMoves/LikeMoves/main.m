//
//  main.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-14.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LMAppDelegate.h"

int main(int argc, char * argv[])
{
    @autoreleasepool {
        @try{
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([LMAppDelegate class]));
        }@catch(NSException* except){
            DLog(@"name:%@,\n--reason:%@,\n--userInfo:%@",except.name,except.reason,except.userInfo);
        }
    }
}
