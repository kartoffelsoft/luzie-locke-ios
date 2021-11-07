//
//  SwipeImageViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 02.11.21.
//

import UIKit

class SwipeImageViewController: UIPageViewController {

  private let viewModel: SwipeImageViewModel
  
  fileprivate var controllers: [UIViewController]? {
    didSet {
      if let controllers = controllers {
        setViewControllers([controllers.first!], direction: .forward, animated: false)
        configureLayout(numberOfImages: controllers.count)
      }
    }
  }
  
  private let pagerStackView  = UIStackView(arrangedSubviews: [])

  private let onColor         = UIColor.white
  private let offColor        = UIColor(white: 0, alpha: 0.1)

  init(viewModel: SwipeImageViewModel) {
    self.viewModel = viewModel
    super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    dataSource  = self
    delegate    = self
    
    configureBindables()
  }
  
  private func configureLayout(numberOfImages: Int) {
    for _ in 1...numberOfImages {
      let barView                 = UIView()
      barView.backgroundColor     = offColor
      barView.layer.cornerRadius  = 5
      barView.widthAnchor.constraint(equalToConstant: 10).isActive = true
      pagerStackView.addArrangedSubview(barView)
    }
    
    pagerStackView.translatesAutoresizingMaskIntoConstraints  = false
    pagerStackView.arrangedSubviews.first?.backgroundColor    = onColor
    pagerStackView.spacing                                    = 5
    pagerStackView.distribution                               = .fillEqually
    
    view.addSubview(pagerStackView)
    
    NSLayoutConstraint.activate([
      pagerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      pagerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      pagerStackView.heightAnchor.constraint(equalToConstant: 10),
    ])
  }
  
  func configureBindables() {
    controllers = viewModel.bindableControllers.value
    viewModel.bindableControllers.bind { [weak self] controllers in
      self?.controllers = controllers
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension SwipeImageViewController: UIPageViewControllerDataSource {
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let controllers = controllers else { return nil }
    let index = controllers.firstIndex(where: {$0 == viewController}) ?? 0
    if index == 0 { return nil }
    return controllers[index - 1]
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let controllers = controllers else { return nil }
    let index = controllers.firstIndex(where: {$0 == viewController}) ?? 0
    if index == (controllers.count - 1) { return nil }
    return controllers[index + 1]
  }
}

extension SwipeImageViewController: UIPageViewControllerDelegate {
  func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    guard let controllers = controllers else { return }
    let currentPhotoViewController = viewControllers?.first
    if let index = controllers.firstIndex(where: { $0 == currentPhotoViewController }) {
      pagerStackView.arrangedSubviews.forEach({ $0.backgroundColor = offColor })
      pagerStackView.arrangedSubviews[index].backgroundColor = .white
    }
  }
}
