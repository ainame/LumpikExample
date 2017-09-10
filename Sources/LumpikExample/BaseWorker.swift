//
//  BaseWorker.swift
//  LumpikExamplePackageDescription
//
//  Created by Satoshi Namai on 2017/09/10.
//

import Foundation
import Lumpik

class BaseWorker {
    var jid: Jid?
    var queue: Queue?
    var retry: Int?
    
    required init() {}
}
