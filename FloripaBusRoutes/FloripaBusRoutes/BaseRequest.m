//
//  BaseRequest.m
//  FloripaBusRoutes
//
//  Created by Dennin Dalke on 05/03/15.
//  Copyright (c) 2015 Dennin Dalke. All rights reserved.
//
#import "AppConfig.h"
#import "BaseRequest.h"
#import "JSONUtils.h"
#import "ReflectionUtils.h"

// Constants:
int const RequestInvalidServerResponseErrorCode = 100;
int const RequestInvalidResponseConversionErrorCode = 101;
NSString* const RequestInvalidServerResponseErrorMessage = @"Não foi possível realizar a requisição no momento.";
NSString* const RequestInvalidResponseConversionErrorMessage = @"Não foi possível enviar sua solicitação no momento.";

@interface BaseRequest()
{
    int retryInvalidApoliceCounter;
    NSMutableURLRequest *currentRequest;
    void (^currentRequestResponseCallback)(BaseResponse* requestResponse);
}
@end

@implementation BaseRequest

-(NSString*)hostUrl
{
    return [[NSString alloc] initWithUTF8String:HOST_URL];
}

-(NSString*)servicePath
{
    return @"";
}

-(instancetype)init
{
    self = [super init];
    if(self)
    {
        retryInvalidApoliceCounter = 0;
    }
    return self;
}

-(void) makeRequestWithCallback:( void( ^ )( BaseResponse*) )requestResponseCallback
{
    currentRequest = [self buildRequest];
    currentRequestResponseCallback = requestResponseCallback;
    [self doRequest];
}

-(void) doRequest
{
    [NSURLConnection sendAsynchronousRequest:currentRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         [self requestCompletionHandler:response :data :error];
     }];
}

-(void) requestCompletionHandler:(NSURLResponse*)response :(NSData*)data :(NSError*)error
{
    BaseResponse* requestResponse = [self processRequestResponse:response error:error data:data];
    currentRequestResponseCallback(requestResponse);
}

-(BaseResponse*) makeSyncRequest
{
    NSError *error;
    NSMutableURLRequest *request = [self buildRequest];
    NSURLResponse *response;
    NSData *data = [NSURLConnection
                    sendSynchronousRequest:request
                    returningResponse:&response
                    error:&error];
    
    return [self processRequestResponse:nil error:error data:data];
}

// Request Aux
-(NSURL*)getURL
{
    return [NSURL URLWithString:
            [NSString stringWithFormat:@"%s%s:%s@%@%@",HOST_PROTOCOL,BASIC_AUTH_USER, BASIC_AUTH_PASSWORD, [self hostUrl],[self servicePath]]];
}

-(NSMutableURLRequest*)buildRequest
{
    NSData *jsonData = [self jsonData];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[self getURL]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"staging" forHTTPHeaderField:@"X-AppGlu-Environment"];
    [request setValue:[NSString stringWithFormat:@"%ld", (unsigned long)[jsonData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:jsonData];
    NSLog(@"Request to \"%@\"\ndata:\n%@", [self getURL], [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    return request;
}


-(BaseResponse*)processRequestResponse:(NSURLResponse*)response error:(NSError*)error data:(NSData*)data
{
    BaseResponse* requestResponse;
    if(error != nil)
    {
        requestResponse = [[BaseResponse alloc] init];
        requestResponse.error = [[RequestError alloc] initWithCode:RequestInvalidServerResponseErrorCode message:RequestInvalidServerResponseErrorMessage];
        return requestResponse;
    }
    if(data == nil)
    {
        requestResponse = [[BaseResponse alloc] init];
        requestResponse.error = [[RequestError alloc] initWithCode:RequestInvalidResponseConversionErrorCode message:RequestInvalidServerResponseErrorMessage];
        return requestResponse;
    }
    NSString *jsonResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];;
    if(jsonResponse == nil)
    {
        requestResponse = [[BaseResponse alloc] init];
        requestResponse.error = [[RequestError alloc] initWithCode:RequestInvalidServerResponseErrorCode message:RequestInvalidServerResponseErrorMessage];
        return requestResponse;
    }
    NSLog(@"%@", jsonResponse);
    id responseData = [JSONUtils JSONParse:jsonResponse];
    
    if([responseData isKindOfClass:[NSArray class]])
        return [self onSuccessArrayResponse:(NSArray*)responseData];
    
    if([responseData isKindOfClass:[NSDictionary class]])
        return [self onSuccessDictionaryResponse:(NSDictionary*)responseData];

    requestResponse = [[BaseResponse alloc] init];
    requestResponse.error = [[RequestError alloc] initWithCode:RequestInvalidServerResponseErrorCode message:RequestInvalidServerResponseErrorMessage];
    return requestResponse;
}

-(void)bindObject:(id)object
{
    [ReflectionUtils copyPropertiesFromObject:object toObject:self];
}

-(BaseResponse*)onSuccessDictionaryResponse:(NSDictionary*)responseDictionary
{
    // Identify the response class by prefix name.
    NSString* className = [NSStringFromClass([self class]) stringByReplacingOccurrencesOfString:@"Request" withString:@"Response"];
    BaseResponse* requestResponseHandler =[[NSClassFromString(className) alloc] initWithDictionary:responseDictionary];
    
    if(requestResponseHandler == nil)
    {
        //DDLOGWarn(@"No RequestResponse Handler found, using the default one");
        requestResponseHandler = [[BaseResponse alloc] initWithDictionary:responseDictionary];
    }
    return requestResponseHandler;
}

-(BaseResponse*)onSuccessArrayResponse:(NSArray*)responseArray
{
    BaseResponse* requestResponse = [[BaseResponse alloc] initWithDictionaryArray:responseArray];
    //requestResponse.error = false;
    return requestResponse;
}

-(NSData*) jsonData
{
    NSDictionary* dictionary = [ReflectionUtils getPropertiesFromObject:self];
    return [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
}

@end
