import UIKit
import Foundation
import ObjectiveC

typealias UIControlActionBlock = Void -> Void

@objc class UIControlBlockActionBox : NSObject
{
	let blockAction:UIControlActionBlock
	
	init(blockAction:UIControlActionBlock) {
		self.blockAction = blockAction;
	}
	
	func invokeBlock(sender:AnyObject?) {
		self.blockAction();
	}
}

private var xoAssociationKey: UInt8 = 0

extension UIControl {
	
	private var actionSelector:Selector {
		get {
			return "invokeBlock:"
		}
	}
	
	private var actions:NSMutableDictionary {
		get {
			guard let dictionary = objc_getAssociatedObject(self, &xoAssociationKey) as? NSMutableDictionary else {
				let dictionary = NSMutableDictionary()
				objc_setAssociatedObject(self, &xoAssociationKey, dictionary, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
				return dictionary
			}
			return dictionary
		}
		set(newValue) {
			objc_setAssociatedObject(self, &xoAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
		}
	}
	
	func addEventHandler(controlEvents:UIControlEvents, handler:UIControlActionBlock) -> Int {
		let handlerKey = Int(NSDate().timeIntervalSince1970)
		let target = UIControlBlockActionBox(blockAction: handler)
		self.actions[handlerKey] = target
		self.addTarget(target, action: self.actionSelector, forControlEvents: .TouchUpInside)
		return handlerKey
	}
	
	func removeEventHandler(handlerId handlerId:Int) {
		self.actions.removeObjectForKey(handlerId)
	}
	
	func updateEventHandler(handlerId handlerId:Int, handler:UIControlActionBlock) {
		guard let oldHandler = self.actions[handlerId] else {
			return
		}
		self.removeTarget(oldHandler, action: self.actionSelector, forControlEvents: .TouchUpInside)
		let newHandler = UIControlBlockActionBox(blockAction: handler)
		self.actions[handlerId] = newHandler
		self.addTarget(newHandler, action: self.actionSelector, forControlEvents: .TouchUpInside)
	}
}

let button = UIButton(type: .System)
let handlerId = button.addEventHandler(.TouchUpInside) {
	print("1 - Hi")
}
button.sendActionsForControlEvents(.TouchUpInside)
button.updateEventHandler(handlerId: handlerId) {
	print("2 - Hey")
}
button.sendActionsForControlEvents(.TouchUpInside)
button.removeEventHandler(handlerId: handlerId)
button.sendActionsForControlEvents(.TouchUpInside)

