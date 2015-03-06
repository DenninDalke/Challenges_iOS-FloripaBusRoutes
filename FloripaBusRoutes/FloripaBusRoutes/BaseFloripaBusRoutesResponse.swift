//
//  BaseFloripaBusRoutesResponse.swift
//  FloripaBusRoutes
//
//  Created by Dennin Dalke on 05/03/15.
//  Copyright (c) 2015 Dennin Dalke. All rights reserved.
//
class BaseFloripaBusRoutesResponse: BaseResponse {
    
    var rows:NSArray?;
    
    override func parseResponse(dictionary: AnyObject!)
    {
        super.parseResponse(dictionary)
        
        var elements = NSMutableArray()
        for element in rows!
        {
            elements.addObject(self.parseRowElement(element))
        }
        self.rows = elements;
    }
    
    func parseRowElement(element:AnyObject!) -> AnyObject
    {
        // Override in children:
        return element;
    }
}
