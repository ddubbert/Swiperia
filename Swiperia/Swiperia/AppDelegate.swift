//
//  AppDelegate.swift
//  GlobeNew
//
//  Created by Dennis Dubbert on 02.08.17.
//  Copyright © 2017 Dennis Dubbert. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var test = "bin in der AppDelegate"
    
    
    private let gameModes = GameManager()
    private var games : [Game] = []
    
    private var settingsDefaults : [String : Any?] = ["music" : true, "sounds" : true, "rumble" : true, "language" : "english", "posColor" : UIColor.orange, "negColor" : UIColor.red, "userName" : nil, "userImage" : #imageLiteral(resourceName: "profileUnknown"), "userBanner" : #imageLiteral(resourceName: "defaultBanner")]
    private var singlePlayerDefaults = [String : Any]()
    private var multiPlayerDefaults = [String : Any]()
    //private var testDefaults = [String : Any]()

    
    var settings = [String : Any]()
    var singlePlayerScores = [String: Any]()
    var multiPlayerData = [String : Any]()
    
    //var multiplayerEnemies = [String:Any]()
    //var testData = [String : Any]()
    var enemyData = [String: Any]()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 11)!, NSForegroundColorAttributeName: UIColor.white], for: UIControlState.normal)
        
        UITabBar.appearance().tintColor = UIColor.white
        
        
        //print(UserDefaults.standard.getData(forKey: "swiperiaSettings"))
        if (UserDefaults.standard.object(forKey: "swiperiaSettings") != nil) {
            print("Settings vorhanden.")
            settings = UserDefaults.standard.getData(forKey: "swiperiaSettings")
        } else {
            print("Settings nicht vorhanden, Standard UserDefaults werden angelegt.")

            // SettingsDefaults in die UserDefaults überführen
            settings = settingsDefaults
        }
        
        if (UserDefaults.standard.object(forKey: "swiperiaSinglePlayer") != nil) {
            print("Singleplayer vorhanden.")
            singlePlayerScores = UserDefaults.standard.getData(forKey: "swiperiaSinglePlayer")
        } else {
            print("Singleplayer nicht vorhanden, Standard UserDefaults werden angelegt.")

            // SinglePlayerDefaults in die UserDefaults überführen
            games = gameModes.getSpecificGameModes(for: .single)
            for game in games {
                var spDefaults = [String : Any]()
                spDefaults["image"] = game.imageName
                spDefaults["score"] = Double(0)
                singlePlayerDefaults[game.name] = spDefaults
            }
            
            singlePlayerScores = singlePlayerDefaults
        }
        
        if (UserDefaults.standard.object(forKey: "swiperiaMultiPlayer") != nil) {
            print("Multiplayer vorhanden.")
            multiPlayerData = UserDefaults.standard.getData(forKey: "swiperiaMultiPlayer")
        } else {
            print("Multiplayer nicht vorhanden, Standard UserDefaults werden angelegt.")
            // MultiPlayerDefaults in die UserDefaults überführen
            games = gameModes.getSpecificGameModes(for: .multi)
            for game in games {
                var mpDefaults = [String : Any]()
                mpDefaults["image"] = game.imageName
                mpDefaults["opponents"] = [String]()
                multiPlayerDefaults[game.name] = mpDefaults
            }
            multiPlayerData = multiPlayerDefaults
        }
        
        /*if (UserDefaults.standard.object(forKey: "testData") != nil) {
            print("testData vorhanden.")
            testData = UserDefaults.standard.getData(forKey: "testData")
            print(testData)
        } else {
            print("testData nicht vorhanden, Standard UserDefaults werden angelegt.")
            // MultiPlayerDefaults in die UserDefaults überführen
            games = gameModes.getSpecificGameModes(for: .multi)
            
            for game in games {
                var mpDefaults = [String : Any]()
                mpDefaults["image"] = game.imageName
                mpDefaults["opponents"] = ["rosadoener " + game.name, "eddie " + game.name]
                testDefaults[game.name] = mpDefaults
            }
            testData = testDefaults
            print(testData)
            UserDefaults.standard.setData(dictionaryData: testData, forKey: "testData")
        }*/
        
        if (UserDefaults.standard.object(forKey: "enemyData") != nil) {
            print("enemieData vorhanden.")
            enemyData = UserDefaults.standard.getData(forKey: "enemyData")
        } else {
            enemyData = [String: Any]()
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.pauseNotification), object: nil)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print("Background")
        UserDefaults.standard.setData(dictionaryData: settings, forKey: "swiperiaSettings")
        UserDefaults.standard.setData(dictionaryData: singlePlayerScores, forKey: "swiperiaSinglePlayer")
        print(singlePlayerScores)
        
        UserDefaults.standard.setData(dictionaryData: multiPlayerData, forKey: "swiperiaMultiPlayer")
        print(multiPlayerData)
        
        UserDefaults.standard.setData(dictionaryData: enemyData, forKey: "enemyData")
        print(enemyData)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        print("Terminate")
        
        UserDefaults.standard.setData(dictionaryData: settings, forKey: "swiperiaSettings")
        UserDefaults.standard.setData(dictionaryData: singlePlayerScores, forKey: "swiperiaSinglePlayer")
        print(singlePlayerScores)

        UserDefaults.standard.setData(dictionaryData: multiPlayerData, forKey: "swiperiaMultiPlayer")
        print(multiPlayerData)

        UserDefaults.standard.setData(dictionaryData: enemyData, forKey: "enemyData")
        print(enemyData)

    }


}

