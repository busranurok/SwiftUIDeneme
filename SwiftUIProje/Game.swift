//
//  Game.swift
//  SwiftUIProje
//
//  Created by BusranurOK on 12.06.2022.
//

import Foundation

//NSObject : Objective-C deki bir objenin en temel, en tepedeki hali. Ekstra özellikleri bize sağlamış oluyor.
//Class larda : dan sonra bir class ismi yazar isek bu onun subclassı oluyor ve game class ı nsobjectten tyürüyor. Buna ekstradan protocoller ekleyebiliiriz
class Game: NSObject, Identifiable {
    
    var name: String = ""
    var priceInDollars: Double = 0.0
    var serialNumber: String = ""
    var dateCreated: Date
    
    //iniritialize : Bir objeyi oluşturmak için çağırdığımız fonksiyondur. C# da constuructor deniyor.
    //dateCreated oluşturulduğu zaman oluituğu için parametre olarak onu göndermiyoruz.
    //designeytın initialize, yani kendisine has initialize denirss
    init(name: String, priceInDollars: Double, serialNumber: String) {
        //NSObjeden geldiği için bunu çağırmamız gerekiyor.sss
        //super.init()
        
        self.name = name
        self.priceInDollars = priceInDollars
        self.serialNumber = serialNumber
        // Date objesi olarak tanımlamamın sebebi hangi işlem saati olarak çalıiıyor ise tam olarak o işlem saatinde oraya eşitlemiş oluyor.ss
        self.dateCreated = Date()
    }
    
    //convenience initialize, olursa güzel olur.
    //Bütün swift parametrelerin içerisinde varsayılan bir değer atayabiliyoruz.
    //Bize rastgele game objesini oluşturan bir sınıfımız var
    convenience init(random: Bool = false) {
        
        if random {
            let conditions = ["New","Mint","Used"]
            //Düzgün bir şekilde random rakam üretebilmek için fonksiyondur. Üst limit verilir.
            var index = arc4random_uniform(UInt32(conditions.count))
            let randomCondition = conditions[Int(index)]
            
            let names = ["Resident Evil","Gears of War","Halo","Godof War"]
            //Düzgün bir şekilde random rakam üretebilmek için fonksiyondur. Üst limit verilir.
            index = arc4random_uniform(UInt32(names.count))
            let randomName = names[Int(index)]
        
            index =  arc4random_uniform(UInt32(6))
            
            let randomTitle = "\(randomCondition) \(randomName) \(Int(index))"
            
            //- ile bölünmüş
            //normalde bunu opsiyonel yapıp kodun içerisinde kontrol etmek gerekir
            let serialNumber = UUID().uuidString.components(separatedBy: "-").first!
            
            let priceInDollars = Double(arc4random_uniform(UInt32(70)))
            
            self.init(name: randomTitle, priceInDollars: priceInDollars, serialNumber: serialNumber)
        }else{
            self.init(name: "", priceInDollars: 0, serialNumber: "")
        }
        
    }
    
}
