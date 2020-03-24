//
//  ViewController.swift
//  UISamplesIOS
//
//  Created by 鈴木孝宏 on 2019/12/11.
//  Copyright © 2019 鈴木孝宏. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var fontSize: CGFloat = 14
    var lineSpacing: CGFloat = 14
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setNotifications()
        initTextView()
        setTextAttribute(fontSize: fontSize, lineSpacing: lineSpacing)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? SettingViewController else {
            return
        }

        vc.delegate = self
        vc.initialFontSize = fontSize
        vc.initialLineSpacing = lineSpacing
    }

    private func setNotifications() {
        NotificationCenter.default.addObserver(self,
            selector: #selector(keyboardWillShow(sender:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(self,
            selector: #selector(keyboardWillHide(sender:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }

    @objc private func keyboardWillShow(sender: NSNotification) {
        let info = sender.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height

        textView.contentInset.bottom = keyboardSize + 20
    }

    @objc private func keyboardWillHide(sender: NSNotification) {
        textView.contentInset.bottom = view.safeAreaInsets.bottom + 20
    }

    private func initTextView() {
        textView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 34, right: 16)
        textView.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }

    private func setTextAttribute(fontSize: CGFloat, lineSpacing: CGFloat) {
        let text = textView.text!
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        let textAttributes: [NSAttributedString.Key : Any] = [
            .font : UIFont.systemFont(ofSize: fontSize),
            .paragraphStyle: paragraphStyle,
            .foregroundColor: UIColor.label
        ]
        let attributedText = NSAttributedString(string: text, attributes: textAttributes)
        textView.attributedText = attributedText

        label.text = "Font Size: \(fontSize), Line Spacing: \(lineSpacing)"
    }
}

extension ViewController: SettingViewControllerDelegate {
    func didSetProperties(fontSize: CGFloat, lineSpacing: CGFloat) {
        self.fontSize = fontSize
        self.lineSpacing = lineSpacing
        setTextAttribute(fontSize: fontSize, lineSpacing: lineSpacing)
    }
}

extension ViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
    }
}
