//
//  BusStopsTableViewController.m
//  GetOnThatBus
//
//  Created by Paul Kitchener on 10/15/15.
//  Copyright © 2015 Paul Kitchener. All rights reserved.
//

#import "BusStopsTableViewController.h"
#import "BusStop.h"

@interface BusStopsTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *busTableView;
@end

@implementation BusStopsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];




}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.busStops.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusCellID" forIndexPath:indexPath];
    NSDictionary *dict = [self.busStops objectAtIndex:indexPath.row];
    cell.textLabel.text = [dict objectForKey:@"cta_stop_name"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Route(s): %@",[dict objectForKey:@"routes"]];

    return cell;
}



@end