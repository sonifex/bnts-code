//
//  PhotoDetailView.swift
//  bnts-code
//
//  Created by Soner Güler on 10/08/2023.
//

import SwiftUI

struct PhotoDetailView<ViewModel: PhotoDetailViewModeling & ObservableObject>: View {
    
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    func cellItem(label: String, value: String?) -> some View {
        HStack {
            Text(label)
                .font(.callout)
                .foregroundColor(.gray)
            Spacer(minLength: 20)
            Text(value ?? "")
                .font(.body)
                .foregroundColor(.white)
                .multilineTextAlignment(.trailing)
        }
        .listRowBackground(Color("darkGray"))
    }
    
    var body: some View {
        List {
            Section("Photo") {
                cellItem(label: "ID", value: "\(viewModel.photo.id)")
                cellItem(label: "Created at", value: viewModel.photo.createdAt.formatted(.dateTime))
                cellItem(label: "Description", value: viewModel.photo.description)
                cellItem(label: "Alt description", value: viewModel.photo.altDescription)
                cellItem(label: "Likes", value: "\(viewModel.photo.totalLikes)")
            }
            
            Section("User") {
                cellItem(label: "ID", value: viewModel.photo.user.id)
                cellItem(label: "Username", value: viewModel.photo.user.username)
                cellItem(label: "Bio", value: viewModel.photo.user.bio)
                cellItem(label: "Location", value: viewModel.photo.user.location)
            }
            
            if let sponsor = viewModel.photo.sponsor {
                Section("Sponsor") {
                    cellItem(label: "ID", value: sponsor.id)
                    cellItem(label: "Username", value: sponsor.username)
                }
            }
           
            
        }
        .foregroundColor(Color.gray)
        .scrollContentBackground(.hidden)
        .background(Color.black)
    }
}

struct PhotoDetailView_Previews: PreviewProvider {
    
    static var viewModel: PhotoDetailViewModel {
        
        let imageStr = "https://images.unsplash.com/photo-1687360440984-3a0d7cfde903?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0ODcxOTB8MXwxfGFsbHwxfHx8fHx8Mnx8MTY5MTY3OTk4NXw&ixlib=rb-4.0.3&q=80&w=1080"
        
        let userVM = PhotoUserViewModel(id: "122",
                                        username: "username")
        let photoVM = PhotoViewModel(
            id: "12",
            title: "Title",
            imageURL: URL(string: imageStr)!,
            totalLikes: 12,
            isLiked: false,
            createdAt: .now,
            user: userVM
        )
        let vm = PhotoDetailViewModel(photo: photoVM)
        return vm
    }
    static var previews: some View {
        PhotoDetailView(viewModel: viewModel)
    }
}
