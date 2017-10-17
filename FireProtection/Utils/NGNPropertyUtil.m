//
//  NGNPropertyUtil.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 13.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNPropertyUtil.h"
#import "objc/runtime.h"

@implementation NGNPropertyUtil

+ (NSDictionary *) propertiesOfObject:(id)object {
    Class klass = [object class];
    return [self propertiesOfClass:klass];
}

+ (NSDictionary *) propertiesOfClass:(Class)klass {
    NSMutableDictionary * properties = [NSMutableDictionary dictionary];
    [self propertiesForHierarchyOfClass:klass onDictionary:properties];
    return [NSDictionary dictionaryWithDictionary:properties];
}

+ (NSDictionary *) propertiesOfSubclass:(Class)klass {
    if (klass == NULL) {
        return nil;
    }
    
    NSMutableDictionary *properties = [NSMutableDictionary dictionary];
    return [self propertiesForSubclass:klass onDictionary:properties];
}

+ (NSMutableDictionary *)propertiesForHierarchyOfClass:(Class)klass
                                          onDictionary:(NSMutableDictionary *)properties {
    if (klass == NULL) {
        return nil;
    }
    
    if (klass == [NSObject class]) {
        // On reaching the NSObject base class, return all properties collected.
        return properties;
    }
    
    // Collect properties from the current class.
    [self propertiesForSubclass:klass onDictionary:properties];
    
    // Collect properties from the superclass.
    return [self propertiesForHierarchyOfClass:[klass superclass] onDictionary:properties];
}

+ (NSMutableDictionary *) propertiesForSubclass:(Class)class onDictionary:(NSMutableDictionary *)properties {
    unsigned int outCount, i;
    objc_property_t *objcProperties = class_copyPropertyList(class, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = objcProperties[i];
        const char *propName = property_getName(property);
        if(propName) {
            const char *propType = getPropertyType(property);
            NSString *propertyName = [NSString stringWithUTF8String:propName];
            NSString *propertyType = [NSString stringWithUTF8String:propType];
            [properties setObject:propertyType forKey:propertyName];
        }
    }
    free(objcProperties);
    
    return properties;
}

static const char *getPropertyType(objc_property_t property) {
    const char *attributes = property_getAttributes(property);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T' && attribute[1] != '@') {
            // A C primitive type:
            /*
             For example, int "i", long "l", unsigned "I", struct.
             Apple docs list plenty of examples of values returned. For a list
             of what will be returned for these primitives, search online for
             "Objective-c" "Property Attribute Description Examples"
             */
            NSString *name = [[NSString alloc] initWithBytes:attribute + 1 length:strlen(attribute) - 1 encoding:NSASCIIStringEncoding];
            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
        }
        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            // An Objective C id type:
            return "id";
        }
        else if (attribute[0] == 'T' && attribute[1] == '@') {
            // Another Objective C id type:
            NSString *name = [[NSString alloc] initWithBytes:attribute + 3 length:strlen(attribute) - 4 encoding:NSASCIIStringEncoding];
            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
        }
    }
    return "";
}

@end
