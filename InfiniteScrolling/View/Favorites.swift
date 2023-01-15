//
//  Favorites.swift
//  InfiniteScrolling
//
//  Created by Shahzaib Iqbal Bhatti  on 14/01/2023.
//

import SwiftUI

struct Favorites: View {
    @EnvironmentObject var viewModel: ViewModel
    var body: some View {
        NavigationView {
            ScrollView {
                    CollectionView(gridItems: viewModel.favoriteImages, numberOfColumns: 2)
                        .navigationTitle("Favorite List")
            }
        }
    }
}

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        Favorites()
            .environmentObject(ViewModel())
    }
}
