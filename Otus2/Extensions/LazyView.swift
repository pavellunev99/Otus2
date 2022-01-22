//
//  LazyView.swift
//  Otus2
//
//  Created by Павел Лунев on 17.01.2022.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: ()->Content
    init(_ build: @autoclosure @escaping ()->Content) {
        self.build = build
    }

    var body: some View {
        build()
    }
}
