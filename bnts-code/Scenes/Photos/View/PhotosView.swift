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
                PhotoCardView(url: photo.imageURL,
                              title: photo.description ?? "",
                              liked: photo.isLiked,
                              likeCount: photo.totalLikes,
                              isLikeLoading: viewModel.loadingPhotoLikeID == photo.id) {
                    
                    // Disabled due to auth restriction
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.error)
                    
                    viewModel.photoLikeDidTap(photo: photo)
                }
                              .onTapGesture {
                                  UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
                                  viewModel.photoDidTap(photo: photo)
                              }
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
