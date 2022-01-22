//
//  Configurator.swift
//  Otus2
//
//  Created by Павел Лунев on 17.01.2022.
//

import Foundation
import ServiceLocator
import DataStorage
import Network

class Configurator {
    static let shared = Configurator()

    func register() {
        ServiceLocator.shared.addServices(service: DataStorage())
        ServiceLocator.shared.addServices(service: NetworkService())
    }
}
