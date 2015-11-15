//
//  DetailViewController.h
//  GetOnThatBus
//
//  Created by Paul Kitchener on 10/13/15.
//  Copyright © 2015 Paul Kitchener. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusStop.h"

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@property NSDictionary *busStopDictionary;
@property NSMutableArray *busStops;
@property NSMutableArray *stops;

@property BusStop *detailBusStop;

@end
