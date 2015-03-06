//
//  FindStopByRouteIdResponse.swift
//  FloripaBusRoutes
//
//  Created by Dennin Dalke on 06/03/15.
//  Copyright (c) 2015 Dennin Dalke. All rights reserved.
//
class FindStopsByRouteIdResponse: BaseFloripaBusRoutesResponse
{
    override func parseRowElement(element: AnyObject!) -> AnyObject
    {
        var parsedItem = Stop()
        parsedItem.id = Int(element["id"] as NSNumber)
        parsedItem.name = String(element["name"] as NSString)
        parsedItem.sequence = Int(element["sequence"] as NSNumber)
        return parsedItem;
    }
}