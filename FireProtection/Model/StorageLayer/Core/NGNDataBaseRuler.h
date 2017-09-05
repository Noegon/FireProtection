//
//  NGNDataBaseRuler.h
//  FireProtection
//
//  Created by Alex on 19.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface NGNDataBaseRuler : NSObject

+ (NSManagedObjectContext *) managedObjectContext;
+ (void)setupCoreDataStackWithStorageName:(NSString *)storageName;
+ (void)saveContext;

@end
