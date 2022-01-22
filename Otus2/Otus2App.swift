//
//  Otus2App.swift
//  Otus2
//
//  Created by Павел Лунев on 11.01.2022.
//

import SwiftUI
import Navigation

@main
struct Otus2App: App {

    init() {
        Configurator.shared.register()
    }

    var body: some Scene {
        WindowGroup {
            NavigationContainerView(transition: .none, content: {
                ContentView()
            })
        }
    }
}
