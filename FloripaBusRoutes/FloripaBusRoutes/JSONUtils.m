//
//  JSONUtils.m
//  FloripaBusRoutes
//
//  Created by Dennin Dalke on 05/03/2015.
//  Copyright (c) 2015 Dennin Dalke. All rights reserved.
//

#import "JSONUtils.h"

@implementation JSONUtils

+(NSArray*)JSONParseArray:(NSString*)jsonString
{
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    return (NSArray*) [NSJSONSerialization JSONObjectWithData:data
       options:NSJSONReadingMutableContainers error:nil];
}

+(id)JSONParse:(NSString*)jsonString
{
    NSError* error;
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    id tReturn = [NSJSONSerialization JSONObjectWithData:data
                                           options:NSJSONReadingMutableContainers error:&error];
    return tReturn;
}

+(NSDictionary*)JSONParseDictionary:(NSString*)jsonString
{
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    return (NSDictionary*) [NSJSONSerialization JSONObjectWithData:data
        options:NSJSONReadingMutableContainers error:nil];
}

+(NSString*)JSONSerialize:(NSObject*)value prettyPrinted:(BOOL)prettyPrinted
{
    int options = prettyPrinted ? NSJSONWritingPrettyPrinted : 0;
    if([NSJSONSerialization isValidJSONObject:value])
    {
        NSData* data = [NSJSONSerialization dataWithJSONObject:value options:options error:nil];
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

@end
