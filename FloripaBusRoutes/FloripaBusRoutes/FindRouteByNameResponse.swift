//
//  FindRouteByNameResponse.swift
//  FloripaBusRoutes
//
//  Created by Dennin Dalke on 05/03/15.
//  Copyright (c) 2015 Dennin Dalke. All rights reserved.
//
class FindRouteByNameResponse: BaseFloripaBusRoutesResponse
{
    override func parseRowElement(element: AnyObject!) -> AnyObject
    {
        var parsedItem = Route()
        parsedItem.id = Int(element["id"] as NSNumber)
        parsedItem.shortName = String(element["shortName"] as NSString)
        parsedItem.longName = String(element["longName"] as NSString)
        return parsedItem;
    }
}
