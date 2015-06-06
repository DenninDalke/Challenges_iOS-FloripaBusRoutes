//
//  RoutesSearchTableViewController.swift
//  FloripaBusRoutes
//
//  Created by Dennin Dalke on 05/03/15.
//  Copyright (c) 2015 Dennin Dalke. All rights reserved.
//

import UIKit

class RoutesSearchTableViewController: UITableViewController
{
    @IBOutlet var searchBar: UISearchBar!
    var routes:NSArray?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    //MARK: SearchBar Delegate
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        self.view.endEditing(true)
        self.searchForRoute()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar)
    {
        self.view.endEditing(true)
    }
    
    //MARK: Table View Source Data
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return routes != nil ? routes!.count : 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        var route:Route! = routes?.objectAtIndex(indexPath.row) as Route
        cell.textLabel?.text = NSString(format: "%@ - %@", route!.shortName!, route.longName!)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        var route:Route = self.routes!.objectAtIndex(indexPath.row) as Route
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setValue(route.id!, forKey: ROUTE_ID_KEY)
        self.performSegueWithIdentifier("ShowDetails", sender: nil)
    }
    
    //MARK: Methods
    func searchForRoute()
    {
        LoadingView.show(self.view)
        var request = FindRouteByNameRequest()
        request.stopName = NSString(format: "%%%@%%", self.searchBar.text!)
        request.makeRequestWithCallback { (rawResponse:BaseResponse!) -> Void in
            var response = rawResponse as BaseFloripaBusRoutesResponse
            self.routes = response.rows
            self.tableView.reloadData()
            LoadingView.hide()
        }
    }
}
