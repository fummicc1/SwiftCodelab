//
//  ViewController.swift
//  UIButtonSubviews
//
//  Created by Fumiya Tanaka on 2020/03/14.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import UIKit

// PureButton is easy to use. Just a UIButton.
/*
 Button has customView as its subview.
 Currently, this is not useful because Self(Button) does not nothing to perform.
 As Button is subclass of UIButton, it should handle events regardless of subviews.
 
 Solution: set `isUserInteractionEnabled` false.
 Solution: override `hitTest`.
*/

class ViewController: UIViewController {

    private lazy var pureButton: UIButton = {
        let title = "Pure Yellow Button"
        let content = instantiateUIButton(title: title)
        content.backgroundColor = UIColor.systemOrange
        content.layer.cornerRadius = 4
        content.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return content
    }()
    
    private lazy var button: Button = {
        let content = Button(frame: .zero, contentView: instantiateUIButton(title: "Custom Yellow Button"))
        content.translatesAutoresizingMaskIntoConstraints = false
        content.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return content
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(pureButton)
        view.addSubview(button)
        NSLayoutConstraint.activate([
            pureButton.widthAnchor.constraint(equalToConstant: pureButton.intrinsicContentSize.width + 20),
            pureButton.heightAnchor.constraint(equalToConstant: pureButton.intrinsicContentSize.height + 20),
            pureButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: pureButton.bottomAnchor, constant: 16),
            button.centerXAnchor.constraint(equalTo: pureButton.centerXAnchor)
        ])
    }
    
    private func instantiateUIButton(title: String? = nil, image: UIImage? = nil) -> UIButton {
        let content = UIButton()
        content.translatesAutoresizingMaskIntoConstraints = false
        if let title = title {
            content.setAttributedTitle(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)]), for: .normal)
        }
        return content
    }

    @objc private func buttonTapped(_ sender: UIButton) {
        if sender == button {
            (button.contentView as? UIButton)?.setImage(UIImage(systemName: "bolt"), for: .normal)
        } else if sender == pureButton {
            pureButton.setImage(UIImage(systemName: "flame"), for: .normal)
        }
    }
}

class Button: UIButton {
    private(set) var contentView: UIView
    
    init(frame: CGRect, contentView: UIView) {
        self.contentView = contentView
        super.init(frame: frame)
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        expandConstraintsOfContentView()
//        solution1()
    }
    
    required init?(coder: NSCoder) {
        contentView = UIView()
        super.init(coder: coder)
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        expandConstraintsOfContentView()
//        solution1()
    }
    
    // Solution1
    private func solution1() {
        contentView.isUserInteractionEnabled = false
    }
    
    // Solution2
    // control event handling.
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        let view = super.hitTest(point, with: event)
        
        if view == contentView {
            return self
        }
        
        return view
    }
    
    private func expandConstraintsOfContentView() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            widthAnchor.constraint(equalToConstant: contentView.intrinsicContentSize.width + 20),
            heightAnchor.constraint(equalToConstant: contentView.intrinsicContentSize.height + 20),
        ])
    }
}
