//
//  SettingApplication.swift
//  Chromatic
//
//  Created by Lakr Aream on 2021/8/28.
//  Copyright © 2021 Lakr Aream. All rights reserved.
//

import Bugsnag
import SPIndicator
import UIKit

extension SettingView {
    func setupApplicationView(anchor: inout UIView, safeAnchor: UIView) {
        // MARK: - HEADLINE

        let headline = UILabel()
        headline.font = .systemFont(ofSize: 18, weight: .semibold)
        headline.text = NSLocalizedString("ACTIONS", comment: "Actions")
        addSubview(headline)
        headline.snp.makeConstraints { x in
            x.left.equalTo(safeAnchor)
            x.right.equalTo(safeAnchor)
            x.top.equalTo(anchor.snp.bottom).offset(10)
            x.height.equalTo(40)
        }
        anchor = headline

        // MARK: - CONTENT

        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(named: "CARD_BACKGROUND")
        backgroundView.layer.cornerRadius = 12
        //        backgroundView.dropShadow()
        let enableShareSheet = SettingElement(iconSystemNamed: "square.and.arrow.up.on.square.fill",
                                              text: NSLocalizedString("ENABLE_SHARE_SHEET", comment: "Enable Share Sheet"),
                                              dataType: .switcher)
        {
            InterfaceBridge.enableShareSheet ? "YES" : "NO"
        } withAction: { changeValueTo, _ in
            if changeValueTo ?? false {
                let alert = UIAlertController(title: "⚠️",
                                              message: NSLocalizedString("ENABLE_SHARE_SHEET_MAY_CRASH_THE_APP", comment: "Enable share sheet may crash the app"),
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("CONFIRM", comment: "Confirm"),
                                              style: .destructive,
                                              handler: { _ in
                                                  InterfaceBridge.enableShareSheet = true
                                                  self.dispatchValueUpdate()
                                              }))
                alert.addAction(UIAlertAction(title: NSLocalizedString("CANCEL", comment: "Cancel"),
                                              style: .cancel, handler: { _ in
                                                  self.dispatchValueUpdate()
                                              }))
                self.parentViewController?.present(alert, animated: true, completion: nil)
            } else {
                InterfaceBridge.enableShareSheet = false
                self.dispatchValueUpdate()
            }
        }

        let enableQuickMode = SettingElement(iconSystemNamed: "hare",
                                             text: NSLocalizedString("ENABLE_QUICK_MODE", comment: "Enable Quick Mode"),
                                             dataType: .switcher)
        {
            InterfaceBridge.enableQuickMode ? "YES" : "NO"
        } withAction: { changeValueTo, _ in
            if changeValueTo ?? false {
                InterfaceBridge.enableQuickMode = true
                self.dispatchValueUpdate()
            } else {
                InterfaceBridge.enableQuickMode = false
                self.dispatchValueUpdate()
            }
        }

