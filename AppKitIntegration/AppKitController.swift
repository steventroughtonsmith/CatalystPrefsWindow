/*
2021 Steven Troughton-Smith (@stroughtonsmith)
Provided as sample code to do with as you wish.
No license or attribution required.
*/

import AppKit

extension NSObject {
	@objc func hostWindowForSceneIdentifier(_ identifier:String) -> NSWindow? {
		return nil
	}
}

class AppKitController : NSObject {
	
	var preferencesSceneIdentifier:String?
	
	// MARK: -
	
	@objc public func _marzipan_setupWindow(_ note:Notification) {
		
		NSLog("_marzipan_setupWindow: \(String(describing: note.userInfo))")
		
		/*
		Here, AppKit has generated the host window for your UIKit window.
		Now it is safe to go do any AppKit-y things you'd like to do to it
		*/
		
		if let userInfo = note.userInfo, let sceneIdentifier = userInfo["SceneIdentifier"] as? String {
			if sceneIdentifier == preferencesSceneIdentifier {
				guard let appDelegate = NSApp.delegate as? NSObject else { return }
				
				if appDelegate.responds(to: #selector(hostWindowForSceneIdentifier(_:))) {
					guard let hostWindow = appDelegate.hostWindowForSceneIdentifier(sceneIdentifier) else { return }
					
					hostWindow.collectionBehavior = [.fullScreenAuxiliary]
					hostWindow.styleMask = [.closable, .titled]
				}
			}
		}
	}
	
	@objc public func configurePreferencesWindowForSceneIdentifier(_ sceneIdentifier:String) {
		preferencesSceneIdentifier = sceneIdentifier
	}
}
