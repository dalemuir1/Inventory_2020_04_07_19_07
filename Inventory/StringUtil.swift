//
//  StringUtil.swift
//  Inventory
//
//  Created by dalemuir on 10/12/16.
//  Copyright © 2016 Dale Muir. All rights reserved.
//

import UIKit

extension String {
    
    static let unreservedChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~!*()<>"
    static let unreservedCharset = NSCharacterSet(charactersIn: unreservedChars)

    
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    func URLEncode() -> String {
        let encodedString = trim().addingPercentEncoding(withAllowedCharacters: String.unreservedCharset as CharacterSet)
        return encodedString!
    }
    
    func URLDecode() -> String! {
        var s = self.replacingOccurrences(of: "&#39;", with: "'") // special sql char for '
        s = self.replacingOccurrences(of: "&#34;", with: "\"") // special sql char for "
        
        return s.removingPercentEncoding
    }
}