        let enableDefaultSource = SettingElement(iconSystemNamed: "plus",
                                             text: NSLocalizedString("ENABLE_ADD_DEFAULT_SOURCE", comment: "Enable Add Default Source"),
                                             dataType: .switcher) {
            InterfaceBridge.enableDefaultSource ? "YES" : "NO"
        } withAction: { changeValueTo, _ in
            if changeValueTo ?? false {
                InterfaceBridge.enableDefaultSource = true
                self.dispatchValueUpdate()
            } else {
                InterfaceBridge.enableDefaultSource = false
                self.dispatchValueUpdate()
            }
        }
        

#if DEBUG
        let crashApp = SettingElement(iconSystemNamed: "xmark.octagon.fill",
                                      text: "EXEC_BAD_ACCESS",
                                      dataType: .submenuWithAction, initData: nil) { _, _ in
            fatalError("simulated application crash by user", file: #file, line: #line)
        }
#endif
        let doUicache = SettingElement(iconSystemNamed: "square.grid.2x2",
                                       text: NSLocalizedString("REBUILD_ICONS", comment: "Rebuild Icons"),
                                       dataType: .submenuWithAction,
                                       initData: nil)
        { _, anchor in
            self.dropDownConfirm(anchor: anchor,
                                 text: NSLocalizedString("REBUILD_ICONS", comment: "Rebuild Icons"))
            { [weak self] in
                let alert = UIAlertController(title: "⚠️",
                                              message: NSLocalizedString("RELOAD_ICON_CACHE_TASKES_TIME", comment: "Reloading home screen icons will take some time"),
                                              preferredStyle: .alert)
                self?.parentViewController?.present(alert, animated: true) {
                    DispatchQueue.global().async {
                        AuxiliaryExecuteWrapper.rootspawn(command: AuxiliaryExecuteWrapper.uicache,
                                                          args: ["--all"],
                                                          timeout: 120,
                                                          output: { _ in })
                        AuxiliaryExecuteWrapper.rootspawn(command: "exec-uicache",
                                                          args: [],
                                                          timeout: 120,
                                                          output: { _ in })
                        DispatchQueue.main.async {
                            alert.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }
        }
        let doRespring = SettingElement(iconSystemNamed: "rays",
                                        text: NSLocalizedString("RELOAD_DESKTOP", comment: "Reload Desktop"),
                                        dataType: .submenuWithAction,
                                        initData: nil)
        { _, anchor in
            self.dropDownConfirm(anchor: anchor,
                                 text: NSLocalizedString("RELOAD_DESKTOP", comment: "Reload Desktop"))
            {
                UIApplication.prepareForExitAndSuspend()
                sleep(1)
                AuxiliaryExecuteWrapper.reloadSpringboard()
            }
        }
        let doReloadAirDrop = SettingElement(iconSystemNamed: "rays",
                                             text: NSLocalizedString("RELOAD_AIRDROP", comment: "Reload AirDrop"),
                                             dataType: .submenuWithAction,
                                             initData: nil)
        { _, anchor in
            self.dropDownConfirm(anchor: anchor,
                                 text: NSLocalizedString("RELOAD_AIRDROP", comment: "Reload AirDrop"))
            {
                AuxiliaryExecuteWrapper.reloadAirDrop()
            }
        }
        let safemode = SettingElement(iconSystemNamed: "shield",
                                      text: NSLocalizedString("ENTER_SAFE_MODE", comment: "Enter Safe Mode"),
                                      dataType: .submenuWithAction,
                                      initData: nil)
        { _, anchor in
            self.dropDownConfirm(anchor: anchor,
                                 text: NSLocalizedString("ENTER_SAFE_MODE", comment: "Enter Safe Mode"))
            {
                UIApplication.prepareForExitAndSuspend()
                sleep(1)
                AuxiliaryExecuteWrapper.rootspawn(command: AuxiliaryExecuteWrapper.killall,
                                                  args: ["-SEGV", "SpringBoard"],
                                                  timeout: 1)
                { _ in
                }
            }
        }
        let doUicacheQuick = SettingElement(iconSystemNamed: "square.grid.2x2",
                                            text: NSLocalizedString("REBUILD_ICONS", comment: "Rebuild Icons"),
                                            dataType: .submenuWithAction,
                                            initData: nil)
        { _, _ in
            let alert = UIAlertController(title: "⚠️",
                                          message: NSLocalizedString("RELOAD_ICON_CACHE_TASKES_TIME", comment: "Reloading home screen icons will take some time"),
                                          preferredStyle: .alert)
            self.parentViewController?.present(alert, animated: true) {
                DispatchQueue.global().async {
                    AuxiliaryExecuteWrapper.rootspawn(command: AuxiliaryExecuteWrapper.uicache,
                                                      args: ["--all"],
                                                      timeout: 120,
                                                      output: { _ in })
                    AuxiliaryExecuteWrapper.rootspawn(command: "exec-uicache",
                                                      args: [],
                                                      timeout: 120,
                                                      output: { _ in })
                    DispatchQueue.main.async {
                        alert.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
        let doRespringQuick = SettingElement(iconSystemNamed: "rays",
                                             text: NSLocalizedString("RELOAD_DESKTOP", comment: "Reload Desktop"),
                                             dataType: .submenuWithAction,
                                             initData: nil)
        { _, _ in
            UIApplication.prepareForExitAndSuspend()
            sleep(1)
            AuxiliaryExecuteWrapper.reloadSpringboard()
        }
        let safemodeQuick = SettingElement(iconSystemNamed: "shield",
                                           text: NSLocalizedString("ENTER_SAFE_MODE", comment: "Enter Safe Mode"),
                                           dataType: .submenuWithAction,
                                           initData: nil)
        { _, _ in
            UIApplication.prepareForExitAndSuspend()
            sleep(1)
            AuxiliaryExecuteWrapper.rootspawn(command: AuxiliaryExecuteWrapper.killall,
                                              args: ["-SEGV", "SpringBoard"],
                                              timeout: 1)
            { _ in
            }
        }
        let sourceCode = SettingElement(iconSystemNamed: "chevron.left.slash.chevron.right",
                                        text: NSLocalizedString("SOURCE_CODE", comment: "Source Code"),
                                        dataType: .submenuWithAction,
                                        initData: nil)
        { _, _ in
            UIApplication.shared.open(URL(string: cWebLocationSource)!,
                                      options: [:],
                                      completionHandler: nil)
        }
        addSubview(backgroundView)
        addSubview(enableShareSheet)
        addSubview(enableQuickMode)
        addSubview(enableDefaultSource)
#if DEBUG
        addSubview(crashApp)
#endif
        if(InterfaceBridge.enableQuickMode){
            addSubview(doUicacheQuick)
            addSubview(doRespringQuick)
            addSubview(safemodeQuick)
        } else {
            addSubview(doUicache)
            addSubview(doRespring)
            addSubview(safemode)
        }
        addSubview(doReloadAirDrop)
        addSubview(sourceCode)
        enableShareSheet.snp.makeConstraints { x in
            x.left.equalTo(safeAnchor.snp.left).offset(8)
            x.right.equalTo(safeAnchor.snp.right).offset(-8)
            x.top.equalTo(anchor.snp.bottom).offset(18)
            x.height.equalTo(28)
        }
        anchor = enableShareSheet
        enableQuickMode.snp.makeConstraints { x in
            x.left.equalTo(safeAnchor.snp.left).offset(8)
            x.right.equalTo(safeAnchor.snp.right).offset(-8)
            x.top.equalTo(anchor.snp.bottom).offset(18)
            x.height.equalTo(28)
        }
        anchor = enableQuickMode
        enableDefaultSource.snp.makeConstraints { x in
            x.left.equalTo(safeAnchor.snp.left).offset(8)
            x.right.equalTo(safeAnchor.snp.right).offset(-8)
            x.top.equalTo(anchor.snp.bottom).offset(18)
            x.height.equalTo(28)
        }
        anchor = enableDefaultSource
#if DEBUG
        crashApp.snp.makeConstraints { x in
            x.left.equalTo(safeAnchor.snp.left).offset(8)
            x.right.equalTo(safeAnchor.snp.right).offset(-8)
            x.top.equalTo(anchor.snp.bottom).offset(18)
            x.height.equalTo(28)
        }
        anchor = crashApp
#endif
        if(InterfaceBridge.enableQuickMode){
            doUicacheQuick.snp.makeConstraints { x in
                x.left.equalTo(safeAnchor.snp.left).offset(8)
                x.right.equalTo(safeAnchor.snp.right).offset(-8)
                x.top.equalTo(anchor.snp.bottom).offset(18)
                x.height.equalTo(28)
            }
            anchor = doUicacheQuick
            doRespringQuick.snp.makeConstraints { x in
                x.left.equalTo(safeAnchor.snp.left).offset(8)
                x.right.equalTo(safeAnchor.snp.right).offset(-8)
                x.top.equalTo(anchor.snp.bottom).offset(18)
                x.height.equalTo(28)
            }
            anchor = doRespringQuick
            safemodeQuick.snp.makeConstraints { x in
                x.left.equalTo(safeAnchor.snp.left).offset(8)
                x.right.equalTo(safeAnchor.snp.right).offset(-8)
                x.top.equalTo(anchor.snp.bottom).offset(18)
                x.height.equalTo(28)
            }
            anchor = safemodeQuick
        } else {
            doUicache.snp.makeConstraints { x in
                x.left.equalTo(safeAnchor.snp.left).offset(8)
                x.right.equalTo(safeAnchor.snp.right).offset(-8)
                x.top.equalTo(anchor.snp.bottom).offset(18)
                x.height.equalTo(28)
            }
            anchor = doUicache
            doRespring.snp.makeConstraints { x in
                x.left.equalTo(safeAnchor.snp.left).offset(8)
                x.right.equalTo(safeAnchor.snp.right).offset(-8)
                x.top.equalTo(anchor.snp.bottom).offset(18)
                x.height.equalTo(28)
            }
            anchor = doRespring
            safemode.snp.makeConstraints { x in
                x.left.equalTo(safeAnchor.snp.left).offset(8)
                x.right.equalTo(safeAnchor.snp.right).offset(-8)
                x.top.equalTo(anchor.snp.bottom).offset(18)
                x.height.equalTo(28)
            }
            anchor = safemode
        }
        doReloadAirDrop.snp.makeConstraints { x in
            x.left.equalTo(safeAnchor.snp.left).offset(8)
            x.right.equalTo(safeAnchor.snp.right).offset(-8)
            x.top.equalTo(anchor.snp.bottom).offset(18)
            x.height.equalTo(28)
        }
        anchor = doReloadAirDrop
        sourceCode.snp.makeConstraints { x in
            x.left.equalTo(safeAnchor.snp.left).offset(8)
            x.right.equalTo(safeAnchor.snp.right).offset(-8)
            x.top.equalTo(anchor.snp.bottom).offset(18)
            x.height.equalTo(28)
        }
        anchor = sourceCode
        backgroundView.snp.makeConstraints { x in
            x.left.equalTo(safeAnchor.snp.left)
            x.right.equalTo(safeAnchor.snp.right)
            x.top.equalTo(enableShareSheet.snp.top).offset(-12)
            x.bottom.equalTo(anchor.snp.bottom).offset(16)
        }
        anchor = backgroundView
    }
}
