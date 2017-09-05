//
//  NSManagedObject+NGNCRUDAppendix.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 05.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NSManagedObject+NGNCRUDAppendix.h"
#import "NGNDataBaseRuler.h"

@implementation NSManagedObject (NGNCRUDAppendix)

+ (instancetype)ngn_createEntityInManagedObjectContext:(NSManagedObjectContext *)context
                               fieldsCompletitionBlock:(void(^)(NSManagedObject *object))fieldsCompletitionBlock {
    NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:[self entity].name
                                                            inManagedObjectContext:context];
    if (fieldsCompletitionBlock) {
        fieldsCompletitionBlock(object);
    }
    [NGNDataBaseRuler saveContext];
    return object;
}

+ (void)ngn_deleteEntityInManagedObjectContext:(NSManagedObjectContext *)context
                                 managedObject:(NSManagedObject *)object {
    NSArray *entities = [self ngn_allEntitiesInManagedObjectContext:context];
    if ([entities containsObject:object]) {
        [context deleteObject:object];
    }
    [NGNDataBaseRuler saveContext];
}

+ (NSArray *)ngn_allEntitiesInManagedObjectContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:[self entity].name];
    NSError *error = nil;
    NSArray *resultArray = [context executeFetchRequest:request error:&error];
    if (!resultArray) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    return resultArray;
}

+ (NSManagedObject *)ngn_entityById:(NSNumber *)entityId inManagedObjectContext:(NSManagedObjectContext *)context {
    NSArray* entities = [self ngn_allEntitiesInManagedObjectContext:context];
    NSIndexSet *indexSet = [entities indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        NSNumber *currentEntityId = [obj valueForKey:@"entityId"];
        return currentEntityId.integerValue == entityId.integerValue;
    }];
    if (indexSet.count != 0) {
        NSManagedObject *resultObject = entities[indexSet.firstIndex];
        return resultObject;
    }
    return nil;
}

@end
