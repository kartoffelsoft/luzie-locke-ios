//
//  ItemCreateViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 26.10.21.
//

import UIKit

class ItemCreateViewController: UIViewController {

  enum Section: Int {
    case imageSelect = 0, title, price, description
    static var numberOfSections: Int { return 4 }
  }
  
  static let headerId = "HeaderId"
  
  private let viewModel: ItemCreateViewModel
  
  private var collectionView: UICollectionView!
  
  init(viewModel: ItemCreateViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    self.viewModel.delegate = self
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    configureNavigationBar()
    configureCollectionView()
    configureBindables()
  }

  private func configureNavigationBar() {
    if let navigationController = navigationController,
       let image = CustomGradient.navBarBackground(on: navigationController.navigationBar) {
      navigationController.navigationBar.barTintColor = UIColor(patternImage: image)
    }
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: Images.upload, style: .plain, target: self, action: #selector(handleUpload))
  }

  private func configureCollectionView() {
    let padding: CGFloat    = 15
    let flowLayout          = UICollectionViewFlowLayout()
    flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    flowLayout.itemSize     = CGSize(width: view.bounds.width - padding * 2, height: 100)
    
    let layout = UICollectionViewCompositionalLayout { section, env in
      let padding: CGFloat = 8
      switch(Section(rawValue: section)) {
      case .imageSelect:
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: padding, leading: padding, bottom: padding, trailing: padding)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return section
        
      case .title:
        fallthrough
        
      case .price:
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: padding, leading: padding, bottom: padding, trailing: padding)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return section
        
      case .description:
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: padding, leading: padding, bottom: padding, trailing: padding)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(310)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return section
        
      default:
        return nil
      }
    }
    
    collectionView            = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
    collectionView.delegate   = self
    collectionView.dataSource = self
    
    collectionView.register(ImageSelectCell.self, forCellWithReuseIdentifier: ImageSelectCell.reuseIdentifier)
    collectionView.register(TextInputCell.self, forCellWithReuseIdentifier: TextInputCell.reuseIdentifier)
    collectionView.register(DecimalInputCell.self, forCellWithReuseIdentifier: DecimalInputCell.reuseIdentifier)
    collectionView.register(MultiLineTextInputCell.self, forCellWithReuseIdentifier: MultiLineTextInputCell.reuseIdentifier)
    
    view.addSubview(collectionView)
    
    if let image = CustomGradient.mainBackground(on: collectionView) {
      collectionView.backgroundColor = UIColor(patternImage: image)
    }
  }
  
  func configureBindables() {
    viewModel.bindableIsLoading.bind { [weak self] isLoading in
      guard let isLoading = isLoading else { return }
      
      if isLoading {
        self?.showLoadingView()
      } else {
        self?.dismissLoadingView()
      }
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension ItemCreateViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    switch Section(rawValue: indexPath.section) {
    case .imageSelect:
      ()
    case .title:
      ()
    case .price:
      ()
    case .description:
      ()
    default:
      ()
    }
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return Section.numberOfSections
  }
  
  @objc private func handleUpload() {
    viewModel.upload { [weak self] result in
      switch result {
      case .success: ()
      case .failure(let error):
        self?.presentAlertOnMainThread(title: "Unable to proceed",
                                       message: error.rawValue,
                                       buttonTitle: "OK")
      }
    }
  }
}

extension ItemCreateViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch Section(rawValue: indexPath.section) {
    case .imageSelect:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageSelectCell.reuseIdentifier, for: indexPath) as! ImageSelectCell
      cell.viewModel    = viewModel.imageSelectViewModel
      return cell
    case .title:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextInputCell.reuseIdentifier, for: indexPath) as! TextInputCell
      cell.placeholder  = "Title"
      cell.viewModel    = viewModel.titleViewModel
      return cell
    case .price:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DecimalInputCell.reuseIdentifier, for: indexPath) as! DecimalInputCell
      cell.placeholder  = "Price"
      cell.viewModel    = viewModel.priceViewModel
      return cell
    case .description:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MultiLineTextInputCell.reuseIdentifier, for: indexPath) as! MultiLineTextInputCell
      cell.placeholder  = "Description"
      cell.viewModel    = viewModel.descriptionViewModel
      return cell
    default:
      return  UICollectionViewCell()
    }
  }
}

extension ItemCreateViewController: ItemCreateViewModelDelegate {
  
  func didOpenImagePicker(controller: UIImagePickerController) {
    present(controller, animated: true)
  }
  
  func didCloseImagePicker() {
    dismiss(animated: true)
  }
}
