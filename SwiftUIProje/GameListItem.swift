//
//  GameListItem.swift
//  SwiftUIProje
//
//  Created by BusranurOK on 12.06.2022.
//

import SwiftUI

struct GameListItem: View {
    
    var game: Game
    //var numberFormatter : NumberFormatter
    var numberFormatter : NumberFormatter = Formatters.dollarFormatter
    var body: some View {
        HStack{
            //leading: soldan boşluk bırakıyor, spacing: iki eleman arasında boşluk bırakıyor
            VStack(alignment: .leading, spacing: 4.0){
                Text(game.name)
                    .font(.body)
                Text(game.serialNumber)
                    .font(.caption)
                    .foregroundColor(Color(white: 0.65))
            }
            Spacer()
            //Double verdiğimiz için string e çevirmemiz gerekiyor. O zxaman basabiliyoruz.
            //Text("\(game.priceInDollars)")
            Text(NSNumber(value: game.priceInDollars), formatter: numberFormatter)
                .font(.title2)
                .foregroundColor(game.priceInDollars > 30 ? .blue : .gray)
                .animation(nil)
        }
        //Bir de genel olarak bir liste elemanının nefes alabileceği bir şey yapmamız gerekir. Bunun için padding veririz.
        .padding(.vertical, 6)
    }
}


//Buna bir preview oıluşturalım ki listenin itemlarını görebilelim
//PreviewProvider bir protocoldür
struct GameListItem_Previews: PreviewProvider {
    static var previews: some View {
        
        let item = GameListItem(game: Game(random: true))
            .padding(.horizontal)
            .previewLayout(.sizeThatFits)
        
        //Game de ya static yaparız ya da
        //Static vermemizin sebebi nesnesini oluşturmadan direk sınıfın adı ile içerisindekilere erişebilme
        Group{
            item
                .preferredColorScheme(.dark)
            item
                .environment(\.sizeCategory, .accessibilityExtraLarge)
            item
            .environment(\.locale, Locale(identifier: "tr"))        }
    }
}
