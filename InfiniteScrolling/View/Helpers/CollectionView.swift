//
//  CollectionView.swift
//  InfiniteScrolling
//
//  Created by Shahzaib Iqbal Bhatti  on 10/01/2023.
//

import SwiftUI

struct CollectionView: View {
    let loadMore: (() -> Void)?

    struct Column: Identifiable {
        let id = UUID()
        var gridItems = [ImageModel]()
    }
    
    let columns: [Column]

    let spacing: CGFloat
    let horizontalPadding : CGFloat

    init(gridItems: [ImageModel], numberOfColumns: Int, spacing: CGFloat = 10, horizontalPadding: CGFloat = 10, loadMore: (() -> Void)? = nil) {
        self.spacing = spacing
        self.horizontalPadding = horizontalPadding
        self.loadMore = loadMore

        var columns = [Column]()
        for _ in 0 ..< numberOfColumns {
            columns.append(Column())
        }

        var columnsHeight = Array<CGFloat>(repeating: 0, count: numberOfColumns)

        for gridItem in gridItems {
            var smallestColumnIndex = 0
            var smallestHeight = columnsHeight.first
            for i in 1 ..< columnsHeight.count {
                let curHeight = columnsHeight[i]
                if curHeight < smallestHeight ?? 0 {
                    smallestHeight = curHeight
                    smallestColumnIndex = i
                }
            }

            columns[smallestColumnIndex].gridItems.append(gridItem)
            columnsHeight[smallestColumnIndex] += gridItem.displayHeight
        }

        self.columns = columns
    }

    var body: some View {
        HStack(alignment: .top, spacing: spacing) {
            ForEach(columns) { column in
                LazyVStack(spacing: spacing) {
                    ForEach(column.gridItems, id: \.self) { image in
                        NavigationLink {
                            ImageDetail(image: image)
                        } label: {
                            ImageCell(image: image)
                        }
                    }

                    Rectangle()
                        .frame( width: 50, height: 50)
                        .foregroundColor(.clear)
                        .onAppear {
                            if column.gridItems.count > 0 {
                                print("Fetch Here")
                                loadMore?()
                            }
                        }
                }
            }
        }
        .padding(.horizontal)
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        var gridItems = [ImageModel] ()

        for i in 0 ..< 30 {
            gridItems.append(ImageModel(id: "\(i)", author: "SIB", width: 5000, height: 3333, url: "", download_url: "https://picsum.photos/id/0/5000/3333"))
        }
       return  CollectionView(gridItems: gridItems, numberOfColumns: 2)
            .environmentObject(ViewModel())
    }
}
