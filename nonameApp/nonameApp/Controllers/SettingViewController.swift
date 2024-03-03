//
//  SettingViewController.swift
//  nonameApp
//
//  Created by heyji on 2024/03/03.
//

import UIKit
import MessageUI

final class SettingViewController: UIViewController {
    
    private let settings: [[String]] = [["태그 수정"], ["문의하기", "오픈소스"], ["로그아웃", "회원탈퇴"]]
        
    private let tableView = UITableView(frame: .zero, style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setUpView()
        
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "설정"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 23))
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.setPreferredSymbolConfiguration(.init(pointSize: 23), forImageIn: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        let backItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backItem
    }
    
    private func setUpView() {
        self.view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DefaultCell.self, forCellReuseIdentifier: DefaultCell.identifier)
        tableView.separatorStyle = .none
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    @objc private func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DefaultCell.identifier, for: indexPath) as! DefaultCell
        cell.configure(title: settings[indexPath.section][indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    // Delegate
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            break
        case 1:
            if indexPath.row == 0 {
                self.sendEmail()
            } else {
                let viewController = OpenSourceViewController()
                navigationItem.backButtonDisplayMode = .minimal
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        case 2:
            if indexPath.row == 0 {
                // 로그아웃
//                for key in UserDefaults.standard.dictionaryRepresentation().keys {
//                    UserDefaults.standard.removeObject(forKey: key.description)
//                }
//                let viewController = LoginViewController()
//                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.setRootViewController(viewController)
//                print("로그아웃되었습니다.")
            } else {
                // 회원탈퇴
//                let viewController = CustomAlertViewController(firstTitle: "나누리 회원을", secondEmphTitle: "탈퇴", backSecondTitle: "하시겠습니까?", descriptionContent: "탈퇴 30일 후, 계정이 완전히 삭제됩니다.\n신중하게 선택해주세요.", grayColorButtonTitle: "취소", greenColorButtonTitle: "탈퇴하기", customAlertType: .doneAndCancel, alertHeight: 244)
//                viewController.delegate = self
//                viewController.modalTransitionStyle = .crossDissolve
//                viewController.modalPresentationStyle = .overFullScreen
//                self.present(viewController, animated: true)
            }
        default:
            break
        }
    }
    
    func action() {
//        let params: [String: Any] = ["is_active": false]
//        NetworkService.shared.patchUserIsActiveRequest(parameters: params)
//        
//        for key in UserDefaults.standard.dictionaryRepresentation().keys {
//            UserDefaults.standard.removeObject(forKey: key.description)
//        }
//        
//        self.view.window?.rootViewController?.dismiss(animated: true, completion: {
//            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
//            guard let rootViewController = sceneDelegate.window?.rootViewController as? MainViewController else { return }
//            rootViewController.getLoginViewController()
//        })
    }
    
    func exit() {
        
    }
}

extension SettingViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let composeViewController = MFMailComposeViewController()
            composeViewController.mailComposeDelegate = self
            
            let bodyString = """
                                 이곳에 내용을 작성해주세요.
                                 
                                 
                                 -------------------
                                 
                                 Device Model : \(self.getDeviceIdentifier())
                                 Device OS : \(UIDevice.current.systemVersion)
                                 App Version : \(self.getCurrentVersion())
                                 
                                 -------------------
                                 """
            
            composeViewController.setToRecipients(["khjji0502@gmail.com"])
            composeViewController.setSubject("문의 및 의견")
            composeViewController.setMessageBody(bodyString, isHTML: false)
            
            self.present(composeViewController, animated: true, completion: nil)
        } else {
            print("메일 보내기 실패")
            let sendMailErrorAlert = UIAlertController(title: "메일 전송 실패", message: "메일을 보내려면 'Mail' 앱이 필요합니다. App Store에서 해당 앱을 복원하거나 이메일 설정을 확인하고 다시 시도해주세요.", preferredStyle: .alert)
            let goAppStoreAction = UIAlertAction(title: "App Store로 이동하기", style: .default) { _ in
                // 앱스토어로 이동하기(Mail)
                if let url = URL(string: "https://apps.apple.com/kr/app/mail/id1108187098"), UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }
            let cancleAction = UIAlertAction(title: "취소", style: .destructive, handler: nil)
            
            sendMailErrorAlert.addAction(goAppStoreAction)
            sendMailErrorAlert.addAction(cancleAction)
            self.present(sendMailErrorAlert, animated: true, completion: nil)
        }
    }
    // Device Identifier 찾기
    func getDeviceIdentifier() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        return identifier
    }
    
    // 현재 버전 가져오기
    func getCurrentVersion() -> String {
        guard let dictionary = Bundle.main.infoDictionary,
              let version = dictionary["CFBundleShortVersionString"] as? String else { return "" }
        return version
    }
}
