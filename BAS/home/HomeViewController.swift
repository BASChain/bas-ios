//
//  HomeViewController.swift
//  BAS
//
//  Created by hyperorchid on 2020/4/12.
//  Copyright © 2020 com.baschain. All rights reserved.
//

import UIKit

class HomeViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        // Do any additional setup after loading the view.
        
        
        if let firstViewController = orderedViewControllers.first {
               setViewControllers([firstViewController],
                                  direction: .forward,
                                  animated: true,
                                  completion: nil)
                setTitle(0)
           }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
        private(set) lazy var orderedViewControllers: [UIViewController] = {
            return [self.newColoredViewController("SubDomainViewController"),
                self.newColoredViewController("TopRootDomainViewController"),
                self.newColoredViewController("NormalRootDomainViewController")]
        }()

        private func newColoredViewController(_ name: String) -> UIViewController {
            return UIStoryboard(name: "Main", bundle: nil) .
                instantiateViewController(withIdentifier: name)
        }
        let Titles = ["SubDomain","TopRoot","NormalRoot"]
        private func setTitle(_ idx:Int){
                self.navigationItem.title = Titles[idx]
        }
}
// MARK: UIPageViewControllerDataSource
extension HomeViewController: UIPageViewControllerDataSource {
 
        func pageViewController(_ pageViewController: UIPageViewController,
                                viewControllerBefore viewController: UIViewController) -> UIViewController? {
                
                guard let viewControllerIndex = orderedViewControllers.firstIndex(of:viewController) else {
                    return nil
                }
                
                let previousIndex = viewControllerIndex - 1
                
                guard previousIndex >= 0 else {
                    return nil
                }
                
                guard orderedViewControllers.count > previousIndex else {
                    return nil
                }
                
                setTitle(viewControllerIndex)
                return orderedViewControllers[previousIndex]
    }
    
        func pageViewController(_ pageViewController: UIPageViewController,
                                viewControllerAfter viewController: UIViewController) -> UIViewController? {
                guard let viewControllerIndex = orderedViewControllers.firstIndex(of:viewController) else {
                    return nil
                }
                
                let nextIndex = viewControllerIndex + 1
                let orderedViewControllersCount = orderedViewControllers.count

                guard orderedViewControllersCount != nextIndex else {
                    return nil
                }
                
                guard orderedViewControllersCount > nextIndex else {
                    return nil
                }
                setTitle(viewControllerIndex)
                return orderedViewControllers[nextIndex]
    }
    
}
