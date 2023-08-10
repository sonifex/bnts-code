//
//  InfoBarView.swift
//  bnts-code
//
//  Created by Soner Güler on 10/08/2023.
//

import SwiftUI

struct PhotoInfoBarView: View {
    @State var isLoading: Bool = false
    @State var selected: Bool = false
    @State var count: Int = 0
    var tapHandler: (() -> Void)?
    
    var body: some View {
        HStack(spacing: 10) {
            if isLoading {
                ProgressView()
                    .tint(.white)
            } else {
                Button {
                    tapHandler?()
                } label: {
                    Image(systemName: selected ? "heart.fill" : "heart")
                }
            }
            
            Text("\(count) likes")
            Spacer()
        }
        .padding(10)
        .foregroundColor(.white)
    }
}

struct InfoBarView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading) {
            PhotoInfoBarView(selected: true, count: 120)
                .background(.black)
            
            PhotoInfoBarView(selected: false, count: 0)
                .background(.black)
            
            PhotoInfoBarView(isLoading: true)
                .background(.black)
        }
        
    }
}
