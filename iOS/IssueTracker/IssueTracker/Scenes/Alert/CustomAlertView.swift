//
//  CustomAlertView.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/05.
//

import UIKit

class CustomAlertView: UIView {
    private let xibName = "CustomAlertView"
    var contentView: UIView?
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

//    private func commonInit() {
//        guard let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as? UIView else { return }
//        view.layer.cornerRadius = 8.0
//        view.frame = self.bounds
//        self.addSubview(view)
//    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: xibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
}
