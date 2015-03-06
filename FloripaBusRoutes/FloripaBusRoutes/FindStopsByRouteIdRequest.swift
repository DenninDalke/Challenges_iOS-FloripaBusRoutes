//
//  FindStopByRouteIdRequest.swift
//  FloripaBusRoutes
//
//  Created by Dennin Dalke on 06/03/15.
//  Copyright (c) 2015 Dennin Dalke. All rights reserved.
//
class FindStopsByRouteIdRequest: BaseFloripaBusRouteRequest
{
    var routeId :String?
    
    override func servicePath() -> String
    {
        return "/v1/queries/findStopsByRouteId/run"
    }
}
