//
//  CustomFont.swift
//  Pods
//
//  Created by Heath Borders on 2/13/15.
//
//

import Foundation

public class CustomFont {
    public class func helveticaNeueLtStdMdCn(#size: CGFloat) -> UIFont! {
        struct Static {
            static var onceToken: dispatch_once_t = 0
        }
        return loadAndReturnFont(
            name: "HelveticaNeueLTStd-MdCn",
            size: size,
            onceToken: &Static.onceToken)
    }
    
    private class func ifLetBrokenWithURLForResource(#name: String) {
        let myBundle = NSBundle(forClass: CustomFont.self)
        if let fontBundleURL = myBundle.URLForResource("Fonts", withExtension: "bundle") {
            if let fontBundle = NSBundle(URL: fontBundleURL) {
                NSLog("fontBundle: \(fontBundle)")
                if let fontURL = fontBundle.URLForResource(name,
                    withExtension: "otf") {
                        if let fontData = NSData(contentsOfURL: fontURL) {
                            let dataProvider = CGDataProviderCreateWithCFData(fontData as CFDataRef)
                            if let font = CGFontCreateWithDataProvider(dataProvider) {
                                var errorUnmanaged: Unmanaged<CFErrorRef>? = nil
                                if !CTFontManagerRegisterGraphicsFont(font, &errorUnmanaged) {
                                    var errorMessage: String?
                                    if let errorUnmanaged = errorUnmanaged {
                                        let error = errorUnmanaged.takeRetainedValue()
                                        
                                        let domain = CFErrorGetDomain(error) as NSString
                                        let code = CFErrorGetCode(error)
                                        let description = CFErrorCopyDescription(error) as NSString
                                        let userInfo = CFErrorCopyUserInfo(error) as NSDictionary
                                        errorMessage = "error: domain: \(domain), code:\(code), description: \(description), userInfo: \(userInfo)"
                                        
                                        errorUnmanaged.release()
                                    } else {
                                        errorMessage = ""
                                    }
                                    
                                    fatalError("Failed to load font: \"\(name)\" \(errorMessage)")
                                }
                            }
                        }
                }
            }
        } else {
            NSLog("Failed to load Fonts.bundle because if let is broken for URLForResource")
        }
    }
    
    private class func loadFont(#name: String) {
        let myBundle = NSBundle(forClass: self.self)
        if let fontURL = myBundle.URLForResource(name,
            withExtension: "otf") {
                if let fontData = NSData(contentsOfURL: fontURL) {
                    let dataProvider = CGDataProviderCreateWithCFData(fontData as CFDataRef)
                    if let font = CGFontCreateWithDataProvider(dataProvider) {
                        var errorUnmanaged: Unmanaged<CFErrorRef>? = nil
                        if CTFontManagerRegisterGraphicsFont(font, &errorUnmanaged) {
                            let postscriptName = CGFontCopyPostScriptName(font)
                            NSLog("registered \"\(name)\" as \"\(postscriptName)\". Pass \"\(postscriptName)\" to UIFont(name:size:)")
                        } else {
                            var errorMessage: String?
                            if let errorUnmanaged = errorUnmanaged {
                                let error = errorUnmanaged.takeRetainedValue()
                                
                                let domain = CFErrorGetDomain(error) as NSString
                                let code = CFErrorGetCode(error)
                                let description = CFErrorCopyDescription(error) as NSString
                                let userInfo = CFErrorCopyUserInfo(error) as NSDictionary
                                errorMessage = "error: domain: \(domain), code:\(code), description: \(description), userInfo: \(userInfo)"
                                
                                errorUnmanaged.release()
                            } else {
                                errorMessage = ""
                            }
                            
                            fatalError("Failed to load font: \"\(name)\" \(errorMessage)")
                        }
                    }
                }
        }
    }
    
    private class func loadAndReturnFont(
        #name: String,
        size: CGFloat,
        inout onceToken: dispatch_once_t) -> UIFont! {
            dispatch_once(&onceToken, { () -> Void in
                self.loadFont(name: name)
            })
            
            return UIFont(
                name: name,
                size: size)
    }
}