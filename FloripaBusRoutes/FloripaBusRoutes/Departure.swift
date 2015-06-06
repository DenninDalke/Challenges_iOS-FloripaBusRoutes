//
//  Departure.swift
//  FloripaBusRoutes
//
//  Created by Dennin Dalke on 05/03/15.
//  Copyright (c) 2015 Dennin Dalke. All rights reserved.
//
class Departure: BaseModel
{
    enum CalendarTypes :String{
        case weekday = "WEEKDAY"
        case saturday = "SATURDAY"
        case sunday = "SUNDAY"
    }
    
    var id:Int?
    var calendar:CalendarTypes?
    var time:String?
}
