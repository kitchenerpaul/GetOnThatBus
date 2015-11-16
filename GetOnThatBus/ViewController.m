//
//  ViewController.m
//  GetOnThatBus
//
//  Created by Paul Kitchener on 10/13/15.
//  Copyright © 2015 Paul Kitchener. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "BusStop.h"
#import "DetailViewController.h"
#import "BusStopsTableViewController.h"

@interface ViewController () <MKMapViewDelegate>


@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property NSDictionary *busStopDictionary;
@property NSMutableArray *busStops;
@property NSMutableArray *stops;
@property BusStop *busStop;

@property CLLocationManager *locationManager;

@property NSMutableDictionary *pointStops;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.locationManager = [CLLocationManager new];
    [self.locationManager requestWhenInUseAuthorization];
    self.mapView.showsUserLocation = YES;
    self.stops = [NSMutableArray new];

    self.pointStops = [NSMutableDictionary new];

    NSURL *url = [NSURL URLWithString:@"https://s3.amazonaws.com/mmios8week/bus.json"];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
     self.busStopDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

    dispatch_async(dispatch_get_main_queue(), ^{
        self.busStops = [self.busStopDictionary objectForKey:@"row"];

        for (NSDictionary *dictionary in self.busStops) {
            self.busStop = [[BusStop alloc] initWithDictionary:dictionary];

            if ([[dictionary[@"location"]objectForKey:@"longitude"]floatValue] > 0) {
                self.busStop.longitude = [dictionary[@"longitude"] floatValue];
            } else {
                self.busStop.longitude = [[dictionary[@"location"]objectForKey:@"longitude"]floatValue];
            }
            [self.stops addObject:self.busStop];
        }

        for (BusStop *bus in self.stops) {
            MKPointAnnotation *pointAnnotation = [MKPointAnnotation new];
            pointAnnotation.coordinate = CLLocationCoordinate2DMake(bus.latitude, bus.longitude);
            self.pointStops[[NSString stringWithFormat:@"%f%f", bus.latitude, bus.longitude]] = bus;
            pointAnnotation.title = bus.name;
            pointAnnotation.subtitle = [NSString stringWithFormat:@"Route(s): %@",bus.route];
            [self.mapView addAnnotation:pointAnnotation];
            [self setMapRegion];
        }

         });
    }];

    [task resume];


}

- (IBAction)segmentedControlSwitched:(UISegmentedControl *)sender {

    if (self.segmentedControl.selectedSegmentIndex == 1) {
        self.segmentedControl.selectedSegmentIndex = 0;
        BusStopsTableViewController *busStopsTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ListID"];
        busStopsTVC.busStopDictionary = self.busStopDictionary;
        busStopsTVC.busStops = self.busStops;
        busStopsTVC.stops = self.stops;
        [self presentViewController:busStopsTVC animated:YES completion:nil];
    }
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {

    [self.mapView setRegion:MKCoordinateRegionMake(view.annotation.coordinate, MKCoordinateSpanMake(.01, .01)) animated:YES];

    DetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailID"];
    detailViewController.detailBusStop = self.pointStops[[NSString stringWithFormat:@"%f%f", view.annotation.coordinate.latitude, view.annotation.coordinate.longitude]];
    [self presentViewController:detailViewController animated:YES completion:nil];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {

    if ([annotation isEqual:mapView.userLocation]) {
        return nil;
    } else {
        MKAnnotationView *pin = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
//        BusStop *busStop = [BusStop new];

        for (BusStop *busStop in self.stops) {
            if ([busStop.transfer isEqualToString:@"Pace"]) {
                pin.image = [UIImage imageNamed:@"pace"];
            } else if ([busStop.transfer isEqualToString:@"Metra"]) {
                pin.image = [UIImage imageNamed:@"metra"];
            } 
        }

        pin.canShowCallout = YES;
        pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        return pin;
    }
}

-(void)setMapRegion {

    float sumX = 0;
    float sumY = 0;
    float greatestX = -1000;
    float greatestY = -1000;
    float smallestX = 1000;
    float smallestY = 1000;

    for (BusStop *stop in self.stops) {
        sumX += stop.latitude;
        sumY += stop.longitude;

        if (stop.latitude > greatestX) {
            greatestX = stop.latitude;
        }
        if (stop.latitude < smallestX) {
            smallestX = stop.latitude;
        }
        if (stop.longitude > greatestY) {
            greatestY = stop.longitude;
        }
        if (stop.longitude < smallestY) {
            smallestY = stop.longitude;
        }
    }

    float avgX = sumX / self.stops.count;
    float avgY = sumY / self.stops.count;

    float deltaX = greatestX - smallestX;
    float deltaY = greatestY - smallestY;

    [self.mapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(avgX, avgY), MKCoordinateSpanMake(deltaX + .1, deltaY)) animated:YES];
}

-(void)unwindForSegue:(UIStoryboardSegue *)unwindSegue towardsViewController:(UIViewController *)subsequentVC {
    
}


@end