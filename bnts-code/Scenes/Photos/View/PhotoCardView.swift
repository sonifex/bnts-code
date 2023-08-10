//
//  PhotoCardView.swift
//  bnts-code
//
//  Created by Soner Güler on 10/08/2023.
//

import SwiftUI
import Kingfisher

struct PhotoCardView: View {
    
    var url: URL
    var title: String
    @State var liked: Bool
    @State var likeCount: Int
    @State var isLikeLoading: Bool = false
    var likeTapHandler: (() -> Void)?
    
    var body: some View {
        ZStack {
            KFImage(url)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 5) {
                    Text(title)
                    PhotoInfoBarView(isLoading: isLikeLoading, selected: liked, count: likeCount, tapHandler: likeTapHandler)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 40)
                        .padding(.leading, -12)
                }
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .background(
                    LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .bottom, endPoint: .top)
                )
            }
        }
        .background(.black)
        .edgesIgnoringSafeArea(.all)
    }
}

struct PhotoCardView_Previews: PreviewProvider {
    
    static var previews: some View {
        //        let url = URL(string: "https://images.unsplash.com/photo-1690975608976-1933d9e8ccde?ixid=M3w0ODcxOTB8MHwxfGFsbHwzfHx8fHx8Mnx8MTY5MTY2MzkzMnw&ixlib=rb-4.0.3")!
        let url = URL(string: "https://images.unsplash.com/photo-1687360440984-3a0d7cfde903?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0ODcxOTB8MXwxfGFsbHwxfHx8fHx8Mnx8MTY5MTY3OTk4NXw&ixlib=rb-4.0.3&q=80&w=1080")!
        let title = "A man is doing a trick in a cave"
        
        return PhotoCardView(url: url, title: title, liked: true, likeCount: 12)
    }
}
