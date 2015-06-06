//
//  JSONUtils.h
//  FloripaBusRoutes
//
//  Created by Dennin Dalke on 05/03/2015.
//  Copyright (c) 2015 Dennin Dalke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONUtils : NSObject

+(NSString*)JSONSerialize:(NSObject*)value prettyPrinted:(BOOL)prettyPrinted;
+(id)JSONParse:(NSString*)jsonString;
+(NSArray*)JSONParseArray:(NSString*)jsonString;
+(NSDictionary*)JSONParseDictionary:(NSString*)jsonString;

@end
