#import <UIKit/UIKit.h>
#import <SpringBoard/SpringBoard.h>
#import "FSSwitchPanel.h"

#define FLAG_PATH @"/etc/services.flag"

%hook SpringBoard
- (void)applicationDidFinishLaunching:(id)application
{
    %orig;

    NSFileManager *manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:FLAG_PATH]) {
        [[FSSwitchPanel sharedPanel] applyActionForSwitchIdentifier:@"com.ichitaso.localsshtoggle"];
    }
}
%end
