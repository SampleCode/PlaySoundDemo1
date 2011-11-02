//
//  ViewController.m
//  PlaySoundDemo1
//
//  Created by  on 2011/10/28.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize swcallback,soundPicker,soundData,soundFileObject;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {

    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //建立音效清單陣列
    NSArray *array=[[NSArray alloc] initWithObjects:@"音效1",@"音效2",@"音效3",nil];
    self.soundData=array;
    [array release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
//停止當前音效的播放
-(IBAction) stopplaysound{    
    AudioServicesRemoveSystemSoundCompletion (self.soundFileObject);
}

//建立聲音物件
-(void) GetPlaysound{
    [self stopplaysound];
    
   //取出使用者所選擇的音效項目 
   NSInteger row=[ soundPicker selectedRowInComponent:0];
   
    //指定不同的音效檔
    NSString *soundfilename;
    switch (row) {
        case 0:
             soundfilename=@"jad0001a.wav"; 
            break;
        case 1:
             soundfilename=@"jad0002a.wav"; 
            break;
        case 2:
             soundfilename=@"jad0003a.wav"; 
            break;            
        default:
            break;
    }

   
    NSString *Path=[[NSBundle mainBundle] bundlePath];
    NSURL *soundfileURL=[NSURL fileURLWithPath:[Path stringByAppendingPathComponent:soundfilename]]; 
    
    //建立音效物件
    AudioServicesCreateSystemSoundID((CFURLRef)soundfileURL, &soundFileObject);
    
    //判斷是否連續播放
    if ([swcallback isOn]){
        // Add sound completion callback
        AudioServicesAddSystemSoundCompletion (soundFileObject, NULL, NULL,completionCallback,(void*) self);    
    }    
}

//當音效播放完畢後的處理方式，這裡設定為再一次播放
static void completionCallback (SystemSoundID  mySSID, void* myself) {
    AudioServicesPlaySystemSound(mySSID);    
} 

- (IBAction) playSystemSound{     
     [self GetPlaysound];
        AudioServicesPlaySystemSound (self.soundFileObject);    
  //  AudioServicesDisposeSystemSoundID (self.soundFileObject);
}

-(IBAction) playAlertSound{   
     [self GetPlaysound];
    //播放音效
    AudioServicesPlayAlertSound (self.soundFileObject);    
}
- (IBAction) vibrate{
    //震動
        AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
}

- (void)dealloc {
    [super dealloc];
    AudioServicesDisposeSystemSoundID (self.soundFileObject);
}
#pragma mark -
#pragma mark soundPicker Data Soure 
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [soundData count];
  }
#pragma mark -
#pragma mark soundPicker Delegate 
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [soundData objectAtIndex:row];
}
@end
