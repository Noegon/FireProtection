//
//  NSManagedObject+NGNCRUDAppendix.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 05.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (NGNCRUDAppendix)

+ (instancetype)ngn_createEntityInManagedObjectContext:(NSManagedObjectContext *)context
                               fieldsCompletitionBlock:(void(^)(NSManagedObject *object))fieldsCompletitionBlock;
+ (void)ngn_deleteEntityInManagedObjectContext:(NSManagedObjectContext *)context
                                 managedObject:(NSManagedObject *)object;
+ (NSArray *)ngn_allEntitiesInManagedObjectContext:(NSManagedObjectContext *)context;
+ (NSManagedObject *)ngn_entityById:(NSNumber *)entityId inManagedObjectContext:(NSManagedObjectContext *)context;

@end
