//
//  ViewController.swift
//  UIKitMaraphone_3
//
//  Created by Anas Ben mustafa on 2/9/24.
//

import UIKit

class ViewController: UIViewController {

    var square: UIView = {
        let square = UIView()
        square.backgroundColor = .systemBlue
        square.translatesAutoresizingMaskIntoConstraints = false
        square.layer.cornerRadius = 16
        return square
    }()

    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(sliderValueDidChange(_:)), for: .valueChanged)
        slider.addTarget(self, action: #selector(userDidTouchUpSlider(_:)), for: .touchUpInside)
        return slider
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)

        view.addSubview(slider)
        view.addSubview(square)

        NSLayoutConstraint.activate([
            square.widthAnchor.constraint(equalToConstant: 100),
            square.heightAnchor.constraint(equalToConstant: 100),
            square.bottomAnchor.constraint(equalTo: slider.topAnchor, constant: -64),
            square.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            slider.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            slider.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }

    @objc private func sliderValueDidChange(_ sender: UISlider) {
        let rotationValue = CGFloat(slider.value) * (.pi / 2)
        let scaleValue = CGFloat(slider.value) * 0.5 + 1
        square.transform = CGAffineTransform(
            rotationAngle: rotationValue
        ).scaledBy(x: scaleValue, y: scaleValue)

        let minValue = view.layoutMargins.left + square.frame.width / 2
        let maxValue = view.frame.width - view.layoutMargins.right - square.frame.width / 2
        self.square.center.x = minValue + (maxValue - minValue) * CGFloat(sender.value)
    }

    @objc func userDidTouchUpSlider(_ sender: UISlider) {
        sender.setValue(sender.maximumValue, animated: true)
        UIView.animate(withDuration: 0.5) {
            self.sliderValueDidChange(sender)
        }
    }

}

