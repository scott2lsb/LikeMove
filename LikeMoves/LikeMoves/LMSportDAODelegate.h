//
//  LMSportDAODelegate.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-6.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LMSportDAODelegate <NSObject>
-(void)getMonthMoveDaysSuccess:(NSInteger)days;
-(void)getWeekRecordSuccess:(NSArray*)steps withWeeks:(NSArray *)weeks;
@end
