#import <Foundation/Foundation.h>
#import "FSSwitchPanel.h"

#define PREF_PATH @"/Library/LaunchDaemons/com.openssh.sshd.plist"
#define BKUP_PATH @"/Library/LaunchDaemons/com.openssh.sshd.plist.bak"
#define SSH2_PATH @"/Library/LaunchDaemons/com.openssh.sshd.plist.swp"

#define FILE_PATH @"/etc/services"
#define ORIG_PATH @"/etc/services.bak"
#define SWAP_PATH @"/etc/services.swp"

#define FLAG_PATH @"/etc/services.flag"

static BOOL isEnabled;

int main(int argc, char **argv, char **envp) {
    @autoreleasepool {
        NSFileManager *manager = [NSFileManager defaultManager];
        
        isEnabled = [manager fileExistsAtPath:FLAG_PATH];
        
        if (isEnabled) {
            [manager removeItemAtPath:FLAG_PATH error:nil];
            
            [manager removeItemAtPath:PREF_PATH error:nil];
            [manager copyItemAtPath:BKUP_PATH toPath:PREF_PATH error:nil];
            
            [manager removeItemAtPath:FILE_PATH error:nil];
            [manager copyItemAtPath:ORIG_PATH toPath:FILE_PATH error:nil];
        } else {
            [manager createFileAtPath:FLAG_PATH contents:nil attributes:nil];
            
            [manager removeItemAtPath:PREF_PATH error:nil];
            [manager copyItemAtPath:SSH2_PATH toPath:PREF_PATH error:nil];
            
            [manager removeItemAtPath:FILE_PATH error:nil];
            [manager copyItemAtPath:SWAP_PATH toPath:FILE_PATH error:nil];
        }
        [[FSSwitchPanel sharedPanel] applyActionForSwitchIdentifier:@"com.ichitaso.sshflipswitch"];
        [[FSSwitchPanel sharedPanel] applyActionForSwitchIdentifier:@"com.ichitaso.sshflipswitch"];
    }
    return 0;
}