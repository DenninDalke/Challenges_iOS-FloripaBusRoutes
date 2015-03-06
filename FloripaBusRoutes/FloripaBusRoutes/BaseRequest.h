//
//  BaseRequest.h
//  FloripaBusRoutes
//
//  Created by Dennin Dalke on 05/03/15.
//  Copyright (c) 2015 Dennin Dalke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseResponse.h"

extern int const RequestInvalidServerResponseErrorCode;
extern int const RequestInvalidResponseConversionErrorCode;
extern NSString* const RequestInvalidServerResponseErrorMessage;
extern NSString* const RequestInvalidResponseConversionErrorMessage;

@interface BaseRequest : NSObject

-(BaseResponse*)makeSyncRequest;
-(void) makeRequestWithCallback:( void( ^ )( BaseResponse*) )requestResponseCallback;
-(BaseResponse*)onSuccessDictionaryResponse:(NSDictionary*)dictionary;
-(BaseResponse*)onSuccessArrayResponse:(NSArray*)array;
-(void)bindObject:(id)object;
-(NSData*)jsonData;
-(NSString*)servicePath;
-(NSString*)hostUrl;

@end
