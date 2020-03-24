//
//  SettingViewController.swift
//  UISamplesIOS
//
//  Created by 鈴木孝宏 on 2019/12/12.
//  Copyright © 2019 鈴木孝宏. All rights reserved.
//

import UIKit

protocol SettingViewControllerDelegate {
    func didSetProperties(fontSize: CGFloat, lineSpacing: CGFloat)
}

class SettingViewController: UITableViewController {

    var delegate: SettingViewControllerDelegate?
    var initialFontSize: CGFloat = 0
    var initialLineSpacing: CGFloat = 0

    @IBOutlet weak var fontSize: UITextField!
    @IBOutlet weak var lineSpacing: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        fontSize.keyboardType = .numberPad
        fontSize.text = NumberFormatter().string(from: initialFontSize as NSNumber)
        lineSpacing.keyboardType = .numberPad
        lineSpacing.text = NumberFormatter().string(from: initialLineSpacing as NSNumber)
    }

    override func viewWillDisappear(_ animated: Bool) {
        guard let fs = NumberFormatter().number(from: fontSize.text ?? "") as? CGFloat, let ls = NumberFormatter().number(from: lineSpacing.text ?? "") as? CGFloat else {
            return
        }

        delegate?.didSetProperties(fontSize: fs, lineSpacing: ls)
    }
}
