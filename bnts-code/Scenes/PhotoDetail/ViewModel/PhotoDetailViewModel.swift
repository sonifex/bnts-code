//
//  PhotoDetailViewModel.swift
//  bnts-code
//
//  Created by Soner Güler on 10/08/2023.
//

import Foundation
import os
import Combine

protocol PhotoDetailViewModeling {
    associatedtype PhotoItem: PhotoViewModeling & Identifiable
    
    var photo: PhotoItem { get }
    
    func viewDidLoad()
}

final class PhotoDetailViewModel: PhotoDetailViewModeling & ObservableObject {

    var photo: PhotoViewModel
    
    var coordinator: PhotosCoordinating?
    private lazy var cancellables = Set<AnyCancellable>()
    private lazy var logger = Logger(for: type(of: self))
    
    init(photo: PhotoViewModel) {
        self.photo = photo
    }
    
    func viewDidLoad() {
        
    }
}
