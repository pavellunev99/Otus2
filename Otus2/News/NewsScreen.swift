//
//  NewsScreen.swift
//  Otus2
//
//  Created by Павел Лунев on 17.01.2022.
//

import SwiftUI
import Network
import Navigation

struct NewsScreen: View {

    @StateObject var newsViewModel: NewsViewModel = .init()
    @EnvironmentObject var routeModel: NavigationContainerViewModel

    @State private var selectedCellPosition: CGPoint = .zero
    @State private var selectedArcticle: Article?
    @State private var showAnimation = false
    @State private var selectedTheme = "bitcoin"
    @State private var isAnimationInProgress = true

    var body: some View {
        ZStack {

            VStack {
                navView
                picker
                list
            }

            Text(selectedArcticle?.title ?? "")
                .background(.white)
                .modifier(FlyEffect(isShowed: $showAnimation, progress: showAnimation ? 1.0 : 0.0))
            
        }.onChange(of: selectedTheme) { newValue in
            newsViewModel.reloadPage(with: newValue)
        }
    }

    var navView: some View {
        HStack {
            Button("Back") {
                routeModel.pop()
            }
            .padding(.leading, 16)
            Spacer()
        }
    }

    var list: some View {
        List {
            ForEach(newsViewModel.articles) { article in
                NewsArticleCell(article: article)
                    .showActivityIdicator(newsViewModel.isPageLoading && newsViewModel.articles.isLast(article))
                    .onAppear {
                        if newsViewModel.articles.isLast(article) {
                            newsViewModel.loadNextPage(with: selectedTheme)
                        }
                    }
                    .onTapGesture {
                        selectedArcticle = article
                        isAnimationInProgress = true
                        withAnimation(.linear(duration: 2)) {
                            showAnimation.toggle()
                        }
                    }
            }
        }
        .listStyle(.plain)
        .onAppear {
            newsViewModel.loadNextPage(with: selectedTheme)
        }
    }

    var picker: some View {
        Picker("select theme", selection: $selectedTheme) {
            Text("Bitcoin").tag("bitcoin")
            Text("Apple").tag("apple")
            Text("VR").tag("vr")
        }
        .pickerStyle(.segmented)
    }
}

struct FlyEffect: GeometryEffect {

    var animatableData: Double {
        get { progress }
        set { progress = newValue }
    }

    @Binding var isShowed: Bool

    var progress: Double

    func effectValue(size: CGSize) -> ProjectionTransform {

        DispatchQueue.main.async {
            if progress == 1 {
                self.isShowed = false
            }
        }

        let screenSize = UIScreen.main.bounds.size

        let transorm = CGAffineTransform(translationX: progress * screenSize.width, y: progress * screenSize.height/2).scaledBy(x: 1 - progress, y: 1)

        return ProjectionTransform(transorm)
    }
}

struct NewsArticleCell: View {

    var article: Article

    var body: some View {
        Text(article.title ?? "")
    }

}

struct NewsScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewsScreen()
    }
}
