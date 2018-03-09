//
//  AppDelegate.swift
//  RxSwift Example
//
//  Created by Owen Thomas on 3/8/18.
//  Copyright © 2018 Owen Thomas. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    // Shrink count periodically from app delegate to show that changes show up in the UI regardless of where the change is called from
    _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
      Model.singleton.decrease(1)
    }
    return true
  }
  
}

