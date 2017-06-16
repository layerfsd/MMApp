//
//  JGLocationHelper.m
//  CCBGJJ.iOS
//
//  Created by Sam Yu on 2/21/17.
//  Copyright © 2017 CCB. All rights reserved.
//

#import "JGLocationHelper.h"
#import <CoreLocation/CoreLocation.h>

@interface JGLocationHelper () <CLLocationManagerDelegate>

@property(nonatomic,strong)CLLocationManager *locationManager;

@end
@implementation JGLocationHelper

//定位
-(void)startGetLocation
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    CLAuthorizationStatus status=[CLLocationManager authorizationStatus];
    if (status==kCLAuthorizationStatusNotDetermined || status==kCLAuthorizationStatusRestricted || status==kCLAuthorizationStatusDenied){
        [_locationManager requestWhenInUseAuthorization];
    }
    // 设置代理
    _locationManager.delegate = self;
    // 设置定位精确度到米
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    // 设置过滤器为无
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    // 开始定位
    [_locationManager startUpdatingLocation];
}

#pragma CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    [self.delegate locationHelper:self didFailWithError:error];
    [manager stopUpdatingLocation];
    manager.delegate=nil;
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //经度
    NSString *locationLong = [NSString stringWithFormat:@"%lf", newLocation.coordinate.longitude];
    //纬度
    NSString * locationLat = [NSString stringWithFormat:@"%lf", newLocation.coordinate.latitude];
    //获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            //将获得的所有信息显示到label上
            NSMutableString *address=[NSMutableString new];
            if (placemark.country) {
                //国家
                [address appendString:placemark.country];
            }
            if(placemark.administrativeArea){
                //省
                [address appendString:placemark.administrativeArea];
            }
            if(placemark.subAdministrativeArea){
                //省
                [address appendString:placemark.subAdministrativeArea];
            }
            if(placemark.locality){
                //市
                [address appendString:placemark.locality];
            }
            if(placemark.subLocality){
                //市
                [address appendString:placemark.subLocality];
            }
            if(placemark.thoroughfare){
                //区
                [address appendString:placemark.thoroughfare];
            }
            if(placemark.subThoroughfare){
                //区
                [address appendString:placemark.subThoroughfare];
            }
            NSMutableDictionary *dic=[NSMutableDictionary new];
            if (locationLong) {
                [dic setValue:locationLong forKey:@"long"];
            }
            if(locationLat){
                [dic setValue:locationLat forKey:@"lat"];
            }
            if(locationLat){
                [dic setValue:address forKey:@"address"];
            }
            [self.delegate locationHelper:self didGetlocationLong:locationLong locationLat:locationLat address:address];
        }else{
            [self.delegate locationHelper:self didFailWithError:nil];
        }
    }];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
    manager.delegate=nil;
}

@end
