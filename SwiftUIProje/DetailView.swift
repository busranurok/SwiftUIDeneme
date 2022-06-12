//
//  DetailView.swift
//  SwiftUIProje
//
//  Created by BusranurOK on 12.06.2022.
//

import SwiftUI
//just yazxmak için
import Combine

struct DetailView: View {
    
    var game: Game
    var gameStore: GameStore
    
    //Karar verdikten sonra güncelleme yapsın istiyorum. Yazdıkça kaydetsin değil.
    @State var name: String = ""
    @State var price: Double = 0.0
    
    //savebutonu aktif olsun mu yu bağladık
    @State var shouldEnableSaveButton: Bool = true
    
    func validation() {
        shouldEnableSaveButton = game.name != self.name || game.priceInDollars != price
    }
    
    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading, spacing: 6.0) {
                    //label icon ile text i birarada bulundurabiliyor
                    Text("Name")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    //Dolar işareti olduğunda name değişkenine bağlanıyor
                    TextField("Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onReceive(Just(name)) { newValue in
                            validation()
                        }                }
                //sadece yukarıdan ve aşağıdan ver
                .padding(.vertical, 4.0)
                
                VStack(alignment: .leading, spacing: 6.0) {
                    //label icon ile text i birarada bulundurabiliyor
                    Text("Price in Dollars")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    //Dolar işareti olduğunda name değişkenine bağlanıyor
                    TextField("Price", value: $price, formatter: Formatters.dollarFormatter)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onReceive(Just(price)) { newValue in
                            validation()
                        }
                }
                //sadece yukarıdan ve aşağıdan ver
                .padding(.vertical, 4.0)
            }
            Section {
                Button {
                    let newGame = Game(name: name, priceInDollars: price, serialNumber: game.serialNumber)
                    gameStore.update(game: game, newValue: newGame)
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50.0)
                }
                //Bu true ise butonu silik bir şekilde gri gösteriyor
                .disabled(!shouldEnableSaveButton)

            }
        }
        //Başlığı nasıl gösterecek
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
         
        let gameStore = GameStore()
        //HEM OYUNUN İÇERİSİNE EKLENMİŞ OLACAK
        let game = gameStore.createGame()
        DetailView(game: game, gameStore: gameStore)
    }
}
