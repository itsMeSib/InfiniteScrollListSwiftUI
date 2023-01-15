//
//  InfiniteView.swift
//  InfiniteScrolling
//
//  Created by Shahzaib Iqbal Bhatti  on 14/01/2023.
//

import SwiftUI

struct InfiniteView: View {
    @EnvironmentObject var viewModel: ViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                let loadMore = {
                    viewModel.fetch()
                }
                
                CollectionView(gridItems: viewModel.images, numberOfColumns: 2,
                               loadMore: loadMore)
                .navigationTitle("Infinite List")
                .onAppear {
                    viewModel.fetch()
                }

            }
        }
    }
}

struct InfiniteView_Previews: PreviewProvider {
    static var previews: some View {
        InfiniteView()
            .environmentObject(ViewModel())
    }
}

