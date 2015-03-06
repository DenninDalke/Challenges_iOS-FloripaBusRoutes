//
//  RequestError.m
//  FloripaBusRoutes
//
//  Created by Dennin Dalke on 05/03/15.
//  Copyright (c) 2015 Dennin Dalke. All rights reserved.
//

#import "RequestError.h"

@implementation RequestError

@synthesize code, message;

-(id)initWithCode:(int)pCode message:(NSString*)pMessage
{
    self = [super init];
    if(self)
    {
        self.code = pCode;
        self.message = pMessage;
    }
    return self;
}

@end