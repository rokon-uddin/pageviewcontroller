//
//  ViewController.swift
//  Pager
//
//  Created by Mohammed Rokon Uddin on 2/10/18.
//  Copyright © 2018 Monstar Lab Bangladesh Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var pageViewController: UIPageViewController = {
        let pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController
        return pageViewController
    }()

    let pageControl = UIPageControl(frame: .zero)
    var images: [UIImage] = [#imageLiteral(resourceName: "IMG_8787"), #imageLiteral(resourceName: "IMG_8777"), #imageLiteral(resourceName: "IMG_8788"), #imageLiteral(resourceName: "IMG_8776")]

    override func viewDidLoad() {
        super.viewDidLoad()

        let startingViewController = self.viewControllerAt(0)!
        pageViewController.setViewControllers([startingViewController], direction: .forward, animated: false) { (_) in }
        pageViewController.delegate = self
        pageViewController.dataSource = self

        pageViewController.view.frame = self.view.bounds

        self.addChild(pageViewController)
        self.view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)

        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        self.view.addSubview(pageControl)
        pageControl.frame = CGRect(x: 0, y: view.bounds.height - 64, width: view.bounds.width, height: 24)
    }

    func viewControllerAt(_ index: Int) -> PageContentViewController? {
        if images.indices.contains(index) {
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "PageContentViewController") as! PageContentViewController
            viewController.image = images[index]
            viewController.index = index
            return viewController
        } else {
            return nil
        }
    }
}

extension ViewController: UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            let index = (pageViewController.viewControllers?.first as! PageContentViewController).index
            pageControl.currentPage = index
        }
    }
}

extension ViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard var index = (viewController as? PageContentViewController)?.index else { return nil }
        index = ((index-1) < 0) ? (images.count - 1) : (index-1)
        return viewControllerAt(index)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard var index = (viewController as? PageContentViewController)?.index else { return nil }
        index = ((index+1) >= images.count) ? 0 : index+1
        return viewControllerAt(index)
    }


}

