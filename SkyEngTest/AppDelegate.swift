//
//  AppDelegate.swift
//  SkyEngTest
//
//  Created by Svyatoslav Ivanov on 27.01.2021.
//

import UIKit
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private var appCoordinator: AppCoordinator!
    static let container = Container()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Container.loggingFunction = nil
        AppDelegate.container.registerDependencies()
        
        self.appCoordinator = AppDelegate.container.resolve(AppCoordinator.self)
        self.appCoordinator.start()
        
        return true
    }
}


