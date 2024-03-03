//
//  MainViewController.swift
//  nonameApp
//
//  Created by heyji on 2024/02/22.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    private var tableView: UITableView = UITableView()
    private let touchUpKeyboardView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemYellow
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupView()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        touchUpKeyboardView.addGestureRecognizer(tapGesture)
    }
    
    @objc func viewTapped() {
        let viewController = CustomKeyboardViewController()
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .overFullScreen
        self.present(viewController, animated: true)
    }
    
    private func setupNavigation() {
        title = "메모"
        let setting = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = setting
        navigationController?.navigationBar.tintColor = .black
    }
    private func setupView() {
        view.addSubview(tableView)
        view.addSubview(touchUpKeyboardView)
        tableView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(touchUpKeyboardView.snp.top)
        }
        touchUpKeyboardView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(200)
        }
        setupTableView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(MemoContentCell.self, forCellReuseIdentifier: MemoContentCell.identifier)
    }
}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemoContentCell.identifier, for: indexPath) as! MemoContentCell
        cell.contentLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "2024년 2월 \(20 - section)일"
    }
}
