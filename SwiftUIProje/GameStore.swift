//
//  GameStore.swift
//  SwiftUIProje
//
//  Created by BusranurOK on 12.06.2022.
//

import Foundation

//publisher : combayn(asekron) : yayın yapması gerek. Her yayın yaptığında da ona abone olan birimlerin(ekran, başka bir detay ekranı olabilir vs) kendini yeniden çizmesi gerekiyor. ObservableObject sayesinde bu classı yayıncı haline getiriyoruz. Bunu verebilmek için bunun class tipinde olması gerekiyor. Üzerine abone alabilen bir obje tipidir.
class GameStore: ObservableObject {
    
    
    //İleride bu büyür ise oyunlar dışında başka bir şey tutarsak mesela loading yapıyor mu yapmıyor mu diye hepsini tutarsak hepsine obctwillchangesend diye metodu koyacak mıyız? bunun kolay bir yolu möevcut. Her defasında bu send metodunu çağırabilecek etiket Published diye bir şey var. Herhangi bir değişkenin başına bunun yazar isek otomatik olarak sinyal gçndermeye başlıyor. Neden hepsinin başına bunu yazmıyoruz bazen obje değiştiğinde belli durumlarda sinyal göndermek isteyebilirsin. Bu durumda da didSet metodu var.
    /*var games: [Game] = [] {
        //gtames e yeni bir şey eklendiğinde ya da çıkarıldığında bu didset bloğu çalışacak
        didSet {
            //bunu koyduğumda her değişiklik olduğunda bir sinyal dönecek.
            objectWillChange.send()
        }
    }*/
    @Published var games: [Game] = []
    
    
    //İlk gameStore yi oluşturduğumuzda 5 tane oyun oluştursun
    init() {
        //_ : Biz bir şeyi çağırıp onu kullanmadığımız zamanlkarda _ verebiliriz.
        /*for _ in 0..<5 {
            //Aşağıdaki fonksiyon Game i return ediyor fakat biz bunu kullanmıyoruz. Bçyle duurmlarda yani return ettiği objeyi kale almayabileceksek o zaman func a @discardableResult koyarız
            createGame()
        }*/
    }
    
    //Oluşturulduğu anda hangi elemanı oluşturulduğunu almak için yapıyoruz.
    //@discardableResult: fonksiyon sonucunu discard edebileceğimizi gösterir
    @discardableResult func createGame() -> Game {
        
        let game = Game(random: true)
        games.append(game)
        return game
    }
    
    func delete(at indexSet: IndexSet) {
        games.remove(atOffsets: indexSet)
    }
    
    func move(indices: IndexSet, to newOffset: Int) {
        games.move(fromOffsets: indices, toOffset: newOffset)
    }
    
    func indexSet(for game: Game) -> IndexSet? {
        if let firstIndex = games.firstIndex(of: game) {
            return IndexSet(integer: firstIndex)
        }else{
            return nil
        }
    }
    
    func game(at indexSet: IndexSet) -> Game? {
        
        //if let ile bunu garanti altına alıyoruz var mı yok mu nil kontrolü
        if let firstIndex = indexSet.first {
            //indexset: içinde int lardan oluşan set. array gibi düşünebiliriz.
            return games[firstIndex]
        }
        return nil
    }
    
    func update(game: Game, newValue: Game) {
        
        if let index = games.firstIndex(of: game) {
            games[index] = newValue
        }
    }
}
