//
//  AppDelegate.swift
//  Advent Calendar
//
//  Created by Adeel Qayum on 10/24/18.
//  Copyright © 2018 Adeel Qayum. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var calendar: Calendar!
    var mediaLibraryFileName = "MediaTrackerFile"
    
    lazy var fileURL: URL = {
        let documentsDir =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDir.appendingPathComponent(mediaLibraryFileName, isDirectory: false)
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        loadData()
        
        if let navController = window?.rootViewController as? UINavigationController {
            if let mainViewController = navController.viewControllers.last as? ViewController {
                mainViewController.calendar = calendar
            }
        }
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        saveData()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) { }
    
    func applicationWillEnterForeground(_ application: UIApplication) { }
    
    func applicationDidBecomeActive(_ application: UIApplication) { }
    
    func applicationWillTerminate(_ application: UIApplication) {
        saveData()
    }
    
    // MARK - Persistence Methods
    
    func saveData() {
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(at: fileURL)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
        
        if let encodedData = try? JSONEncoder().encode(calendar) {
            FileManager.default.createFile(atPath: fileURL.path, contents: encodedData, attributes: nil)
        } else {
            fatalError("Couldn't write data!")
        }
    }
    
    func loadData() {
        
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            calendar = Calendar()
            return
        }
        
        if let jsondata = FileManager.default.contents(atPath: fileURL.path) {
            let decoder = JSONDecoder()
            do {
                let model = try decoder.decode(Calendar.self, from: jsondata)
                calendar = model
            } catch {
                fatalError(error.localizedDescription)
            }
        } else {
            fatalError("No data at \(fileURL.path)!")
        }
    }
}

