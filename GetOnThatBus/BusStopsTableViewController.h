//
//  BusStopsTableViewController.h
//  GetOnThatBus
//
//  Created by Paul Kitchener on 10/15/15.
//  Copyright © 2015 Paul Kitchener. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusStop.h"

@interface BusStopsTableViewController : UITableViewController

@property NSDictionary *busStopDictionary;
@property NSMutableArray *busStops;
@property NSMutableArray *stops;
@property BusStop *busStop;

@end
