//
//  ContentView.swift
//  SwiftUIProje
//
//  Created by BusranurOK on 12.06.2022.
//

import SwiftUI

struct ContentView: View {
    
    //Abone haline getirmek için başına koymamız gerekir. ve bunu var a yapabiliriz çünkü içerisindeki değişecek. Artık bu dinliyor. gamestore ne zaman bir sinyal alırsa bu arayüz kendini yeniden çizmiş olacak.
    @ObservedObject var gameStore = GameStore()
    
    //Localde silme işlemi gerçekl3eştireceğimiz için bir state değişkene ihtiyadcımız var. Opsiyonel olacak çünkü işi bittiğinde bunu nile çevirecek
    @State var gameToDelete: Game?
    
    var body: some View {
        
        //Butonların üzerine durum çubuğu getirir
        NavigationView{
            
            //Çalışma mantığı: Listenin içerisine verdiğimiz bir array elemanını tek tek bir klajüre paslıyor. Ve bizim bu eleamndan bir arayüz oluşturup onu tanımlamam gerekiyor.
            //İdentifier bir protocol. Game objeleri bu protocole uyması gerekiyor bunun için game modelini tanımlar iken protocol den de türetmemizs gerekiyor
            List {
                //Color.white.frame(width: nil, height: 10, alignment: .center)
                /*HStack{
                    Spacer()
                    Button(action: {
                        gameStore.createGame()
                    }, label: {
                        Text("add")
                    })
                    //seçim olayını kaldırır.
                    //veri iletişimini dinleyecek swiftui arayüzünü oluyşturacak şey: bir tane gamestore objemiz var. biz bunu çağırdığımızda games arrayine yeni oyunlar ekleniyor fakat sistemde arayüz kendini yenilemiyor. kendisini yenileyebilmesi için bir trigger a tetiğe ihtiyacı var. Daha onceki ğrneklerde bir state yapısı kullanmıştık ve state değikenleri güncellendiğinde arayüz kendini güncelliyordu. Bunu kullanmadığımız için arayüz kendini güncellemiyor.
                    //State değişkenleri local yani sadece o view ı etkileyen değişkenlerdir.Bu yüzden değişkenin başına state koymak yerine farklı bir yöntem deneyeceğiz. Ve bunu başka yerlerde de kullanabilme durumumuz olacak.
                        .buttonStyle(BorderlessButtonStyle())
                }*/
                //Foreach yaptığımızda listeden koparmış oluruz. Yukarısına button koyduğumuz zaman o da bir liste elemanı olarak buraya yerleşir
                ForEach(gameStore.games) {
                    (game) in
                    //Buraya basıldığında bir yere gitmesini istiyoruz.Bunun için navigationlink kullanırız
                    NavigationLink(destination: DetailView(
                        game: game,
                        gameStore: gameStore,
                        name: game.name,
                        price: game.priceInDollars)
                    ){
                        //NavigationLink(destination: Text(game.name)){
                        //GameListItem(game: game, numberFormatter: Formatters.dollarFormatter)
                        //Bu şekilde yazmamın sebebi aşağıda numberformatter i bir şeye eşitlememdir
                        GameListItem(game: game)
                    }
                }
                .onDelete { indexSet in
                    //Ondelete olduğu zaman artık bunu yapmayacağım
                    //gameStore.delete(at: indexSet)
                    //Bunu indexsetlere göre tek tek bakıp oradan çekebilirdik
                    self.gameToDelete = gameStore.game(at: indexSet)
                }
                .onMove(perform: { indices,
                    newOffset in
                    gameStore.move(indices: indices, to: newOffset)
                })
            }
            //içerisini automatic yaparsak daha önceki sayfa nasıl ise o şekilde olur
            //.navigationBarTitleDisplayMode(.inline)
            //Her ekleme işleminde animasyon gerçekleşiyor.
            .animation(.easeIn)
            //Overlay otomatik olarak ortaya alınır.
            //liste elemanlarının arkada saklanmamasını üzerine gelmesini sağlarız
            /*.overlay(
                VStack{
                    HStack{
                        //EditButton()
                        Spacer()
                        /*Button(action: {
                            gameStore.createGame()
                        }, label: {
                            Text("add")
                        })
                        //seçim olayını kaldırır.
                        //veri iletişimini dinleyecek swiftui arayüzünü oluyşturacak şey: bir tane gamestore objemiz var. biz bunu çağırdığımızda games arrayine yeni oyunlar ekleniyor fakat sistemde arayüz kendini yenilemiyor. kendisini yenileyebilmesi için bir trigger a tetiğe ihtiyacı var. Daha onceki ğrneklerde bir state yapısı kullanmıştık ve state değikenleri güncellendiğinde arayüz kendini güncelliyordu. Bunu kullanmadığımız için arayüz kendini güncellemiyor.
                        //State değişkenleri local yani sadece o view ı etkileyen değişkenlerdir.Bu yüzden değişkenin başına state koymak yerine farklı bir yöntem deneyeceğiz. Ve bunu başka yerlerde de kullanabilme durumumuz olacak.
                            .buttonStyle(BorderlessButtonStyle())*/
                    }
                    .padding()
                    .background(
                        Color.barBackgroundColor
                        //Color.swiftUiProjeWhite
                        //Arkaplanı en yukarıdan başlayacak
                            .edgesIgnoringSafeArea(.top)
                    )
                    //overlay ı yukarı iter
                    Spacer()
                }
            )*/
            
            //Bir şeyi binding yapmak için onun başına dolar işareti koyuyoruz.
            .actionSheet(item: $gameToDelete) { game in
                
                ActionSheet(
                    title: Text("Are you sure"),
                    message: Text("You will delete \(game.name)"),
                    buttons: [
                        .cancel(),
                        .destructive(Text("Delete"), action: {
                            if let indexSet = gameStore.indexSet(for: game) {
                                gameStore.delete(at: indexSet)
                            }
                        })
                    ])
            }
            .listStyle(PlainListStyle())
            .navigationTitle("SwiftUIProje")
            //Navigationview e vermiyoruz
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                gameStore.createGame()
            }, label: {
                Text("add")
            }))
        }
        .accentColor(.purple)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
