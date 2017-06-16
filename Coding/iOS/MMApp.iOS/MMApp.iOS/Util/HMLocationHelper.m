//
//  HMLocationHelper.m
//
//  Created by Sam Yu on 2/21/17.
//  Copyright © 2017 LLBT. All rights reserved.
//

#import "HMLocationHelper.h"
#import <CoreLocation/CoreLocation.h>

@interface HMLocationHelper () <CLLocationManagerDelegate>

@property(nonatomic,strong)CLLocationManager *locationManager;

@end
@implementation HMLocationHelper

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
            NSString *countryCode = @"";
            NSString *country = @"";
            NSString *state = @"";
            NSString *city = @"";
            NSString *subLocality = @"";
            NSString *street = @"";
            NSString *formattedAddress = @"";
            
            //将获得的所有信息显示到label上
            if (placemark.ISOcountryCode) {
                countryCode = placemark.ISOcountryCode;
            }
            if (placemark.country) {
                country = placemark.country;
            }
            if(placemark.administrativeArea){
                //省
                state = placemark.administrativeArea;
            }
            if(placemark.locality){
                //市
                city = placemark.locality;
            }
            if(placemark.subLocality){
                //区
                subLocality = placemark.subLocality;
            }
            if (placemark.addressDictionary) {
                street = placemark.addressDictionary[@"Street"];
                formattedAddress = placemark.addressDictionary[@"FormattedAddressLines"];
            }

            NSMutableDictionary *dic=[NSMutableDictionary new];
            if (locationLong) {
                [dic setValue:locationLong forKey:@"long"];
            }
            if(locationLat){
                [dic setValue:locationLat forKey:@"lat"];
            }
            [self.delegate locationHelper:self didGetlocationLong:locationLong locationLat:locationLat address:@{@"countryCode":countryCode, @"country":country, @"state":state, @"city":city, @"subLocality": subLocality, @"street":street, @"formattedAddress":formattedAddress}];
        }else{
            [self.delegate locationHelper:self didFailWithError:nil];
        }
    }];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
    manager.delegate=nil;
}

@end
