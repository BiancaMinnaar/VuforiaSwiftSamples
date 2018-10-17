//
//  SwiftARManager.swift
//  VuforiaSampleSwift
//
//  Created by Bianca Minnaar on 2018/10/17.
//

import Foundation
//import Vuforia
class SwiftARManager{
    static var sharedSwiftARManager: SwiftARManager = {
        let swiftARManager = SwiftARManager()
        return swiftARManager
    }()
    
    init(){
        
    }
    
    class func shared() -> SwiftARManager{
        return sharedSwiftARManager;
    }
        

    /*
 NSString* _licenseKey;
 NSString* _dataSetFile;
 
 Vuforia::DataSet*  _dataSet;
 
 BOOL _isCameraActive;
 BOOL _isCameraStarted;
 BOOL _isRetinaDisplay;
 UIInterfaceOrientation _arViewOrientation;
 BOOL _isActivityInPortraitMode;
 
 BOOL _extendedTrackingEnabled;
 BOOL _continuousAutofocusEnabled;
 BOOL _flashEnabled;
 BOOL _frontCameraEnabled;
 
 Vuforia::Matrix44F _projectionMatrix;
 
 CGRect _viewport;
 
 VuforiaEAGLView* _eaglView;
 */
    var _licenseKey=""
    var _dataSetFile=""
    //var _dataSet:DataSet
}
