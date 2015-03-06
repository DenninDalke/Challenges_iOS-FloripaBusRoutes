//
//  ReflectionUtils.h
//  FloripaBusRoutes
//
//  Created by Dennin Dalke on 05/03/2015.
//  Copyright (c) 2015 Dennin Dalke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReflectionUtils : NSObject

+(NSDictionary*)getPropertiesFromObject:(id)object;
+(NSDictionary*)getPropertiesFromObject:(id)object skipIfNil:(bool)skipIfNil;
+(void)copyPropertiesFromDictionary:(NSDictionary*)dict toObject:(id)object;
+(void)copyPropertiesFromDictionary:(NSDictionary*)dict toObject:(id)object updateIfNil:(bool)updateIfNil;
+(void)copyPropertiesFromObject:(id)from toObject:(id)to;
+(void)copyPropertiesFromObject:(id)from toObject:(id)to updateIfNil:(bool)updateIfNil;

@end
