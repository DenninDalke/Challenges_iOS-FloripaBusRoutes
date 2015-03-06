//
//  BaseModel.m
//  FloripaBusRoutes
//
//  Created by Dennin Dalke on 05/03/15.
//  Copyright (c) 2015 Dennin Dalke. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import <objc/runtime.h>
#import "JSONUtils.h"
#import "ReflectionUtils.h"

@implementation BaseModel

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        [self bindDictionary:dictionary];
    }
    
    return self;
}

-(id)initWithJSON:(NSString *)jsonString
{
    self = [super init];
    if(self)
    {
        NSDictionary* dictionary = [JSONUtils JSONParseDictionary:jsonString];
        [self bindDictionary:dictionary];
    }
    return self;
}

-(void)bindObject:(id)object
{
    [ReflectionUtils copyPropertiesFromObject:object toObject:self];
}

-(void)bindDictionary:(NSDictionary*)dictionary;
{
    [ReflectionUtils copyPropertiesFromDictionary:dictionary toObject:self];
}

-(NSString*) serialize
{
    return [JSONUtils JSONSerialize:[self toDictionary] prettyPrinted:false];
}

-(NSDictionary*)toDictionary
{
    return [ReflectionUtils getPropertiesFromObject:self];
}

+(NSString*)serializeArray:(NSArray*)elements
{
    NSMutableArray* completeArray = [[NSMutableArray alloc] init];
    for(BaseModel* element in elements)
    {
        [completeArray addObject:[element toDictionary]];
    }
    return [JSONUtils JSONSerialize:completeArray prettyPrinted:true];
}

+(NSArray*)deserializeArray:(NSString*)data className:(NSString*)className
{
    NSMutableArray* completeArray = [[NSMutableArray alloc] init];
    NSArray* parsedArray = [JSONUtils JSONParseArray:data];
    for(NSDictionary* element in parsedArray)
    {
        BaseModel* newElement = (BaseModel*) [[NSClassFromString(className) alloc] init];
        [ReflectionUtils copyPropertiesFromDictionary:element toObject:newElement];
        [completeArray addObject:newElement];
    }
    return completeArray;
}

@end
