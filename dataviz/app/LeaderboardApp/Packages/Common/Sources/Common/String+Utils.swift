//
//  String+Utils.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 13/11/2023.
//

import Foundation

public extension String {
    func base64DecodedData() -> Data? {
        var st = self;
//        if (self.count % 4 <= 2){
//            st += String(repeating: "=", count: (self.count % 4))
//        }
        st = st.components(separatedBy: "\n").joined()
        return Data(base64Encoded: st)
    }
}
