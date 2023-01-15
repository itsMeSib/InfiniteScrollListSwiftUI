//
//  ImageCell.swift
//  InfiniteScrolling
//
//  Created by Shahzaib Iqbal Bhatti  on 14/01/2023.
//

import SwiftUI
import Kingfisher

struct ImageCell: View {
    var image: ImageModel

    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                GeometryReader{ reader in
                    KFImage.url(URL(string: image.download_url))
                        .resizable()
                        .scaledToFill()
                        .frame(width: reader.size.width,
                               height: reader.size.height,
                               alignment: .center)
                }

                Rectangle()
                    .foregroundColor(Color.white.opacity(0.1))
                    .frame(height: 20)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)

                Text(image.author)
                        .font(.caption)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                        .padding(4)
                        .shadow(color: .black.opacity(0.2), radius: 1)

            }
            .frame(height: image.displayHeight)
            .frame(maxWidth: .infinity)
        }
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.2), radius: 1)
    }
}


struct ImageCell_Previews: PreviewProvider {
    static var previews: some View {
        let image = ImageModel(id: "0", author: "SIB", width: 5000, height: 3333, url: "", download_url: "https://picsum.photos/id/0/5000/3333")

        ImageCell(image: image)
            .environmentObject(ViewModel())
    }
}
