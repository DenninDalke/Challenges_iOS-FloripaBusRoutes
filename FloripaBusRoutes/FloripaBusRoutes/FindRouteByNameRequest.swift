//
//  FindRouteByNameRequest.swift
//  FloripaBusRoutes
//
//  Created by Dennin Dalke on 05/03/15.
//  Copyright (c) 2015 Dennin Dalke. All rights reserved.
//
class FindRouteByNameRequest: BaseFloripaBusRouteRequest
{
    var stopName :String?;
    
    override func servicePath() -> String
    {
        return "/v1/queries/findRoutesByStopName/run";
    }
}
