#import "FSSwitchDataSource.h"
#import "FSSwitchPanel.h"

#define FLAG_PATH @"/etc/services.flag"

@interface LocalSSHSwitch : NSObject <FSSwitchDataSource>
@end

@implementation LocalSSHSwitch

- (FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier
{
    BOOL isEnabled = [[NSFileManager defaultManager] fileExistsAtPath:FLAG_PATH];
    return isEnabled ? FSSwitchStateOn : FSSwitchStateOff;
}

- (void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier
{
    system("/usr/bin/localssh");
}

@end