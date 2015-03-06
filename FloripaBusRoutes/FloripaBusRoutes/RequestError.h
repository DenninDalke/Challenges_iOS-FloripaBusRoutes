//
//  RequestError.h
//  FloripaBusRoutes
//
//  Created by Dennin Dalke on 05/03/15.
//  Copyright (c) 2015 Dennin Dalke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestError : NSObject

@property (nonatomic) int code;
@property (nonatomic,strong) NSString *message;

-(id)initWithCode:(int)code message:(NSString*)message;

@end
