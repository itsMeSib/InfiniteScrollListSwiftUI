//
//  CollectionViewSpecs.swift
//  InfiniteScrollingTests
//
//  Created by Shahzaib Iqbal Bhatti  on 14/01/2023.
//

import Quick
import Nimble
@testable import InfiniteScrolling

class CollectionViewSpec: QuickSpec {
    override func spec() {
        describe("CollectionView") {
            var collectionView: CollectionView!
            var gridItems: [ImageModel]!

            beforeEach {
                gridItems = []
                for i in 0 ..< 30 {
                    gridItems.append(ImageModel(id: "\(i)", author: "SIB", width: 5000, height: 3333, url: "", download_url: "https://picsum.photos/id/0/5000/3333"))
                }
            }

            context("when initialised with valid inputs") {
                beforeEach {
                    collectionView = CollectionView(gridItems: gridItems, numberOfColumns: 2, spacing: 10, horizontalPadding: 10, loadMore: nil)
                }

                it("creates a CollectionView object with all properties set to correct values") {
                    expect(collectionView).toNot(beNil())
                    expect(collectionView.columns.count).to(equal(2))
                    expect(collectionView.spacing).to(equal(10))
                    expect(collectionView.horizontalPadding).to(equal(10))
                    expect(collectionView.loadMore).to(beNil())
                }
            }
        }
    }
}
