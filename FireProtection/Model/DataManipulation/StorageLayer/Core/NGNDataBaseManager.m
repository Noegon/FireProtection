//
//  NGNDataBaseRuler.m
//  FireProtection
//
//  Created by Alex on 19.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNDataBaseManager.h"
#import "NGNCommonConstants.h"

@interface NGNDataBaseManager ()

@property (readwrite, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readwrite, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readwrite, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSPersistentStoreCoordinator *)persistentStoreCoordinatorWithStorageName:(NSString *)storageName;

@end

@implementation NGNDataBaseManager

#pragma mark - basic logic methods;
+ (instancetype)sharedInstance {
    static NGNDataBaseManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark - core data support methods

+ (NSManagedObjectContext *)managedObjectContext {
    return [[self sharedInstance] managedObjectContext];
}

+ (void)setupCoreDataStackWithStorageName:(NSString *)storageName {
    NSPersistentStoreCoordinator *coordinator =  [[self sharedInstance] persistentStoreCoordinatorWithStorageName:storageName];
    if (coordinator != nil) {
        [[self sharedInstance] setManagedObjectContext:[[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType]];
        [[[self sharedInstance] managedObjectContext] setPersistentStoreCoordinator:coordinator];
        [[[self sharedInstance] managedObjectContext] setMergePolicy:NSMergeByPropertyStoreTrumpMergePolicy];
    }
}

+ (void)saveContext {
    __block NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = [self.sharedInstance managedObjectContext];
    dispatch_async(dispatch_get_main_queue(), ^{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if([managedObjectContext hasChanges] && ![managedObjectContext save:&error]){
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } else {
//            dispatch_async(dispatch_get_main_queue(), ^{
                [managedObjectContext refreshAllObjects];
//            });
        }
//    });
    });
}

#pragma mark - core data handle helper methods

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:kNGNApplicationAppName withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinatorWithStorageName:(NSString *)storageName {
    if(self.persistentStoreCoordinator) {
        return self.persistentStoreCoordinator;
    }
    if (!storageName) {
        storageName = kNGNApplicationAppName;
    }
    NSString *fullStorageName = [NSString stringWithFormat:@"%@.sqlite", storageName];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:fullStorageName];
    NSError *error = nil;
    self.persistentStoreCoordinator =
        [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    if(![self.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:nil
                                                            URL:storeURL
                                                        options:nil
                                                          error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return self.persistentStoreCoordinator;
}

#pragma mark - additional helper methods

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}

@end
