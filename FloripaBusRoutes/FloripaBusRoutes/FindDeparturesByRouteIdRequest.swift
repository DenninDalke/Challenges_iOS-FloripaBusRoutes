//
//  FindDepartureByRouteIdRequest.swift
//  FloripaBusRoutes
//
//  Created by Dennin Dalke on 05/03/15.
//  Copyright (c) 2015 Dennin Dalke. All rights reserved.
//
class FindDeparturesByRouteIdRequest: BaseFloripaBusRouteRequest
{
    var routeId :String?

    override func servicePath() -> String
    {
        return "/v1/queries/findDeparturesByRouteId/run"
    }
}
