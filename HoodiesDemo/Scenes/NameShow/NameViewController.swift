//
//  NameViewController.swift
//  HoodiesDemo
//
//  Created by Sergey Monastyrskiy on 14.05.2020.
//  Copyright © 2020 Sergey Monastyrskiy. All rights reserved.
//

import UIKit

enum ModeType {
    case add
    case edit
}

class NameViewController: UIViewController {
    // MARK: - Properties
    var mode: ModeType
    lazy var nameTextField: UITextField = {
        let nameTextFieldInstance = UITextField()
        nameTextFieldInstance.placeholder = "enter item name".localize()
        nameTextFieldInstance.font = .systemFont(ofSize: 20.0, weight: .medium)
        nameTextFieldInstance.keyboardType = .default
        nameTextFieldInstance.borderStyle = .roundedRect
        nameTextFieldInstance.clearButtonMode = .whileEditing
        
        nameTextFieldInstance.delegate = self
        
        return nameTextFieldInstance
    }()
    
    
    // MARK: - Initialization
    init(modeType: ModeType = .add) {
        self.mode = modeType
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Class functions
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    
    // MARK: - custom functions
    private func setupView() {
        self.title = (self.mode == .add ? "add" : "edit").localize()
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(image: UIImage(named: "icon-back-black"), style: .plain, target: self, action: #selector(backBarButtonTapped))
        self.navigationItem.leftBarButtonItem = newBackButton

        view.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60.0),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64.0),
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            nameTextField.heightAnchor.constraint(equalToConstant: 54.0)
        ])

        let buttonsStackView = UIStackView()
        buttonsStackView.axis = .horizontal
        buttonsStackView.alignment = .center
        buttonsStackView.distribution = .fillProportionally
        buttonsStackView.spacing = 20.0
        
        let doneButton = ActionButton(frame: .zero, title: "done", titleColor: .black, actionHandler: {
            Logger.log(message: "done", event: .debug)

        })

        let revertButton = ActionButton(frame: .zero, title: "revert", titleColor: .red, borderColor: .red, actionHandler: {
            Logger.log(message: "revert", event: .debug)
            self.navigationController?.popViewController(animated: true)
        })

        buttonsStackView.addArrangedSubview(revertButton)
        buttonsStackView.addArrangedSubview(doneButton)

        view.addSubview(buttonsStackView)
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32.0),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32.0),
            buttonsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -69.0)
        ])
        
        // Add tap
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTepped))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    
    // MARK: - Actions
    @objc func viewTepped(_ sender: UIView) {
        self.nameTextField.resignFirstResponder()
    }
    
    @objc func backBarButtonTapped(_ sender: UIBarButtonItem) {
        Logger.log(message: "run", event: .debug)
        
        guard self.nameTextField.text == "" else {
            self.showAlert(withTitle: "info".localize(),
                           withMessage: "please, select `Done` button".localize())
            
            return
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}


// MARK: - UITextFieldDelegate
extension NameViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = nil
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
