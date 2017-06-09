//
//  AppDelegate.swift
//  Thesis
//
//  Created by TriQuach on 4/2/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        do {
            let data = try String(contentsOfFile: "/Users/triquach/Documents/check.txt", encoding: .utf8)
            
            if (data == "true")
            {
                
                self.window = UIWindow(frame: UIScreen.main.bounds)
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                let initialViewController2 = storyboard.instantiateViewController(withIdentifier: "navi2")
                
                self.window?.rootViewController = initialViewController2
                
                self.window?.makeKeyAndVisible()
            }
            
            else
            {
                do {
                    let data = try String(contentsOfFile: "/Users/triquach/Documents/token.txt", encoding: .utf8)
                    
                    self.window = UIWindow(frame: UIScreen.main.bounds)
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    
                    let initialViewController2 = storyboard.instantiateViewController(withIdentifier: "navi")
                    
                    
                    
                    
                    //
                    
                    
                    
                    
                    self.window?.rootViewController = initialViewController2
                    
                    self.window?.makeKeyAndVisible()
                    
                    
                    
                    
                } catch {
                    //            print("2")
                    self.window = UIWindow(frame: UIScreen.main.bounds)
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    
                    let initialViewController = storyboard.instantiateViewController(withIdentifier: "navi2")
                    
                    self.window?.rootViewController = initialViewController
                    self.window?.makeKeyAndVisible()
                }
            }
            
            //
            
            
            
           
            
            
            
            
        } catch {
            
            print ("lol")
            do {
                let data = try String(contentsOfFile: "/Users/triquach/Documents/token.txt", encoding: .utf8)
                
                self.window = UIWindow(frame: UIScreen.main.bounds)
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                let initialViewController2 = storyboard.instantiateViewController(withIdentifier: "navi")
                
                
                
                
                //
                
                
                
                
                self.window?.rootViewController = initialViewController2
                
                self.window?.makeKeyAndVisible()
                
                
                
                
            } catch {
                //            print("2")
                self.window = UIWindow(frame: UIScreen.main.bounds)
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                let initialViewController = storyboard.instantiateViewController(withIdentifier: "navi3")
                
                self.window?.rootViewController = initialViewController
                self.window?.makeKeyAndVisible()
            }
            
        }
        
        
        
        
        
        
        
        
        
        
        var navigationBarAppearace = UINavigationBar.appearance()
        
        navigationBarAppearace.barStyle = UIBarStyle.black
        navigationBarAppearace.tintColor = UIColor.yellow
        return true
    }
    
    func parseJsonToken(token: String)
    {
        print ("1")
        
        let url = "http://rem-real-estate-manager.1d35.starter-us-east-1.openshiftapps.com/rem/rem_server/user/login/" + token
        print (url)
        let req = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
            
            do
            {
                
                let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as! AnyObject
                
                let typeId = json["typeId"] as! Int
                let id = json["id"] as! Int
                
                print (typeId)
                
                DispatchQueue.main.async {
                    
                    
                    
                }
            }catch{}
        }
        task.resume()
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
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

