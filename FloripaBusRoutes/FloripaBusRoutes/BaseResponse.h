//
//  BaseResponse.h
//  FloripaBusRoutes
//
//  Created by Dennin Dalke on 05/03/15.
//  Copyright (c) 2015 Dennin Dalke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestError.h"

@interface BaseResponse : NSObject

@property (nonatomic) RequestError *error;

-(id)initWithError:(RequestError*)error;
-(id)initWithDictionary:(NSDictionary*)dictionary;
-(id)initWithDictionaryArray:(NSArray *)array;
-(void)parseResponse:(id)dictionary;
-(NSDictionary*)toDictionary;

@end
