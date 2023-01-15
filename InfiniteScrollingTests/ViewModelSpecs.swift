//
//  ViewModelSpecs.swift
//  InfiniteScrollingTests
//
//  Created by Shahzaib Iqbal Bhatti  on 14/01/2023.
//

import XCTest
@testable import InfiniteScrolling

class ViewModelTests: XCTestCase {

    var viewModel: ViewModel!

    override func setUp() {
        super.setUp()
        viewModel = ViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testInitialState() {
        XCTAssertEqual(viewModel.images.count, 0)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.page, 0)
    }

    func testSuccessfulFetch() {
        let jsonData = """
        [
        {"id":"0","author":"Alejandro Escamilla","width":5000,"height":3333,"url":"https://unsplash.com/photos/yC-Yzbqy7PY","download_url":"https://picsum.photos/id/0/5000/3333"},
        {"id":"1","author":"Alejandro Escamilla","width":5000,"height":3333,"url":"https://unsplash.com/photos/LNRyGwIJr5c","download_url":"https://picsum.photos/id/1/5000/3333"}
        ]
        """.data(using: .utf8)!

        let session = URLSessionMock(data: jsonData, error: nil)

        let expectation = self.expectation(description: "Get the 2 Elements of Pictures")
        viewModel.fetch(session: session) {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertEqual(self.viewModel.images.count, 2)
            XCTAssertEqual(self.viewModel.images[0].id, "0")
            XCTAssertEqual(self.viewModel.images[0].download_url, "https://picsum.photos/id/0/5000/3333")
            XCTAssertEqual(self.viewModel.images[1].id, "1")
            XCTAssertEqual(self.viewModel.images[1].download_url, "https://picsum.photos/id/1/5000/3333")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFailedFetch() {
        let error = NSError(domain: "", code: 0, userInfo: nil)
        let session = URLSessionMock(data: nil, error: error)
        viewModel.fetch(session: session) {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertEqual(self.viewModel.images.count, 0)
        }
    }


    func testIsLoading() {
        viewModel.isLoading = true
        viewModel.fetch() {
            XCTAssertTrue(self.viewModel.isLoading)
            XCTAssertEqual(self.viewModel.images.count, 0)
        }
    }

    func testFailedFetchIncrementPage() {
        let error = NSError(domain: "", code: 0, userInfo: nil)
        let session = URLSessionMock(data: nil, error: error)
        viewModel.fetch(session: session) {
            XCTAssertEqual(self.viewModel.page, 0)
            self.viewModel.fetch(session: session) {
                XCTAssertEqual(self.viewModel.page, 0)
            }
        }
    }

    func testFailedFetchWrongJson() {
        let jsonData = """
        [
        abcd
        ]
        """.data(using: .utf8)!

        let session = URLSessionMock(data: jsonData, error: nil)

        let expectation = self.expectation(description: "Get the 2 Elements of Pictures")
        viewModel.fetch(session: session) {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertEqual(self.viewModel.images.count, 0)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }


    func testAddingAndRemovingFavorites() {
        let jsonData = """
        [
        {"id":"0","author":"Alejandro Escamilla","width":5000,"height":3333,"url":"https://unsplash.com/photos/yC-Yzbqy7PY","download_url":"https://picsum.photos/id/0/5000/3333"},
        {"id":"1","author":"Alejandro Escamilla","width":5000,"height":3333,"url":"https://unsplash.com/photos/LNRyGwIJr5c","download_url":"https://picsum.photos/id/1/5000/3333"}
        ]
        """.data(using: .utf8)!

        let session = URLSessionMock(data: jsonData, error: nil)

        let expectation = self.expectation(description: "Get the 2 Elements of Pictures added to favorites")
        viewModel.fetch(session: session) {
            XCTAssertEqual(self.viewModel.favoriteImages.count, 0)
            self.viewModel.images[0].isFavorite.toggle()
            XCTAssertEqual(self.viewModel.favoriteImages.count, 1)
            self.viewModel.images[1].isFavorite.toggle()
            XCTAssertEqual(self.viewModel.favoriteImages.count, 2)
            self.viewModel.images[1].isFavorite.toggle()
            XCTAssertEqual(self.viewModel.favoriteImages.count, 1)
            self.viewModel.images[0].isFavorite.toggle()
            XCTAssertEqual(self.viewModel.favoriteImages.count, 0)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

}

class URLSessionMock: URLSession {
    var data: Data?
    var error: Error?

    init(data: Data?, error: Error?) {
        self.data = data
        self.error = error
    }

    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        completionHandler(data, nil, error)
        return URLSessionDataTaskMock()
    }
}

class URLSessionDataTaskMock: URLSessionDataTask {
    override func resume() { }
}
