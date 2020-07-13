//
//  PermissionHandlerEnums.h
//  permission_handler
//
//  Created by Razvan Lung on 15/02/2019.
//
// ios: PermissionGroupBluetooth
// Info.plist: [NSBluetoothAlwaysUsageDescription, NSBluetoothPeripheralUsageDescription]
// dart: PermissionGroup.bluetooth
#ifndef PERMISSION_BLUETOOTH
    #define PERMISSION_BLUETOOTH 1
#endif

typedef NS_ENUM(int, PermissionGroup) {
    PermissionGroupCalendar = 0,
    PermissionGroupCamera,
    PermissionGroupContacts,
    PermissionGroupLocation,
    PermissionGroupLocationAlways,
    PermissionGroupLocationWhenInUse,
    PermissionGroupMediaLibrary,
    PermissionGroupMicrophone,
    PermissionGroupPhone,
    PermissionGroupPhotos,
    PermissionGroupReminders,
    PermissionGroupSensors,
    PermissionGroupSms,
    PermissionGroupSpeech,
    PermissionGroupStorage,
    PermissionGroupIgnoreBatteryOptimizations,
    PermissionGroupNotification,
    PermissionGroupAccessMediaLocation,
    PermissionGroupActivityRecognition,
    PermissionGroupBluetooth,
    PermissionGroupUnknown,
};

typedef NS_ENUM(int, PermissionStatus) {
    PermissionStatusDenied = 0,
    PermissionStatusGranted,
    PermissionStatusRestricted,
    PermissionStatusNotDetermined,
};

typedef NS_ENUM(int, ServiceStatus) {
    ServiceStatusDisabled = 0,
    ServiceStatusEnabled,
    ServiceStatusNotApplicable,
};
