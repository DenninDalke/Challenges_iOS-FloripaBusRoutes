//
//  FindDeparturesByRouteIdResponse.swift
//  FloripaBusRoutes
//
//  Created by Dennin Dalke on 05/03/15.
//  Copyright (c) 2015 Dennin Dalke. All rights reserved.
//
class FindDeparturesByRouteIdResponse: BaseFloripaBusRoutesResponse
{    
    override func parseRowElement(element: AnyObject!) -> AnyObject
    {
        var parsedItem = Departure()
        parsedItem.id = Int(element["id"] as NSNumber)
        parsedItem.calendar = Departure.CalendarTypes(rawValue: (element["calendar"] as NSString))
        parsedItem.time = String(element["time"] as NSString)
        return parsedItem;
    }
}
