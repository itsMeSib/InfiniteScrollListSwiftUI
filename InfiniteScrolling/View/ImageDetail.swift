//
//  ImageDetail.swift
//  InfiniteScrolling
//
//  Created by Shahzaib Iqbal Bhatti  on 10/01/2023.
//

import SwiftUI
import Kingfisher

struct ImageDetail: View {
    @EnvironmentObject var viewModel: ViewModel
    var image: ImageModel
    var imageIndex: Int {
        viewModel.images.firstIndex(where: { $0.id == image.id })!
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            KFImage.url(URL(string: image.download_url))
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .cornerRadius(8)

            FavoriteButton(isSet: $viewModel.images[imageIndex].isFavorite)
                .frame(maxWidth: .infinity, alignment: .bottomTrailing)

            Divider()
            
            Text("Author Name: \(image.author)")
                .font(.title3)

            Text("Image Size: width: \(image.width) x height: \(image.height)")
                .font(.subheadline)

            Spacer()
        }
        .padding()
    }
}

struct ImageDetail_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetail(image: ImageModel(id: "0", author: "SIB", width: 3000, height: 4000, url: "", download_url: "https://picsum.photos/id/114/3264/2448"))
            .environmentObject(ViewModel())
    }
}
