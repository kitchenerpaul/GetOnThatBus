//
//  DetailViewController.m
//  GetOnThatBus
//
//  Created by Paul Kitchener on 10/13/15.
//  Copyright © 2015 Paul Kitchener. All rights reserved.
//

#import "DetailViewController.h"
#import "BusStop.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *routeLabel;
@property (weak, nonatomic) IBOutlet UILabel *transferLabel;
@property (weak, nonatomic) IBOutlet UILabel *transferTitleLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

        self.nameLabel.text = self.detailBusStop.name;
        self.routeLabel.text = self.detailBusStop.route;

        if ([self.detailBusStop.transfer length] > 0) {
            self.transferLabel.text = self.detailBusStop.transfer;
        } else {
            self.transferLabel.hidden = YES;
            self.transferTitleLabel.hidden = YES;
        }
}

- (IBAction)dismissButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
