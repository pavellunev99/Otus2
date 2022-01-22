//
//  ContentView.swift
//  Otus2
//
//  Created by Павел Лунев on 11.01.2022.
//

import SwiftUI
import Navigation

struct ContentView: View {

    @State private var selection: Int = 0

    var body: some View {
        TabView(selection: $selection) {
            NewsTabView()
                .navigationTitle("News")
                .tabItem { Label("News", systemImage: "folder") }
                .tag(0)
            BookmarksTabView()
                .navigationTitle("Bookmarks")
                .tabItem { Label("Bookmarks", systemImage: "bookmark") }
                .tag(1)
        }

    }
}

struct NewsTabView: View {

    @EnvironmentObject var routeModel: NavigationContainerViewModel

    var body: some View {
        Button("News") {
            routeModel.push(screenView: LazyView(NewsScreen()).toAnyView())
        }
    }
}

struct BookmarksTabView: View {

    @EnvironmentObject var routeModel: NavigationContainerViewModel

    var body: some View {
        Text("Bookmarks")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
