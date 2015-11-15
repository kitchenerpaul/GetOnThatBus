//
//  BusStop.h
//  GetOnThatBus
//
//  Created by Paul Kitchener on 10/13/15.
//  Copyright © 2015 Paul Kitchener. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusStop : NSObject

@property NSString *name;
@property NSString *route;
@property NSString *transfer;
@property double latitude;
@property double longitude;

@end
