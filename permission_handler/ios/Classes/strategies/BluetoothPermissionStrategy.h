//
// Copyright (c) 2020 Makaio GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PermissionStrategy.h"

#if PERMISSION_BLUETOOTH

#import <CoreBluetooth/CoreBluetooth.h>

@interface BluetoothPermissionStrategy : NSObject <PermissionStrategy, CBCentralManagerDelegate>

@end

#else

#import "UnknownPermissionStrategy.h"
@interface BluetoothPermissionStrategy : UnknownPermissionStrategy
@end

#endif
