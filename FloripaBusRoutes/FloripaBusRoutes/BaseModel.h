//
//  BaseModel.h
//  FloripaBusRoutes
//
//  Created by Dennin Dalke on 05/03/15.
//  Copyright (c) 2015 Dennin Dalke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

+(NSString*)serializeArray:(NSArray*)elements;
+(NSArray*)deserializeArray:(NSString*)data className:(NSString*)className;

-(id)initWithDictionary:(NSDictionary*)dictionary;
-(id)initWithJSON:(NSString*)jsonString;
-(void)bindObject:(id)object;
-(void)bindDictionary:(NSDictionary*)dictionary;
-(NSString*)serialize;
-(NSDictionary*)toDictionary;

@end
