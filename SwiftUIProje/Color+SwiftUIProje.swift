//
//  Color+SwiftUIProje.swift
//  SwiftUIProje
//
//  Created by BusranurOK on 12.06.2022.
//

import SwiftUI

extension Color {
    //DİZAYN TOKEN
    
    //1. katmanda temel renk alıyor
    //BUNU PRİVATE YAPTIĞIMIZ İÇİN DİĞER TARAFTA KULLANMAYA İZİN VERMEZ
    private static var swiftUiProjeWhite: Color {
        return Color("SwiftUIProjeWhite")
    }
    
    //sadece bar rengi değişeceği zaman onun işret ettiği rengi değiştirmek yeterli
    // 2. katmanda da katmanda da bizim verdiğimiz değerleri alıyor
    static var barBackgroundColor: Color {
        return swiftUiProjeWhite
    }
    
}
