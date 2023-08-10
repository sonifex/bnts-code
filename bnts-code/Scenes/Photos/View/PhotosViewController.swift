//
//  ViewController.swift
//  bnts-code
//
//  Created by Soner Güler on 10/08/2023.
//

import UIKit
import SwiftUI
import Combine

final class PhotosViewController<ViewModel: PhotosViewModeling & ObservableObject>: UIViewController {
    
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        configureView()
    }
    
}

private extension PhotosViewController {
    func configureView() {
        let hostingVC = UIHostingController(rootView: PhotosView(viewModel: viewModel))
        addChild(hostingVC)
        view.addSubview(hostingVC.view)
        hostingVC.didMove(toParent: self)
        hostingVC.view.edgesToSuperview()
    }
}

