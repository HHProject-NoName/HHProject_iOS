//
//  UtilsBottomView.swift
//  nonameApp
//
//  Created by heyji on 2024/03/06.
//

import UIKit

final class UtilsBottomView: UIView {
    
    let touchUpKeyboardView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let tagListView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()
    
    let bookmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let tagListCollectionView = TagListCollectionView()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [touchUpKeyboardView, tagListView])
        stackView.axis = .vertical
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(stackView)
        tagListView.addSubview(bookmarkButton)
        tagListView.addSubview(tagListCollectionView)
        
        touchUpKeyboardView.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        tagListView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        bookmarkButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview()
            make.width.height.equalTo(30)
        }
        tagListCollectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(bookmarkButton.snp.right)
            make.right.equalToSuperview()
        }
    }
    
    
}
