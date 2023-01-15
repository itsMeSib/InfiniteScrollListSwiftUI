//
//  ContentView.swift
//  InfiniteScrolling
//
//  Created by Shahzaib Iqbal Bhatti  on 10/01/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .featured

    let viewModel = ViewModel()

    enum Tab {
        case featured
        case list
    }

    var body: some View {
        TabView(selection: $selection) {
            InfiniteView()
                .environmentObject(viewModel)
                .tabItem {
                    Label("List", systemImage: "list.bullet")
                }
                .tag(Tab.featured)

            Favorites()
                .environmentObject(viewModel)
                .tabItem {
                    Label("Favourite", systemImage: "star")
                }
                .tag(Tab.list)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}
