//
//  ViewModel.swift
//  InfiniteScrolling
//
//  Created by Shahzaib Iqbal Bhatti  on 14/01/2023.
//

import Foundation

class ViewModel: ObservableObject {

    @Published var images: [ImageModel] = []

    var favoriteImages: [ImageModel] {
        images.filter { $0.isFavorite }
    }

    var isLoading = false
    @Published var page = 0

    func fetch(session: URLSession = URLSession.shared, completion: (() -> Void)? = nil) {
        guard !isLoading else { return }
        isLoading = true
        let url = URL(string: "https://picsum.photos/v2/list?page=\(page)&limit=30")!
        let task = session.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.isLoading = false
                completion?()
                return
            }
            do {
                let images = try JSONDecoder().decode([ImageModel].self, from: data)
                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.images += images
                    completion?()
                }
            } catch {
                print(error)
                self?.isLoading = false
                completion?()
            }
        }
        task.resume()
    }

}
