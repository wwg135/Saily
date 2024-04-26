//
//  OperationConsoleController.swift
//  Chromatic
//
//  Created by Lakr Aream on 2021/8/25.
//  Copyright © 2021 Lakr Aream. All rights reserved.
//

import DropDown
import PropertyWrapper
import UIKit

class OperationConsoleController: UIViewController {
    var operationPayload: TaskProcessor.OperationPaylad? {
        didSet {
            debugPrint(operationPayload ?? "no payload")
        }
    }

    let padding = 15
    let textView = UITextView()
    let completeBox = UIView()
    let dropDownAnchor = UIView()
    
    @Atomic var dispatchOnce: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        isModalInPresentation = true
        view.backgroundColor = .systemBackground
        preferredContentSize = preferredPopOverSize
        title = NSLocalizedString("OPERATION", comment: "Operation")

        textView.backgroundColor = .clear
        textView.clipsToBounds = false

        textView.font = .monospacedSystemFont(ofSize: 12, weight: .bold)
        preferredContentSize = preferredPopOverSize

        textView.isEditable = false
        textView.textColor = UIColor(named: "TEXT_SUBTITLE")
        textView.contentInset = UIEdgeInsets(inset: 0)
        view.addSubview(textView)
        textView.snp.makeConstraints { x in
            x.top.equalTo(view.snp.top).offset(28)
            x.bottom.equalTo(view.snp.bottom).offset(-28)
            x.left.equalTo(view.snp.left)
            x.right.equalTo(view.snp.right)
        }

        if navigationController == nil {
            let bigTitle = UILabel()
            bigTitle.text = NSLocalizedString("OPERATION", comment: "Operation")
            bigTitle.font = .systemFont(ofSize: 28, weight: .bold)
            view.addSubview(bigTitle)
            bigTitle.snp.makeConstraints { x in
                x.leading.equalToSuperview().offset(padding)
                x.trailing.equalToSuperview().offset(-padding)
                x.top.equalToSuperview().offset(20)
                x.height.equalTo(40)
            }
            textView.clipsToBounds = true
            textView.snp.remakeConstraints { x in
                x.top.equalTo(bigTitle.snp.bottom).offset(20)
                x.bottom.equalTo(view.snp.bottom).offset(-28)
                x.left.equalTo(view.snp.left).offset(padding)
                x.right.equalTo(view.snp.right).offset(-padding)
            }
        }

        textView.text = NSLocalizedString("PREPARING_OPERATIONS", comment: "Preparing Operations")

        let completeIcon = UIImageView()
        let completeButton = UIButton()
        view.addSubview(completeBox)
        view.addSubview(completeButton)

        completeBox.snp.makeConstraints { x in
            x.trailing.equalToSuperview().offset(-20)
            x.bottom.equalToSuperview().offset(-50)
            x.width.equalTo(60)
            x.height.equalTo(60)
        }
        completeBox.addSubview(completeIcon)
        completeIcon.tintColor = .white
        completeIcon.image = UIImage(named: "exit")
        completeIcon.snp.makeConstraints { x in
            x.center.equalToSuperview()
            x.width.equalTo(60)
            x.height.equalTo(60)
        }
        completeButton.snp.makeConstraints { x in
            x.edges.equalTo(completeBox)
        }

        completeBox.alpha = 0
        completeBox.isUserInteractionEnabled = false

        completeButton.addTarget(self, action: #selector(exitButtonClicked), for: .touchUpInside)

        view.addSubview(dropDownAnchor)
        dropDownAnchor.snp.makeConstraints { x in
            x.right.equalTo(completeBox)
            x.width.equalTo(280)
            x.height.equalTo(0)
            x.bottom.equalTo(completeBox)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let operation = operationPayload else {
            #if DEBUG
                fatalError("payload required")
            #else
                dismiss(animated: true, completion: nil)
                return
            #endif
        }
        if dispatchOnce { return }
        dispatchOnce = true
        DispatchQueue.global().async {
            TaskProcessor.shared.beginOperation(operation: operation) { log in
                DispatchQueue.main.async { [self] in
                    appendLog(str: log)
                }
            }

            DispatchQueue.main.async {
                AuxiliaryExecuteWrapper.reloadSpringboard()
            }
        }
    }

    func appendLog(str: String) {
        textView.text += str
        let bottom = NSMakeRange(textView.text.count - 1, 1)
        textView.scrollRangeToVisible(bottom)
    }

    @objc
    func exitButtonClicked() {
        completeBox.shineAnimation()
        if operationPayload?.requiresRestart ?? false,
           !(operationPayload?.dryRun ?? false)
        {
            let alert = UIAlertController(title: "⚠️",
                                          message: NSLocalizedString("PROGRAM_UPGRADING_WILL_EXIT", comment: "Preparing application upgrade, will exit after complete"),
                                          preferredStyle: .alert)
            present(alert, animated: true, completion: {
                sleep(1)
                UIApplication.prepareForExitAndSuspend()
                sleep(1)
                AuxiliaryExecuteWrapper.rootspawn(command: AuxiliaryExecuteWrapper.uicache,
                                                  args: ["-p", Bundle.main.bundlePath],
                                                  timeout: 60) { _ in
                }
                exit(0)
            })
            return
        }
    }
}
