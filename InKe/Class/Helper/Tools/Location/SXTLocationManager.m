//
//  SXTLocationManager.m
//  InKe
//
//  Created by SJQ on 2018/3/26.
//  Copyright © 2018年 sjq. All rights reserved.
//

#import "SXTLocationManager.h"
#import <CoreLocation/CoreLocation.h>


@interface SXTLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locManager;
@property (nonatomic, copy) LocationBlock block;

@end

@implementation SXTLocationManager

+ (instancetype)sharedManager {
    static SXTLocationManager *_manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[SXTLocationManager alloc] init];
    });
    return _manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _locManager = [[CLLocationManager alloc] init];
        [_locManager setDesiredAccuracy:(kCLLocationAccuracyBest)];
        _locManager.distanceFilter = 100;
        _locManager.delegate = self;
        
        if (![CLLocationManager locationServicesEnabled]) {
            NSLog(@"没开启定位服务");
        } else {
            CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
            if (status == kCLAuthorizationStatusNotDetermined) {
                [_locManager requestWhenInUseAuthorization];
            }
        }
        
        
        
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    CLLocationCoordinate2D coor = newLocation.coordinate; 
    NSString *lat = [NSString stringWithFormat:@"%@",@(coor.latitude)];
    NSString *lon = [NSString stringWithFormat:@"%@",@(coor.longitude)];
    if (_block) {
        _block(lat,lon);
    }
    [self.locManager stopUpdatingLocation];
}

- (void)getGps:(LocationBlock )block {
    _block = block;
    [self.locManager startUpdatingLocation];
}

@end
