//
//  IssueEditViewController.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/11/09.
//

import UIKit
import MarkdownKit

protocol IssueEditDelegate: class {
    //issue 추가/수정 여부는 delegate에서 처리
    func didTouchSendButton(issueTitle: String, issuePreview: String)
}

class IssueEditViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var previewTextView: UITextView!
    @IBOutlet weak var textViewBottom: NSLayoutConstraint!
    @IBOutlet weak var sendButton: UIBarButtonItem!
    var issue: Issue?
    let markdownParser = MarkdownParser(font: UIFont.systemFont(ofSize: CGFloat(17)))
    var markdownString = ""
    weak var delegate: IssueEditDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextViewPlaceholder()
        configureNavigtaionBarTitle()
        configureToolbar()
        configureTitleTextField()
        setupNotification()
    }
    
    @IBAction func didTouchCancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTouchSendButton(_ sender: Any) {
        guard let titleText = titleTextField.text,
              let previewText = previewTextView.text else { return }
        delegate?.didTouchSendButton(issueTitle: titleText, issuePreview: previewText)
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
    
    @IBAction func didSegmentedControlChangeValue(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            previewTextView.text = markdownString
            previewTextView.isEditable = true
        case 1:
            markdownString = previewTextView.text
            previewTextView.attributedText = markdownParser.parse(markdownString)
            previewTextView.isEditable = false
        default:
            break
        }
    }
    
    @objc func didTouchBoldButton() {
        previewTextView.insertText("****")
        moveCursorToLeft(by: -2)
    }
    
    @objc func didTouchItalicButton() {
        previewTextView.insertText("__")
        moveCursorToLeft(by: -1)
    }
    
    @objc func didTouchPhotoButton() {
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let titleText = textField.text else { return }
        sendButton.isEnabled = !titleText.isEmpty
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
        previewTextView.text = "코멘트는 여기에 작성하세요 (선택 사항)"
        previewTextView.textColor = .secondaryLabel
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

// UIBarButtonItem 관련 함수
extension IssueEditViewController {
    
    func configureToolbar() {
        let toolbar: UIToolbar = UIToolbar()
        toolbar.sizeToFit()
        let boldButton = UIBarButtonItem(image: UIImage(systemName: "bold"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(didTouchBoldButton))
        let italicButton = UIBarButtonItem(image: UIImage(systemName: "italic"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(didTouchItalicButton))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                     target: nil,
                                     action: nil)
        let photoButton = UIBarButtonItem(image: UIImage(systemName: "photo.fill.on.rectangle.fill"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(didTouchPhotoButton))
        configure(barButtons: [boldButton, italicButton, photoButton])
    
        toolbar.items = [boldButton, italicButton, spacer, photoButton]
        previewTextView.inputAccessoryView = toolbar
    }
    
    func configure(barButtons: [UIBarButtonItem]) {
        barButtons.forEach { (barButton) in
            barButton.tintColor = .black
            barButton.width = 60
        }
    }

    func moveCursorToLeft(by amount: Int) {
        guard let selectedRange = previewTextView.selectedTextRange,
              let newPosition = previewTextView.position(from: selectedRange.start, offset: amount) else { return }
        previewTextView.selectedTextRange = previewTextView.textRange(from: newPosition, to: newPosition)
    }
}

//TitleTextField관련 함수
extension IssueEditViewController {
    
    func configureTitleTextField() {
        titleTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
}
