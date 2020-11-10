//
//  IssueEditViewController.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/11/09.
//

import UIKit

class IssueEditViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewBottom: NSLayoutConstraint!
    var issue: Issue?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextViewPlaceholder()
        configureNavigtaionBarTitle()
        setupNotification()
        
    }
    
    @IBAction func didTouchCancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func configureNavigtaionBarTitle() {
        if let issue = issue {
            title = "#\(issue.id)"
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        textViewBottom.constant = keyboardSize.height
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        textViewBottom.constant = 0
    }
    
}

extension IssueEditViewController: UITextViewDelegate {
    func configureTextViewPlaceholder() {
        textView.text = "코멘트는 여기에 작성하세요"
        textView.textColor = .secondaryLabel
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .secondaryLabel {
            textView.textColor = .label
            textView.text = nil
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            configureTextViewPlaceholder()
        }
    }
}
