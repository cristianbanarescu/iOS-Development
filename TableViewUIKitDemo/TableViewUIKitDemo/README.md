# TableView UIKit Demo 

## Purpose 

- This is a `UIKit` based project.
- This project contains basic boilerplate code to use when an app needs/has a `UITAbleView` inside.
- The boilerplate code includes code from `UITableViewDataSource` and `UITableViewDelegate`, helfpul when dealing with `UITableView`. 

## Implementation 

- UITableViews used in this project are created and used in different ways:
    - UITableView inside a `UITableViewController`; the controller is created inside the Main storyboard. For more details, please see [TableViewController](./ViewControllers/TableViewController.swift)
    - UITableView inside a classic `UIViewController`; the controller is created inside the Main storyboard. For more details, please see [TableViewController](./ViewControllers/CustomTableViewController.swift) 
    - UITableView created from `scratch`, `programatically`; no storyboard used. For more details, please see [TableViewController](./ViewControllers/EmptyViewController.swift) 
