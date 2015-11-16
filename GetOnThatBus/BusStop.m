//
//  BusStop.m
//  GetOnThatBus
//
//  Created by Paul Kitchener on 10/13/15.
//  Copyright © 2015 Paul Kitchener. All rights reserved.
//

#import "BusStop.h"

@implementation BusStop

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];

    if (self) {
        self.name = dictionary[@"cta_stop_name"];
        self.route = dictionary[@"routes"];
        self.transfer = dictionary[@"inter_modal"];
        self.latitude = [[dictionary objectForKey:@"latitude"]doubleValue];
        self.longitude = [[dictionary objectForKey:@"longitude"]doubleValue];
    }
    return self;
}

@end
