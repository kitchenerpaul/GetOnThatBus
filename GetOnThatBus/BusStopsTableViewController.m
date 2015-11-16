//
//  BusStopsTableViewController.m
//  GetOnThatBus
//
//  Created by Paul Kitchener on 10/15/15.
//  Copyright © 2015 Paul Kitchener. All rights reserved.
//

#import "BusStopsTableViewController.h"
#import "DetailViewController.h"
#import "BusStop.h"

@interface BusStopsTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *busTableView;

@end

@implementation BusStopsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)onBackButtonPushed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailID"];
    self.busStop = [self.stops objectAtIndex:indexPath.row];

    [self presentViewController:detailViewController animated:YES completion:nil];
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController *dvc = segue.destinationViewController;
    dvc.nameLabel.text = self.busStop.name;
}

@end