//
// Copyright (c) 2020 Makaio GmbH. All rights reserved.
//

#import "BluetoothPermissionStrategy.h"

#if PERMISSION_BLUETOOTH

@implementation BluetoothPermissionStrategy {
    CBCentralManager *_centralManager;
    PermissionStatusHandler _permissionStatusHandler;
    PermissionGroup _requestedPermission;
}
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    
    PermissionStatus status = [self checkPermissionStatus:PermissionGroupBluetooth];
  
    _centralManager.delegate = nil;
    _centralManager = nil;
    
    _permissionStatusHandler(status);
    
}
- (PermissionStatus)checkPermissionStatus:(PermissionGroup)permission {
    return [BluetoothPermissionStrategy permissionStatus:permission];
}

- (ServiceStatus)checkServiceStatus:(PermissionGroup)permission {
    return ServiceStatusNotApplicable;
}

- (void)requestPermission:(PermissionGroup)permission completionHandler:(PermissionStatusHandler)completionHandler {
    
    if(!_centralManager)
    {
        _centralManager = [[CBCentralManager new] initWithDelegate:self
                queue:nil
                options:@{CBCentralManagerOptionShowPowerAlertKey: @YES}
            ];

    }
    _permissionStatusHandler = completionHandler;
    
    /*
    PermissionStatus status = [self checkPermissionStatus:permission];
     completionHandler(status);
     */
     /*
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse && permission == PermissionGroupLocationAlways) {
        // don't do anything and continue requesting permissions
    } else if (status != PermissionStatusNotDetermined) {
        completionHandler(status);
    }
    
    
    _requestedPermission = permission;
    
    if (permission == PermissionGroupLocation) {
        if ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"] != nil) {
            [_locationManager requestAlwaysAuthorization];
        } else if ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"] != nil) {
            [_locationManager requestWhenInUseAuthorization];
        } else {
            [[NSException exceptionWithName:NSInternalInconsistencyException reason:@"To use location in iOS8 you need to define either NSLocationWhenInUseUsageDescription or NSLocationAlwaysUsageDescription in the app bundle's Info.plist file" userInfo:nil] raise];
        }
    } else if (permission == PermissionGroupLocationAlways) {
        if ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"] != nil) {
            [_locationManager requestAlwaysAuthorization];
        } else {
            [[NSException exceptionWithName:NSInternalInconsistencyException reason:@"To use location in iOS8 you need to define NSLocationAlwaysUsageDescription in the app bundle's Info.plist file" userInfo:nil] raise];
        }
    } else if (permission == PermissionGroupLocationWhenInUse) {
        if ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"] != nil) {
            [_locationManager requestWhenInUseAuthorization];
        } else {
            [[NSException exceptionWithName:NSInternalInconsistencyException reason:@"To use location in iOS8 you need to define NSLocationWhenInUseUsageDescription in the app bundle's Info.plist file" userInfo:nil] raise];
        }
    }*/
}

+ (PermissionStatus)permissionStatus:(PermissionGroup)permission {

    NSInteger authorizationStatus = 0;
    
    if (@available(iOS 13.1, *)) {
        authorizationStatus = [CBCentralManager authorization];
    } else {
        
        if (@available(iOS 13.0, *)) {
        CBCentralManager *_centralManager = [[CBCentralManager new] initWithDelegate:nil
                queue:nil
                options:@{CBCentralManagerOptionShowPowerAlertKey: @NO}
            ];

        authorizationStatus = [_centralManager authorization];
          
     
        } else {
            //authorizationStatus = [CBPeripheralManager authorizationStatus];
        }
    }
    
    PermissionStatus status = [BluetoothPermissionStrategy
                               determinePermissionStatus:permission authorizationStatus:authorizationStatus];
    
    return status;
}


+ (PermissionStatus)determinePermissionStatus:(PermissionGroup)permission authorizationStatus:(NSInteger)authorizationStatus {

    if (@available(iOS 13.0, *)) {
        switch (authorizationStatus) {
            case CBManagerAuthorizationNotDetermined:
                return PermissionStatusNotDetermined;
            case CBManagerAuthorizationRestricted:
                return PermissionStatusRestricted;
            case CBManagerAuthorizationDenied:
                return PermissionStatusDenied;
            case CBManagerAuthorizationAllowedAlways:
                return PermissionStatusGranted;
        }
    } else {
        return PermissionStatusGranted;
    }
    
    return PermissionStatusNotDetermined;
}

@end

#else

@implementation BluetoothPermissionStrategy
@end

#endif
