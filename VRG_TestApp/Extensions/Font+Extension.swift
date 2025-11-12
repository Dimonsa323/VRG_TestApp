//
//  Font+Extension.swift
//  VRG_TestApp
//
//  Created by Дима Губеня on 11.11.2025.
//

import SwiftUI

extension Font {
    
    //MARK: - Poppins Font Variants
    
    static func poppinsRegular(size: CGFloat) -> Font {
        return .custom("Poppins-Regular", size: size)
    }
    
    static func poppinsMedium(size: CGFloat) -> Font {
        return .custom("Poppins-Medium", size: size)
    }
    
    static func poppinsSemiBold(size: CGFloat) -> Font {
        return .custom("Poppins-SemiBold", size: size)
    }
    
    static func poppinsBold(size: CGFloat) -> Font {
        return .custom("Poppins-Bold", size: size)
    }
    
    //MARK: - Typography Styles
    
    static var appHeader: Font {
        return .poppinsBold(size: 34)
    }
    
    static var appTitle: Font {
        return .poppinsBold(size: 28)
    }
    
    static var appTitle2: Font {
        return .poppinsSemiBold(size: 22)
    }
    
    static var appTitle3: Font {
        return .poppinsSemiBold(size: 20)
    }
    
    static var appHeadline: Font {
        return .poppinsMedium(size: 16)
    }
    
    static var appBody: Font {
        return .poppinsRegular(size: 17)
    }
    
    static var appSubheadline: Font {
        return .poppinsRegular(size: 14)
    }
    
    static var appCaption: Font {
        return .poppinsRegular(size: 12)
    }
}
