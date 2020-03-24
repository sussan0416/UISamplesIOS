//
//  SampleCollectionViewController.swift
//  UISamplesIOS
//
//  Created by 鈴木孝宏 on 2020/03/20.
//  Copyright © 2020 鈴木孝宏. All rights reserved.
//

import UIKit
import FloatingPanel

class SampleCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private var flowLayout: UICollectionViewFlowLayout!
    private var fpc: FloatingPanelController!

    var minLineSpace: CGFloat = 0 {
        didSet {
            updateFlowLayout()
        }
    }
    var minInteritemSpace: CGFloat = 0 {
        didSet {
            updateFlowLayout()
        }
    }
    var itemsInRow: Int = 3 {
        didSet {
            updateFlowLayout()
        }
    }
    var horizontalContentInset: CGFloat = 0 {
        didSet {
            updateContentInsets()
        }
    }
    var verticalContentInset: CGFloat = 0 {
        didSet {
            updateContentInsets()
        }
    }
    var cornerRadiusRate: CGFloat = 0 {
        didSet {
            collectionView.reloadData()
        }
    }
    var needsAnimation: Bool = false

    private var images: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        fpc = FloatingPanelController()
        fpc.delegate = self

        let contentVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "CollectionSettingViewController") as! CollectionSettingViewController
        contentVC.collectionVC = self
        fpc.set(contentViewController: contentVC)
        fpc.addPanel(toParent: self)
        fpc.surfaceView.cornerRadius = 12

        for number in 0...19 {
            let name = String(format: "%02d", number)
            let image = UIImage(named: name)!
            images.append(image)
        }

        collectionView.dataSource = self
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateFlowLayout()
        updateContentInsets()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        fpc.removePanelFromParent(animated: true)
    }

    private func updateFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = minLineSpace
        flowLayout.minimumInteritemSpacing = minInteritemSpace

        let imageSize = (view.bounds.width
            - minInteritemSpace * (CGFloat(itemsInRow) - 1.0)
            - horizontalContentInset * 2.0) / CGFloat(itemsInRow)
        flowLayout.itemSize = CGSize(width: imageSize.rounded(.down), height: imageSize.rounded(.down))

        collectionView.setCollectionViewLayout(flowLayout, animated: needsAnimation)
    }

    private func updateContentInsets() {
        let h = horizontalContentInset
        let v = verticalContentInset
        let inset = UIEdgeInsets(top: v,
                                 left: h,
                                 bottom: v,
                                 right: h)
        collectionView.contentInset = inset
    }
}

extension SampleCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SampleCollectionViewCell", for: indexPath) as! SampleCollectionViewCell

        cell.imageView.image = images[indexPath.row % 20]
        cell.cornerRadiusRate = cornerRadiusRate
        return cell
    }
}

extension SampleCollectionViewController: FloatingPanelControllerDelegate {
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        return MyFloatingPanelLayout()
    }
}

class MyFloatingPanelLayout: FloatingPanelLayout {
    public var initialPosition: FloatingPanelPosition {
        return .half
    }

    public func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
            case .full: return 16.0 // A top inset from safe area
            case .half: return 300.0 // A bottom inset from the safe area
            case .tip: return 44.0 // A bottom inset from the safe area
            default: return nil // Or `case .hidden: return nil`
        }
    }
}

class SampleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    var cornerRadiusRate: CGFloat = 0

    override func prepareForReuse() {
        imageView.image = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = frame.width * cornerRadiusRate
        contentView.layer.masksToBounds = true
    }
}
