//
//  AppDelegate.swift
//  PhotoFeed_NSUserDefaults
//
//  Created by nhp on 8/13/19.
//  Copyright © 2019 nhp. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UserDefaults.standard.register(defaults: ["PhotoURLString":"https://api.flickr.com/services/feeds/photos_public.gne?tags=kitten&format=json&nojsoncallback=1"])
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        let urlString = UserDefaults.standard.string(forKey: "PhotoURLString")
        print(urlString as Any)
        guard let foundURLString = urlString else {
            return
        }
        
        if let url = NSURL(string: foundURLString) {
            self.updateFeed(url: url, completion: { (feed) -> Void in
                let viewController = application.windows[0].rootViewController as? ImageFeedTableViewController
                viewController?.feed = feed
            })
        }

        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    /*
    // use the local resource
    func updateFeed(url:NSURL, completion: (_ feed : Feed?) -> Void) {
        let dataFile = Bundle.main.url(forResource: "photos_public.gne", withExtension: ".json")
        let data = NSData(contentsOf: dataFile!)
        let feed = Feed(data: data!, sourceURL: url)
        completion(feed)
        
    }
    */
    
    func updateFeed(url: NSURL, completion: @escaping (_ feed: Feed?) -> Void) {
        let request = NSURLRequest(url: url as URL)
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if error == nil && data != nil {
                let feed = Feed(data: data! as NSData, sourceURL: url)
                OperationQueue.main.addOperation({ () -> Void in
                    completion(feed)
                })
            }
            
        }
        
        task.resume()
    }
    
    
}

