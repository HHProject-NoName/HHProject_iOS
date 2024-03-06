//
//  DetailViewController.swift
//  nonameApp
//
//  Created by heyji on 2024/03/06.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private let detailView = DetailView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem?.title = "편집"
        navigationController?.navigationBar.tintColor = .black
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.editButtonItem.title = editing ? "저장" : "편집"
        if editing {
            detailView.contentTextView.isEditable = true
            detailView.tagListView.tagCollectionView.allowsSelection = true
            detailView.tagListView.tagCollectionView.allowsMultipleSelection = true
        } else {
            detailView.contentTextView.isEditable = false
            detailView.tagListView.tagCollectionView.allowsSelection = false
        }
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(detailView)
        
        detailView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private func setUpNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo as NSDictionary?,
              var keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        keyboardFrame = view.convert(keyboardFrame, from: nil)
        var contentInset = detailView.contentTextView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        detailView.contentTextView.contentInset = contentInset
        detailView.contentTextView.scrollIndicatorInsets = detailView.contentTextView.contentInset
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        detailView.contentTextView.contentInset = UIEdgeInsets.zero
        detailView.contentTextView.scrollIndicatorInsets = detailView.contentTextView.contentInset
    }
}
