//
//  ViewController.h
//  PlaySoundDemo1
//
//  Created by  on 2011/10/28.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>

@interface ViewController : UIViewController{
    IBOutlet UISwitch *swcallback;
    IBOutlet UIPickerView *soundPicker;
    NSArray *soundData;
    SystemSoundID soundFileObject;   
}

@property (nonatomic,retain) UISwitch *swcallback;
@property (nonatomic,retain) UIPickerView *soundPicker;
@property (nonatomic,retain)  NSArray *soundData;
@property (readonly)        SystemSoundID        soundFileObject;

static void completionCallback (SystemSoundID  mySSID, void* myself) ;
- (IBAction) playSystemSound;
- (IBAction) playAlertSound;
- (IBAction) vibrate;
-(IBAction) stopplaysound;
-(void) GetPlaysound;

@end