//
//  ChildViewController.swift
//  iPadProTraitCollectionIdiomLoss
//
//  Created by Ada Turner on 5/23/17.
//  Copyright © 2017 Auswahlaxiom. All rights reserved.
//

import UIKit

final class ChildViewController: UIViewController,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout,
    UICollectionViewDelegate {

    // MARK: - Lifetime

    init(labelString: String) {
        self.labelString = labelString

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIViewController

    override func loadView() {
        super.loadView()

        setupCollectionView()
        setupLabels()
        view.backgroundColor = UIColor(red: rand(), green: rand(), blue: rand(), alpha: 1.0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        updateIdiom()
        collectionView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        isViewVisible = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        isViewVisible = false
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        print("Child \(labelString) trait collection did change")
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        shouldResizeCollectionView = true
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        if shouldResizeCollectionView {
            collectionView.collectionViewLayout.invalidateLayout()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        updateIdiom()

        if shouldResizeCollectionView {
            shouldResizeCollectionView = false

            collectionView.performBatchUpdates({}, completion: nil)
        }
    }

    // MARK: - ChildViewController

    let labelString: String

    private var shouldResizeCollectionView: Bool = false
    private(set) var isViewVisible: Bool = false

    func updateIdiom() {
        let idiom: String

        switch traitCollection.userInterfaceIdiom {
        case .unspecified: idiom = "unspecified"
        case .phone: idiom = "phone"
        case .pad: idiom = "pad"
        case .tv: idiom = "tv"
        case .carPlay: idiom = "carPlay"
        }

        print("Child \(labelString) idiom: \(idiom)")

        if isViewLoaded {
            let isLandscape = UIApplication.isLandscape(for: view.frame.size)
            idiomLabel.text = idiom
            flowLayout.sectionInset = isLandscape ? UIEdgeInsets(top: 100, left: 10, bottom: 100, right: 10) : UIEdgeInsets(top: 10, left: 100, bottom: 10, right: 100)
            flowLayout.scrollDirection = isLandscape ? .horizontal : .vertical
            collectionView.contentInset = isLandscape ? UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0) : UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
            collectionView.reloadData()
        }
    }

    private func rand() -> CGFloat {
        let r = max(0.0, min(1.0, (Double(arc4random()) / Double(UInt32.max)) + 0.5) - 0.1)

        return CGFloat(r)
    }

    // MARK: - UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.white.cgColor

        return cell
    }

    // MARK: - Views

    private var idiomLabel: UILabel!
    private var collectionView: UICollectionView!
    private var flowLayout: UICollectionViewFlowLayout!

    private func setupLabels() {
        let label = UILabel()
        label.text = labelString
        label.font = UIFont.boldSystemFont(ofSize: 50.0)
        label.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(label)
        view.centerXAnchor.constraint(equalTo: label.centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: label.centerYAnchor).isActive = true

        idiomLabel = UILabel()
        idiomLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(idiomLabel)
        label.centerXAnchor.constraint(equalTo: idiomLabel.centerXAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: idiomLabel.topAnchor).isActive = true
    }

    private func setupCollectionView() {
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 6.0
        flowLayout.minimumLineSpacing = 10.0
        flowLayout.itemSize = CGSize(width: 42, height: 42)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(collectionView)

        topLayoutGuide.bottomAnchor.constraint(equalTo: collectionView.topAnchor).isActive = true
        bottomLayoutGuide.topAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: collectionView.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: collectionView.rightAnchor).isActive = true
    }
}
