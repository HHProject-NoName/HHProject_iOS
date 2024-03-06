//
//  DetailView.swift
//  nonameApp
//
//  Created by heyji on 2024/03/06.
//

import UIKit

final class DetailView: UIView {
    
    private var updateDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 12)
        label.text = "2024.02.11 오전 10:11"
        label.textAlignment = .center
        return label
    }()
    
    var contentTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.font = .systemFont(ofSize: 16)
        return textView
    }()
    
    var tagListView = TagListCollectionView()
    
    var bookmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.tintColor = .black
        button.isSelected = false
        button.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(updateDateLabel)
        addSubview(tagListView)
        addSubview(contentTextView)
        addSubview(bookmarkButton)
        
        tagListView.tagCollectionView.allowsMultipleSelection = true
        tagListView.tagCollectionView.allowsSelection = false
        
        updateDateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(16)
        }
        tagListView.snp.makeConstraints { make in
            make.top.equalTo(updateDateLabel.snp.bottom)
            make.left.equalToSuperview()
            
            make.height.equalTo(50)
        }
        bookmarkButton.snp.makeConstraints { make in
            make.centerY.equalTo(tagListView.snp.centerY)
            make.left.equalTo(tagListView.snp.right)
            make.right.equalToSuperview().inset(16)
            make.width.height.equalTo(30)
        }
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(tagListView.snp.bottom)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
    
    @objc private func bookmarkButtonTapped(_ sender: UIButton) {
        bookmarkButton.isSelected.toggle()
        bookmarkButton.setImage(bookmarkButton.isSelected ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"), for: .normal)
    }
}
