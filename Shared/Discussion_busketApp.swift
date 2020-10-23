//
//  Discussion_busketApp.swift
//  Shared
//
//  Created by Alexander Romanov on 30.08.2020.
//

import SwiftUI
import Firebase
import M7Native
import M7NativeFirebase
import FirebaseFirestore
import FirebaseFirestoreSwift

@main
struct Discussion_busketApp {
    
    static func main() {
        
        _ = M7Info(privacyPolicyUrl: "http://google.com",
               termsOfUseUrl: "http://google.com",
               iconName: "icon",
               supportUrl: "http://google.com",
               facebookMessengerChatUrl: "http://google.com",
               telegramChatUrl: "http://google.com",
               appStoreUrl: "http://google.com")
        
        _ = M7Info(name: "Alexander Romanov",
                   email: "aromanov07@gmail.com",
                   url: "https://romanov.cc/",
                   appStoreUrl: "https://apps.apple.com/ru/developer/alexander-romanov/id1459928735",
                   telegramAccountUrl: "https://t.me/aromanov91",
                   facebookAccountUrl: "https://www.facebook.com/aromanov91")
        
        if #available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *) {
            
            SwiftUIApp.main()
        }
//        } else {
//            #if os(iOS) // iOS 13.0 or lower
//            UIApplicationMain(CommandLine.argc,
//                              CommandLine.unsafeArgv,
//                              nil,
//                              NSStringFromClass(AppDelegate.self))
//            #else
//            print("This app doesn't run (yet) on this OS, so Bye")
//            return
//            #endif
//        }
    }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
struct SwiftUIApp: App {

//    init() {
//        FirebaseApp.configure()
//      }

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        return WindowGroup {

            #if os(macOS)
            MacRoot().frame(minWidth: 100, idealWidth: 300, maxWidth: .infinity, minHeight: 100, idealHeight: 200, maxHeight: .infinity)
            #else


            iOSRoot().environmentObject(M7SettingsStore()).environmentObject(M7AuthModel()).environmentObject(AuthenticationService()).environmentObject(LeftViewModel())
                .onOpenURL(perform: { url in

                                    Auth.auth().canHandle(url)
                                })
            #endif
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        let _ = Firestore.firestore()
        return true
    }
    
    // Its Also Should Be Implemeted...
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
    }
    
    
}
//
//#if os(iOS)
//import UIKit
//// @UIApplicationMain <- remove that!
//class AppDelegate: UIResponder, UIApplicationDelegate {
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Override point for customization after application launch.
//
//
//
//            FirebaseApp.configure()
//
//
//
//        print("AppDelegate didFinishLaunchingWithOptions")
//
//        return true
//    }
//
//    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//}
//
//class SceneDelegate: UIResponder, UIWindowSceneDelegate {
//
//    var window: UIWindow?
//
//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//
//        print("SceneDelegate")
//
//        let contentView = iOSRoot()
//
//        if let windowScene = scene as? UIWindowScene {
//            let window = UIWindow(windowScene: windowScene)
//            window.rootViewController = UIHostingController(rootView: contentView)
//            self.window = window
//            window.makeKeyAndVisible()
//        }
//    }
//
//}
//#endif
