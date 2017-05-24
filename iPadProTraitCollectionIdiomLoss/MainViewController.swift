//
//  MainViewController.swift
//  iPadProTraitCollectionIdiomLoss
//
//  Created by Ada Turner on 5/23/17.
//  Copyright © 2017 Auswahlaxiom. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {

    // MARK: = UIViewController

    override func loadView() {
        super.loadView()

        setupBarButtons()
        setupPageViewController()
        setupChildViewControllers()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "iPad Pro Idiom Loss"
        view.backgroundColor = .magenta
        updateButtons()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        updateChildIdioms()
    }

    // MARK - MainViewController

    private func updateChildIdioms() {
        children.forEach { $0.updateIdiom() }
    }

    private func updateButtons() {
        let current = currentChild()
        forwardButton.isEnabled = current != children.last
        backwardButton.isEnabled = current != children.first
    }

    private func currentChild() -> ChildViewController? {
        return pageViewController.viewControllers?.first as? ChildViewController
    }

    // MARK: - Actions

    func forward(_ sender: UIBarButtonItem) {
        guard let current = currentChild(),
            current != children.last,
            let currentIndex = children.index(of: current) else { return }

        let nextIndex = children.index(after: currentIndex)

        pageViewController.setViewControllers([children[nextIndex]], direction: .forward, animated: true, completion: { _ in
            self.updateButtons()
        })
    }

    func backward(_ sender: UIBarButtonItem) {
        guard let current = currentChild(),
            current != children.first,
            let currentIndex = children.index(of: current) else { return }

        let prevIndex = children.index(before: currentIndex)

        pageViewController.setViewControllers([children[prevIndex]], direction: .reverse, animated: true, completion: { _ in
            self.updateButtons()
        })
    }

    // MARK: - Views

    private var forwardButton: UIBarButtonItem!
    private var backwardButton: UIBarButtonItem!
    private var pageViewController: UIPageViewController!
    private var children: [ChildViewController] = []

    private func setupBarButtons() {
        forwardButton = UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(forward))
        navigationItem.setRightBarButton(forwardButton, animated: false)

        backwardButton = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(backward))
        navigationItem.setLeftBarButton(backwardButton, animated: false)
    }

    private func setupPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false

        addChildViewController(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParentViewController: self)

        topLayoutGuide.bottomAnchor.constraint(equalTo: pageViewController.view.topAnchor).isActive = true
        bottomLayoutGuide.topAnchor.constraint(equalTo: pageViewController.view.bottomAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: pageViewController.view.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: pageViewController.view.rightAnchor).isActive = true
    }

    private func setupChildViewControllers() {
        let childA = ChildViewController(labelString: "A")
        let childB = ChildViewController(labelString: "B")
        children = [childA, childB]

        pageViewController.setViewControllers([childA], direction: .forward, animated: false, completion: nil)
    }
}

