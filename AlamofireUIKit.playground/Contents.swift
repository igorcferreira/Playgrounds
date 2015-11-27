//: Playground - noun: a place where people can play

import UIKit
import XCPlayground
import Alamofire

let page = XCPlaygroundPage.currentPage
page.needsIndefiniteExecution = true

func downloadContent<T>(url:String, f:NSData->T?, completion:T?->Void) {
    Alamofire.request(.GET, url).responseData { response in
        if let error = response.result.error {
            print("Error: \(error)")
        }
        
        let content = response.data.map(f)!
        completion(content)
    }
}

extension UIImageView {
    convenience init(url:String, placeholder:UIImage? = nil, frame:CGRect = CGRectZero) {
        self.init(frame: frame)
        self.loadUrl(url, placeholder: placeholder)
        self.replaceImage(nil, placeholder: placeholder)
    }
    
    public func loadUrl(url:String, placeholder:UIImage? = nil) {
        downloadImage(url) { [weak self] (responseImage) in
            self?.replaceImage(responseImage, placeholder: placeholder)
        }
    }
    
    private func replaceImage(image:UIImage?, placeholder:UIImage?) {
        if let image = image {
            self.image = image
        } else {
            self.image = placeholder
        }
    }
    
    private func downloadImage(url:String, completion:(UIImage?)->Void) {
        downloadContent(url, f: ({
            UIImage(data: $0)
        }), completion: completion)
    }
}

let placeholder = UIImage(named: "placeholder")
let imageView = UIImageView(url: "http://www.myuiviews.com/img/xcode-playground-option.png", placeholder: placeholder)
imageView.frame = CGRectMake(0, 0, 100, 100)

page.liveView = imageView
