//
//  CoreDataDAO.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-14.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface CoreDataDAO : NSObject
//被管理的对象上下文
@property (readonly, strong, nonatomic) NSManagedObjectContext       *managedObjectContext;
//被管理的对象模型
@property (readonly, strong, nonatomic) NSManagedObjectModel         *managedObjectModel;
//持久化存储协调者
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory;



@end
