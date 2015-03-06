//
//  RequestResponse.m
//  FloripaBusRoutes
//
//  Created by Dennin Dalke on 05/03/15.
//  Copyright (c) 2015 Dennin Dalke. All rights reserved.
//

#import "BaseResponse.h"
#import "ReflectionUtils.h"

@implementation BaseResponse

//@synthesize error, error_code, error_message;

-(id) initWithError:(RequestError*)pError
{
    self = [super init];
    if (self)
    {
        self.error = pError;
    }
    return self;
}

-(id) initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self)
    {
        [self parseResponse:dictionary];
    }
    return self;
}

-(id) initWithDictionaryArray:(NSArray *)array
{
    self = [super init];
    if(self)
    {
        for (id item in array)
        {
            [self parseElement:item];
        }
    }
    return self;
}

-(NSDictionary*)toDictionary
{
    return [ReflectionUtils getPropertiesFromObject:self];
}

-(void) parseElement:(id)dictionary
{
    // override in children
}

-(void) parseResponse:(NSDictionary *)dictionary
{
    [ReflectionUtils copyPropertiesFromDictionary:dictionary toObject:self];
}

@end
