//
//  ReflectionUtils.m
//  FloripaBusRoutes
//
//  Created by Dennin Dalke on 05/03/2015.
//  Copyright (c) 2015 Dennin Dalke. All rights reserved.
//

#import "ReflectionUtils.h"
#import <objc/runtime.h>

@implementation ReflectionUtils

+(NSDictionary*)getPropertiesFromObject:(id)from
{
    return [ReflectionUtils getPropertiesFromObject:from skipIfNil:false];
}

+(NSDictionary*)getPropertiesFromObject:(id)from skipIfNil:(bool)skipIfNil
{
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList([from class], &propertyCount);
    [ReflectionUtils setProperties:from toObject:dict updateIfNil:skipIfNil properties:properties count:propertyCount];
    properties = class_copyPropertyList([from superclass], &propertyCount);
    [ReflectionUtils setProperties:from toObject:dict updateIfNil:skipIfNil properties:properties count:propertyCount];
    
    return dict;
}

+(void)copyPropertiesFromDictionary:(NSDictionary*)dict toObject:(id)object
{
    [ReflectionUtils copyPropertiesFromDictionary:dict toObject:object updateIfNil:false];
}

+(void)copyPropertiesFromDictionary:(NSDictionary*)from toObject:(id)to updateIfNil:(bool)updateIfNil
{
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList([to class], &propertyCount);
    [ReflectionUtils setProperties:from toObject:to updateIfNil:updateIfNil properties:properties count:propertyCount];
    properties = class_copyPropertyList([to superclass], &propertyCount);
    [ReflectionUtils setProperties:from toObject:to updateIfNil:updateIfNil properties:properties count:propertyCount];
}

+(void)copyPropertiesFromObject:(id)from toObject:(id)to
{
    [ReflectionUtils copyPropertiesFromObject:from toObject:to updateIfNil:false];
}

+(void)copyPropertiesFromObject:(id)from toObject:(id)to updateIfNil:(bool)updateIfNil
{
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList([to superclass], &propertyCount);
    [ReflectionUtils setProperties:from toObject:to updateIfNil:updateIfNil properties:properties count:propertyCount];
    properties = class_copyPropertyList([to class], &propertyCount);
    [ReflectionUtils setProperties:from toObject:to updateIfNil:updateIfNil properties:properties count:propertyCount];
}

+(void)setProperties:(id)from toObject:(id)to updateIfNil:(bool)updateIfNil properties:(objc_property_t*) properties count:(unsigned int)propertyCount
{
    for (int i=0; i<propertyCount; i++)
    {
        objc_property_t property = properties[i];
        const char *propertyName = property_getName(property);
        NSString *keyName = [NSString stringWithUTF8String:propertyName];
        id value = [from valueForKey:keyName];
        if(!updateIfNil && (value == nil || value == (id)[NSNull null]))
            continue;
        if([to isKindOfClass:[NSDictionary class]] || [to respondsToSelector:NSSelectorFromString(keyName)])
        {
            [to setValue:value forKey:keyName];
        }
    }
}
@end
