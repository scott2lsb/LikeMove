//
//  CoreDataDAO.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-14.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "CoreDataDAO.h"


@implementation CoreDataDAO

@synthesize managedObjectContext          = _managedObjectContext;
@synthesize managedObjectModel            = _managedObjectModel;
@synthesize persistentStoreCoordinator    = _persistentStoreCoordinator;


#pragma mark - Core Data 堆栈
//返回 被管理的对象上下文
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext) {
        return _managedObjectContext;
    }

NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator) {
_managedObjectContext                     = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// 返回 持久化存储协调者
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }

NSURL *storeURL                           = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreDataMoves.sqlite"];

_persistentStoreCoordinator               = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];

    [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                              configuration:nil
                                                        URL:storeURL
                                                    options:nil
                                                      error:nil];

    return _persistentStoreCoordinator;
}

//  返回 被管理的对象模型
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
NSURL *modelURL                           = [[NSBundle mainBundle] URLForResource:@"CoreDataMoves" withExtension:@"momd"];
_managedObjectModel                       = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

#pragma mark - 应用程序沙箱
// 返回应用程序Docment目录的NSURL类型
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
