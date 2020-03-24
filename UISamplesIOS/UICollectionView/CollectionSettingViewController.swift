//
//  CollectionSettingViewController.swift
//  UISamplesIOS
//
//  Created by 鈴木孝宏 on 2020/03/20.
//  Copyright © 2020 鈴木孝宏. All rights reserved.
//

import UIKit

class CollectionSettingViewController: UIViewController {

    var collectionVC: SampleCollectionViewController?

    @IBOutlet weak var hInsetValueLabel: UILabel!
    @IBOutlet weak var interitemSpaceLabel: UILabel!
    @IBOutlet weak var lineSpaceLabel: UILabel!
    @IBOutlet weak var cornerRadiusLabel: UILabel!
    @IBOutlet weak var itemNumsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func itemNumsChanged(_ sender: UISlider) {
        let rounded = sender.value.rounded()
        collectionVC?.itemsInRow = Int(rounded)
        sender.value = rounded
        itemNumsLabel.text = String(format: "%.0f", rounded)
    }

    @IBAction func hInsetChanged(_ sender: UISlider) {
        let rounded = sender.value.rounded()
        collectionVC?.horizontalContentInset = CGFloat(rounded)
        sender.value = rounded
        hInsetValueLabel.text = String(format: "%.0f", rounded)
    }
    @IBAction func interItemSpaceChanged(_ sender: UISlider) {
        let rounded = sender.value.rounded()
        collectionVC?.minInteritemSpace = CGFloat(rounded)
        sender.value = rounded
        interitemSpaceLabel.text = String(format: "%.0f", rounded)
    }
    @IBAction func lineSpaceChanged(_ sender: UISlider) {
        let rounded = sender.value.rounded()
        collectionVC?.minLineSpace = CGFloat(rounded)
        sender.value = rounded
        lineSpaceLabel.text = String(format: "%.0f", rounded)
    }

    @IBAction func cornerRadiusChanged(_ sender: UISlider) {
        collectionVC?.cornerRadiusRate = CGFloat(sender.value / 100)
        cornerRadiusLabel.text = String(format: "%.0f", sender.value)
    }

    @IBAction func changeAnimationSwitch(_ sender: UISwitch) {
        collectionVC?.needsAnimation = sender.isOn
    }
}
