//
//  DetailsViewController.swift
//  FloripaBusRoutes
//
//  Created by Dennin Dalke on 05/03/15.
//  Copyright (c) 2015 Dennin Dalke. All rights reserved.
//
import UIKit

class DetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    enum SegmentTypes : Int {
        case Stops = 0
        case Weekdays = 1
        case Saturday = 2
        case Sunday = 3
    }
    
    @IBOutlet var currentSegment: UISegmentedControl!
    @IBOutlet var tableView:UITableView!
    
    var weekdayDepartures:NSArray?
    var saturdayDepartures:NSArray?
    var sundayDepartures:NSArray?
    var stops:NSArray?
    var selectedSegment:SegmentTypes
    
    required init(coder aDecoder: NSCoder) {
        self.selectedSegment = SegmentTypes.Stops
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "detailsCell")
        self.loadDetails()
    }
    
    //MARK: Table View Source Data
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    @IBAction func segmentChanged(sender: AnyObject)
    {
        self.selectedSegment = SegmentTypes(rawValue: self.currentSegment.selectedSegmentIndex)!
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch self.selectedSegment
        {
        case DetailsViewController.SegmentTypes.Stops:
            return self.stops != nil ? self.stops!.count : 0
        case DetailsViewController.SegmentTypes.Weekdays:
            return self.weekdayDepartures != nil ? self.weekdayDepartures!.count : 0
        case DetailsViewController.SegmentTypes.Saturday:
            return self.saturdayDepartures != nil ? self.saturdayDepartures!.count : 0
        case DetailsViewController.SegmentTypes.Sunday:
            return self.sundayDepartures != nil ? self.sundayDepartures!.count : 0
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("detailsCell", forIndexPath: indexPath) as UITableViewCell
        
        switch self.selectedSegment
        {
        case SegmentTypes.Stops:
            var result:Stop = self.stops!.objectAtIndex(indexPath.row) as Stop
            cell.textLabel?.text = NSString(format: "%@", result.name!)
        case SegmentTypes.Weekdays:
            var result:Departure = self.weekdayDepartures!.objectAtIndex(indexPath.row) as Departure
            cell.textLabel?.text = NSString(format: "%@", result.time!)
        case SegmentTypes.Saturday:
            var result:Departure = self.saturdayDepartures!.objectAtIndex(indexPath.row) as Departure
            cell.textLabel?.text = NSString(format: "%@", result.time!)
        case SegmentTypes.Sunday:
            var result:Departure = self.sundayDepartures!.objectAtIndex(indexPath.row) as Departure
            cell.textLabel?.text = NSString(format: "%@", result.time!)
        default:
            return cell
        }
        return cell
    }
    
    //MARK: Methods
    func loadDetails()
    {
        LoadingView.show(self.view)
        self.loadStops()
        self.loadDepartures()
    }
    
    func loadStops() -> Void
    {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        var stopsRequest = FindStopsByRouteIdRequest()
        stopsRequest.routeId = userDefaults.stringForKey(ROUTE_ID_KEY)
        stopsRequest.makeRequestWithCallback { (rawResponse:BaseResponse!) -> Void in
            var response = rawResponse as BaseFloripaBusRoutesResponse
            self.stops = response.rows
        }
    }
    
    func loadDepartures() -> Void
    {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        var departuresRequest = FindDeparturesByRouteIdRequest()
        departuresRequest.routeId = userDefaults.stringForKey(ROUTE_ID_KEY)
        departuresRequest.makeRequestWithCallback { (rawResponse:BaseResponse!) -> Void in
            var response = rawResponse as BaseFloripaBusRoutesResponse
            self.parseDepartures(response.rows!)
            self.finishLoading()
        }
    }
    
    func finishLoading() -> Void
    {
        self.tableView.reloadData()
        LoadingView.hide()
    }
    
    func parseDepartures(rows:NSArray) -> Void
    {
        var tWeekdayDepartures = NSMutableArray()
        var tSaturdayDepartures = NSMutableArray()
        var tSundayDepartures = NSMutableArray()
        for row in rows
        {
            var departure = row as Departure
            switch departure.calendar!
            {
            case Departure.CalendarTypes.saturday:
                tSaturdayDepartures.addObject(departure)
            case Departure.CalendarTypes.sunday:
                tSundayDepartures.addObject(departure)
            default:
                tWeekdayDepartures.addObject(departure)
            }
        }
        self.weekdayDepartures = tWeekdayDepartures
        self.saturdayDepartures = tSaturdayDepartures
        self.sundayDepartures = tSundayDepartures
    }
}
