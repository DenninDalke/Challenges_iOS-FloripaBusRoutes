//
//  BaseFloripaBusRouteRequest.swift
//  FloripaBusRoutes
//
//  Created by Dennin Dalke on 05/03/15.
//  Copyright (c) 2015 Dennin Dalke. All rights reserved.
//
class BaseFloripaBusRouteRequest: BaseRequest
{
    override func jsonData() -> NSData!
    {
        var dictionary :NSDictionary? = ["params":ReflectionUtils.getPropertiesFromObject(self)]
        return NSJSONSerialization.dataWithJSONObject(dictionary!, options: NSJSONWritingOptions.PrettyPrinted, error: nil)
    }
}
