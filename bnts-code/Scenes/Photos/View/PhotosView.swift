//
//  PhotosView.swift
//  bnts-code
//
//  Created by Soner Güler on 10/08/2023.
//

import SwiftUI

struct PhotosView<ViewModel: PhotosViewModeling & ObservableObject>: View {
    
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var spinnerView: some View {
        Color.black
            .overlay {
                ProgressView("Loading...")
                    .progressViewStyle(.automatic)
                    .tint(.white)
                    .foregroundColor(.white)
                    
            }
            .ignoresSafeArea()
    }
    
    var body: some View {
        TabView {
            ForEach(viewModel.photos) { photo in
                PhotoCardView(url: photo.imageURL, title: photo.title)
            }
        }
        .ignoresSafeArea()
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .background(.black)
        .overlay {
            if viewModel.isLoading {
                spinnerView
            }
        }
    }
}

struct PhotosView_Previews: PreviewProvider {
    static var loadingVM: PhotosViewModel {
        let vm = PhotosViewModel()
        vm.isLoading = true
        return vm
    }
    static var previews: some View {
        Group {
            PhotosView(viewModel: PhotosViewModel())
            PhotosView(viewModel: loadingVM)
                .previewDisplayName("Loading on")
        }
    }
}