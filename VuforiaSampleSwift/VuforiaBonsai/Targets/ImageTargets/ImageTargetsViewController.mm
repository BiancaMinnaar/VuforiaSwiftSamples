///*===============================================================================
//Copyright (c) 2016-2018 PTC Inc. All Rights Reserved.
//
//Copyright (c) 2012-2015 Qualcomm Connected Experiences, Inc. All Rights Reserved.
//
//Vuforia is a trademark of PTC Inc., registered in the United States and other 
//countries.
//===============================================================================*/
//
//#import "ImageTargetsViewController.h"
//#import "VuforiaSamplesAppDelegate.h"
//#import <Vuforia/Vuforia.h>
//#import <Vuforia/TrackerManager.h>
//#import <Vuforia/ObjectTracker.h>
//#import <Vuforia/PositionalDeviceTracker.h>
//#import <Vuforia/Trackable.h>
//#import <Vuforia/DataSet.h>
//#import <Vuforia/CameraDevice.h>
//
//#import "UnwindMenuSegue.h"
//#import "PresentMenuSegue.h"
//#import "SampleAppMenuViewController.h"
//
//@interface ImageTargetsViewController ()
//
//@property (weak, nonatomic) IBOutlet UIImageView *ARViewPlaceholder;
//
//@end
//
//@implementation ImageTargetsViewController
//
//@synthesize tapGestureRecognizer, vapp, eaglView;
//
//
//- (CGRect)getCurrentARViewFrame
//{
//    CGRect screenBounds = [[UIScreen mainScreen] bounds];
//    return screenBounds;
//}
//
//- (void)loadView
//{
//    // Custom initialization
//    self.title = @"Image Targets";
//    
//    if (self.ARViewPlaceholder != nil) {
//        [self.ARViewPlaceholder removeFromSuperview];
//        self.ARViewPlaceholder = nil;
//    }
//    
//    deviceTrackerEnabled = NO;
//    continuousAutofocusEnabled = YES;
//    flashEnabled = NO;
//    
//    vapp = [[SampleApplicationSession alloc] initWithDelegate:self];
//    
//    CGRect viewFrame = [self getCurrentARViewFrame];
//    
//    eaglView = [[ImageTargetsEAGLView alloc] initWithFrame:viewFrame appSession:vapp];
//    [eaglView setBackgroundColor:UIColor.clearColor];
//    
//    
//    [self setView:eaglView];
//    VuforiaSamplesAppDelegate *appDelegate = (VuforiaSamplesAppDelegate*)[[UIApplication sharedApplication] delegate];
//    appDelegate.glResourceHandler = eaglView;
//    
//    // double tap used to also trigger the menu
//    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(doubleTapGestureAction:)];
//    doubleTap.numberOfTapsRequired = 2;
//    [self.view addGestureRecognizer:doubleTap];
//    
//    // a single tap will trigger a single autofocus operation
//    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(autofocus:)];
//    if (doubleTap != NULL) {
//        [tapGestureRecognizer requireGestureRecognizerToFail:doubleTap];
//    }
//    
//    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureAction:)];
//    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
//    [self.view addGestureRecognizer:swipeRight];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(dismissARViewController)
//                                                 name:@"kDismissARViewController"
//                                               object:nil];
//    
//    // we use the iOS notification to pause/resume the AR when the application goes (or come back from) background
//    [[NSNotificationCenter defaultCenter]
//     addObserver:self
//     selector:@selector(pauseAR)
//     name:UIApplicationWillResignActiveNotification
//     object:nil];
//    
//    [[NSNotificationCenter defaultCenter]
//     addObserver:self
//     selector:@selector(resumeAR)
//     name:UIApplicationDidBecomeActiveNotification
//     object:nil];
//    
//    // initialize AR
//    [vapp initAR:Vuforia::GL_20 orientation:[[UIApplication sharedApplication] statusBarOrientation] deviceMode:Vuforia::Device::MODE_AR stereo:false];
//
//    // show loading animation while AR is being initialized
//    [self showLoadingAnimation];
//}
//
//- (void) pauseAR {
//    NSError * error = nil;
//    if (![vapp pauseAR:&error]) {
//        NSLog(@"Error pausing AR:%@", [error description]);
//    }
//}
//
//- (void) resumeAR {
//    NSError * error = nil;
//    if(! [vapp resumeAR:&error]) {
//        NSLog(@"Error resuming AR:%@", [error description]);
//    }
//    [eaglView updateRenderingPrimitives];
//    // on resume, we reset the flash
//    Vuforia::CameraDevice::getInstance().setFlashTorchMode(false);
//    flashEnabled = NO;
//}
//
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    
//    self.showingMenu = NO;
//    
//    // Do any additional setup after loading the view.
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
//    [self.view addGestureRecognizer:tapGestureRecognizer];
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    // on iOS 7, viewWillDisappear may be called when the menu is shown
//    // but we don't want to stop the AR view in that case
//    if (self.showingMenu) {
//        return;
//    }
//    
//    [vapp stopAR:nil];
//    
//    // Be a good OpenGL ES citizen: now that Vuforia is paused and the render
//    // thread is not executing, inform the root view controller that the
//    // EAGLView should finish any OpenGL ES commands
//    [self finishOpenGLESCommands];
//    
//    VuforiaSamplesAppDelegate *appDelegate = (VuforiaSamplesAppDelegate*)[[UIApplication sharedApplication] delegate];
//    appDelegate.glResourceHandler = nil;
//    
//    [super viewWillDisappear:animated];
//}
//
//- (void)dealloc
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
//
//- (void)finishOpenGLESCommands
//{
//    // Called in response to applicationWillResignActive.  Inform the EAGLView
//    [eaglView finishOpenGLESCommands];
//}
//
//- (void)freeOpenGLESResources
//{
//    // Called in response to applicationDidEnterBackground.  Inform the EAGLView
//    [eaglView freeOpenGLESResources];
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//
//#pragma mark - loading animation
//
//- (void) showLoadingAnimation {
//    CGRect indicatorBounds;
//    CGRect mainBounds = [[UIScreen mainScreen] bounds];
//    int smallerBoundsSize = MIN(mainBounds.size.width, mainBounds.size.height);
//    int largerBoundsSize = MAX(mainBounds.size.width, mainBounds.size.height);
//    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
//    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown ) {
//        indicatorBounds = CGRectMake(smallerBoundsSize / 2 - 12,
//                                     largerBoundsSize / 2 - 12, 24, 24);
//    }
//    else {
//        indicatorBounds = CGRectMake(largerBoundsSize / 2 - 12,
//                                     smallerBoundsSize / 2 - 12, 24, 24);
//    }
//    
//    UIActivityIndicatorView *loadingIndicator = [[UIActivityIndicatorView alloc]
//                                                  initWithFrame:indicatorBounds];
//    
//    loadingIndicator.tag  = 1;
//    loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
//    [eaglView addSubview:loadingIndicator];
//    [loadingIndicator startAnimating];
//}
//
//- (void) hideLoadingAnimation {
//    UIActivityIndicatorView *loadingIndicator = (UIActivityIndicatorView *)[eaglView viewWithTag:1];
//    [loadingIndicator removeFromSuperview];
//}
//
//
//#pragma mark - SampleApplicationControl
//
//// Initialize the application trackers
//- (bool) doInitTrackers
//{
//    // To get the best performance for the DeviceTracker in this application
//    // we ensure that the most optimal fusion provider is being used.
//    // For ImageTargets, the recommended fusion provider mode is
//    // the FUSION_OPTIMIZE_IMAGE_TARGETS_AND_VUMARKS enum
//    if (![vapp setFusionProviderType:Vuforia::FUSION_PROVIDER_TYPE::FUSION_OPTIMIZE_IMAGE_TARGETS_AND_VUMARKS])
//    {
//        return NO;
//    }
//    
//    Vuforia::TrackerManager& trackerManager = Vuforia::TrackerManager::getInstance();
//    
//    // Initialize the object tracker
//    Vuforia::Tracker* objectTracker = trackerManager.initTracker(Vuforia::ObjectTracker::getClassType());
//    if (objectTracker == nullptr)
//    {
//        NSLog(@"Failed to initialize ObjectTracker.");
//        return false;
//    }
//    
//    // Initialize the device tracker
//    Vuforia::Tracker* deviceTracker = trackerManager.initTracker(Vuforia::PositionalDeviceTracker::getClassType());
//    if (deviceTracker == nullptr)
//    {
//        NSLog(@"Failed to initialize DeviceTracker.");
//    }
//    
//    NSLog(@"Initialized trackers");
//    return true;
//}
//
//// load the data associated to the trackers
//- (bool) doLoadTrackersData {
//    dataSetStonesAndChips = [self loadObjectTrackerDataSet:@"StonesAndChips.xml"];
//    dataSetTarmac = [self loadObjectTrackerDataSet:@"Tarmac.xml"];
//    if ((dataSetStonesAndChips == NULL) || (dataSetTarmac == NULL)) {
//        NSLog(@"Failed to load datasets");
//        return false;
//    }
//    if (! [self activateDataSet:dataSetStonesAndChips]) {
//        NSLog(@"Failed to activate dataset");
//        return false;
//    }
//    
//    
//    return true;
//}
//
//// start the application trackers
//- (bool) doStartTrackers
//{
//    Vuforia::TrackerManager& trackerManager = Vuforia::TrackerManager::getInstance();
//    
//    // Start object tracker
//    Vuforia::Tracker* objectTracker = trackerManager.getTracker(Vuforia::ObjectTracker::getClassType());
//    
//    if(objectTracker != nullptr && objectTracker->start())
//    {
//        NSLog(@"Successfully started object tracker");
//    }
//    else
//    {
//        NSLog(@"ERROR: Failed to start object tracker");
//        return false;
//    }
//    
//    // Start device tracker if enabled
//    if (deviceTrackerEnabled)
//    {
//        [self setDeviceTrackerEnabled:YES];
//    }
//    
//    return true;
//}
//
//// callback called when the initailization of the AR is done
//- (void) onInitARDone:(NSError *)initError {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        UIActivityIndicatorView *loadingIndicator = (UIActivityIndicatorView *)[self->eaglView viewWithTag:1];
//        [loadingIndicator removeFromSuperview];
//    });
//    
//    if (initError == nil) {
//        NSError * error = nil;
//        [vapp startAR:Vuforia::CameraDevice::CAMERA_DIRECTION_BACK error:&error];
//        
//        [eaglView updateRenderingPrimitives];
//
//        // by default, we try to set the continuous auto focus mode
//        continuousAutofocusEnabled = Vuforia::CameraDevice::getInstance().setFocusMode(Vuforia::CameraDevice::FOCUS_MODE_CONTINUOUSAUTO);
//
//        //[eaglView configureBackground];
//
//    } else {
//        NSLog(@"Error initializing AR:%@", [initError description]);
//        dispatch_async( dispatch_get_main_queue(), ^{
//            
//            UIAlertController *uiAlertController =
//            [UIAlertController alertControllerWithTitle:@"Error"
//                                                message:[initError localizedDescription]
//                                         preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *defaultAction =
//            [UIAlertAction actionWithTitle:@"OK"
//                                     style:UIAlertActionStyleDefault
//                                   handler:^(UIAlertAction *action) {
//                                       [[NSNotificationCenter defaultCenter] postNotificationName:@"kDismissARViewController" object:nil];
//                                   }];
//            
//            [uiAlertController addAction:defaultAction];
//            [self presentViewController:uiAlertController animated:YES completion:nil];
//        });
//    }
//}
//
//- (void)dismissARViewController
//{
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    [self.navigationController popToRootViewControllerAnimated:NO];
//}
//
//- (void)configureVideoBackgroundWithViewWidth:(float)viewWidth andHeight:(float)viewHeight
//{
//    [eaglView configureVideoBackgroundWithViewWidth:(float)viewWidth andHeight:(float)viewHeight];
//}
//
//- (void) onVuforiaUpdate: (Vuforia::State *) state
//{
//    if (switchToTarmac) {
//        [self activateDataSet:dataSetTarmac];
//        switchToTarmac = NO;
//    }
//    if (switchToStonesAndChips) {
//        [self activateDataSet:dataSetStonesAndChips];
//        switchToStonesAndChips = NO;
//    }
//}
//
//// Load the image tracker data set
//- (Vuforia::DataSet *)loadObjectTrackerDataSet:(NSString*)dataFile
//{
//    NSLog(@"loadObjectTrackerDataSet (%@)", dataFile);
//    Vuforia::DataSet * dataSet = NULL;
//    
//    // Get the Vuforia tracker manager image tracker
//    Vuforia::TrackerManager& trackerManager = Vuforia::TrackerManager::getInstance();
//    Vuforia::ObjectTracker* objectTracker = static_cast<Vuforia::ObjectTracker*>(trackerManager.getTracker(Vuforia::ObjectTracker::getClassType()));
//    
//    if (NULL == objectTracker) {
//        NSLog(@"ERROR: failed to get the ObjectTracker from the tracker manager");
//        return NULL;
//    } else {
//        dataSet = objectTracker->createDataSet();
//        
//        if (NULL != dataSet) {
//            NSLog(@"INFO: successfully loaded data set");
//            
//            // Load the data set from the app's resources location
//            if (!dataSet->load([dataFile cStringUsingEncoding:NSASCIIStringEncoding], Vuforia::STORAGE_APPRESOURCE)) {
//                NSLog(@"ERROR: failed to load data set");
//                objectTracker->destroyDataSet(dataSet);
//                dataSet = NULL;
//            }
//        }
//        else {
//            NSLog(@"ERROR: failed to create data set");
//        }
//    }
//    
//    return dataSet;
//}
//
//
//- (bool) doStopTrackers
//{
//    Vuforia::TrackerManager& trackerManager = Vuforia::TrackerManager::getInstance();
//    
//    // Stop the object tracker
//    Vuforia::Tracker* objectTracker = trackerManager.getTracker(Vuforia::ObjectTracker::getClassType());
//    
//    if (objectTracker != nullptr)
//    {
//        objectTracker->stop();
//        NSLog(@"INFO: successfully stopped object tracker");
//    }
//    else
//    {
//        NSLog(@"ERROR: failed to get the object tracker from the tracker manager");
//    }
//    
//    // Stop the device tracker
//    if(deviceTrackerEnabled)
//    {
//        Vuforia::Tracker* deviceTracker = trackerManager.getTracker(Vuforia::PositionalDeviceTracker::getClassType());
//        
//        if (deviceTracker != nullptr)
//        {
//            deviceTracker->stop();
//            NSLog(@"INFO: successfully stopped devicetracker");
//        }
//        else
//        {
//            NSLog(@"ERROR: failed to stop the device tracker");
//        }
//    }
//    
//    return true;
//}
//
//- (bool) doUnloadTrackersData {
//    [self deactivateDataSet: dataSetCurrent];
//    dataSetCurrent = nil;
//    
//    // Get the image tracker:
//    Vuforia::TrackerManager& trackerManager = Vuforia::TrackerManager::getInstance();
//    Vuforia::ObjectTracker* objectTracker = static_cast<Vuforia::ObjectTracker*>(trackerManager.getTracker(Vuforia::ObjectTracker::getClassType()));
//    
//    // Destroy the data sets:
//    if (!objectTracker->destroyDataSet(dataSetTarmac))
//    {
//        NSLog(@"Failed to destroy data set Tarmac.");
//    }
//    if (!objectTracker->destroyDataSet(dataSetStonesAndChips))
//    {
//        NSLog(@"Failed to destroy data set Stones and Chips.");
//    }
//    
//    NSLog(@"datasets destroyed");
//    return true;
//}
//
//- (BOOL)activateDataSet:(Vuforia::DataSet *)theDataSet
//{
//    // if we've previously recorded an activation, deactivate it
//    if (dataSetCurrent != nil)
//    {
//        [self deactivateDataSet:dataSetCurrent];
//    }
//    BOOL success = NO;
//    
//    // Get the image tracker:
//    Vuforia::TrackerManager& trackerManager = Vuforia::TrackerManager::getInstance();
//    Vuforia::ObjectTracker* objectTracker = static_cast<Vuforia::ObjectTracker*>(trackerManager.getTracker(Vuforia::ObjectTracker::getClassType()));
//    
//    if (objectTracker == NULL) {
//        NSLog(@"Failed to load tracking data set because the ObjectTracker has not been initialized.");
//    }
//    else
//    {
//        // Activate the data set:
//        if (!objectTracker->activateDataSet(theDataSet))
//        {
//            NSLog(@"Failed to activate data set.");
//        }
//        else
//        {
//            NSLog(@"Successfully activated data set.");
//            dataSetCurrent = theDataSet;
//            success = YES;
//        }
//    }
//    
//    return success;
//}
//
//- (BOOL)deactivateDataSet:(Vuforia::DataSet *)theDataSet
//{
//    if ((dataSetCurrent == nil) || (theDataSet != dataSetCurrent))
//    {
//        NSLog(@"Invalid request to deactivate data set.");
//        return NO;
//    }
//    
//    BOOL success = NO;
//    
//    // Get the image tracker:
//    Vuforia::TrackerManager& trackerManager = Vuforia::TrackerManager::getInstance();
//    Vuforia::ObjectTracker* objectTracker = static_cast<Vuforia::ObjectTracker*>(trackerManager.getTracker(Vuforia::ObjectTracker::getClassType()));
//    
//    if (objectTracker == NULL)
//    {
//        NSLog(@"Failed to unload tracking data set because the ObjectTracker has not been initialized.");
//    }
//    else
//    {
//        // Activate the data set:
//        if (!objectTracker->deactivateDataSet(theDataSet))
//        {
//            NSLog(@"Failed to deactivate data set.");
//        }
//        else
//        {
//            success = YES;
//        }
//    }
//    
//    dataSetCurrent = nil;
//    
//    return success;
//}
//
//- (BOOL) setDeviceTrackerEnabled:(BOOL) enable
//{
//    BOOL result = YES;
//    
//    Vuforia::PositionalDeviceTracker* deviceTracker = static_cast<Vuforia::PositionalDeviceTracker*>(                                 Vuforia::TrackerManager::getInstance()
//            .getTracker(Vuforia::PositionalDeviceTracker::getClassType()));
//    
//    if (deviceTracker == NULL)
//    {
//        NSLog(@"ERROR: Could not toggle device tracker state");
//        return NO;
//    }
//    
//    if (enable)
//    {
//        if (deviceTracker->start())
//        {
//            NSLog(@"Successfully started device tracker");
//        }
//        else
//        {
//            result = NO;
//            NSLog(@"Failed to start device tracker");
//        }
//    }
//    else
//    {
//        deviceTracker->stop();
//        NSLog(@"Successfully stopped device tracker");
//    }
//    
//    if (result)
//    {
//        [eaglView setOffTargetTrackingMode:enable];
//    }
//    
//    return result;
//}
//
//- (bool) doDeinitTrackers
//{
//    Vuforia::TrackerManager& trackerManager = Vuforia::TrackerManager::getInstance();
//    trackerManager.deinitTracker(Vuforia::ObjectTracker::getClassType());
//    trackerManager.deinitTracker(Vuforia::PositionalDeviceTracker::getClassType());
//    return true;
//}
//
//- (void)autofocus:(UITapGestureRecognizer *)sender
//{
//    [self performSelector:@selector(cameraPerformAutoFocus) withObject:nil afterDelay:.4];
//}
//
//- (void)cameraPerformAutoFocus
//{
//    Vuforia::CameraDevice::getInstance().setFocusMode(Vuforia::CameraDevice::FOCUS_MODE_TRIGGERAUTO);
//    
//    // After triggering an autofocus event,
//    // we must restore the previous focus mode
//    if (continuousAutofocusEnabled)
//    {
//        [self performSelector:@selector(restoreContinuousAutoFocus) withObject:nil afterDelay:2.0];
//    }
//}
//
//- (void)restoreContinuousAutoFocus
//{
//    Vuforia::CameraDevice::getInstance().setFocusMode(Vuforia::CameraDevice::FOCUS_MODE_CONTINUOUSAUTO);
//}
//
//- (void)doubleTapGestureAction:(UITapGestureRecognizer*)theGesture
//{
//    if (!self.showingMenu) {
//        [self performSegueWithIdentifier: @"PresentMenu" sender: self];
//    }
//}
//
//- (void)swipeGestureAction:(UISwipeGestureRecognizer*)gesture
//{
//    if (!self.showingMenu) {
//        [self performSegueWithIdentifier:@"PresentMenu" sender:self];
//    }
//}
//
//
//#pragma mark - menu delegate protocol implementation
//
//- (BOOL) menuProcess:(NSString *)itemName value:(BOOL)value
//{
//    if ([@"Flash" isEqualToString:itemName]) {
//        BOOL result = Vuforia::CameraDevice::getInstance().setFlashTorchMode(value);
//        flashEnabled = value && result;
//        return result;
//    }
//    else if ([@"Device Tracker" isEqualToString:itemName]) {
//        BOOL result = [self setDeviceTrackerEnabled:value];
//        
//        deviceTrackerEnabled = value && result;
//        return result;
//    }
//    else if ([@"Autofocus" isEqualToString:itemName]) {
//        int focusMode = value ? Vuforia::CameraDevice::FOCUS_MODE_CONTINUOUSAUTO : Vuforia::CameraDevice::FOCUS_MODE_NORMAL;
//        BOOL result = Vuforia::CameraDevice::getInstance().setFocusMode(focusMode);
//        continuousAutofocusEnabled = value && result;
//        return result;
//    }
//    else if ([@"Tarmac" isEqualToString:itemName])
//    {
//        switchToTarmac = YES;
//        switchToStonesAndChips = NO;
//        return YES;
//    }
//    else if ([@"Stones & Chips" isEqualToString:itemName])
//    {
//        switchToTarmac = NO;
//        switchToStonesAndChips = YES;
//        return YES;
//    }
//
//    return NO;
//}
//
//- (void) menuDidExit
//{
//    self.showingMenu = NO;
//}
//
//
//#pragma mark - Navigation
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue isKindOfClass:[PresentMenuSegue class]]) {
//        UIViewController *dest = [segue destinationViewController];
//        if ([dest isKindOfClass:[SampleAppMenuViewController class]]) {
//            self.showingMenu = YES;
//            
//            SampleAppMenuViewController *menuVC = (SampleAppMenuViewController *)dest;
//            menuVC.menuDelegate = self;
//            menuVC.sampleAppFeatureName = @"Image Targets";
//            menuVC.dismissItemName = @"Vuforia Samples";
//            menuVC.backSegueId = @"BackToImageTargets";
//            
//            NSLog(@"Dataset current %@", dataSetCurrent == dataSetTarmac ? @"Tarmac" : @"Stones & Chips");
//            
//            // initialize menu item values (ON / OFF)
//            [menuVC setValue:deviceTrackerEnabled forMenuItem:@"Device Tracker"];
//            [menuVC setValue:continuousAutofocusEnabled forMenuItem:@"Autofocus"];
//            [menuVC setValue:flashEnabled forMenuItem:@"Flash"];
//            if (dataSetCurrent == dataSetStonesAndChips) {
//                [menuVC setValue:YES forMenuItem:@"Stones & Chips"];
//                [menuVC setValue:NO forMenuItem:@"Tarmac"];
//            }
//            else {
//                [menuVC setValue:YES forMenuItem:@"Tarmac"];
//                [menuVC setValue:NO forMenuItem:@"Stones & Chips"];
//            }
//        }
//    }
//}
//
//@end
