//
//  Test.swift
//  Caidian-iOS
//
//  Created by mac on 2018/7/3.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import Foundation
class Test: NSObject{
    func method()  {
       
    }

}

protocol P {
    func work(b: @escaping()->())
}


struct   VectorTest {
    var x = 0.0
    var y = 0.0
}
class C: P {
    func work(b: @escaping () -> ()) {
        
    
        
    }

   
}
extension Toy{
    func play() {
    }
}

class Toy {
    let name :String
    init(name:String) {
        self.name = name
    }
}

class Pet {
    var toy : Toy?
}








