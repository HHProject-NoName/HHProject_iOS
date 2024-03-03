//
//  CustomKeyboardViewController.swift
//  nonameApp
//
//  Created by heyji on 2024/03/02.
//

import UIKit

final class CustomKeyboardViewController: UIViewController {
    
    let tagView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var tagCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        return collectionView
    }()
    
    let memoView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let memoTextView: UITextView = {
        let textView = UITextView()
        textView.autocorrectionType = .no
        textView.spellCheckingType = .no
        textView.backgroundColor = .systemGray6
        textView.clipsToBounds = true
        textView.layer.cornerRadius = 8
        return textView
    }()
    
    let postButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.up.circle"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    var textHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memoTextView.becomeFirstResponder()
        self.memoTextView.text.removeAll()
        self.adjustTextViewHeight()
        self.tagCollectionView.reloadData()
    }
    
    // 배경 터치시 현재 뷰 컨트롤러 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first, touch.view == self.view {
            self.dismiss(animated: true)
        }
    }
    
    private func setupView() {
        self.view.backgroundColor = .gray.withAlphaComponent(0.5)
        
        self.view.addSubview(tagView)
        self.view.addSubview(memoView)
        tagView.addSubview(tagCollectionView)
        tagCollectionView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(28)
        }
        tagCollectionView.alwaysBounceVertical = false
        tagCollectionView.dataSource = self
        tagCollectionView.delegate = self
        tagCollectionView.collectionViewLayout = collectionViewLayout()
        tagCollectionView.register(TagCell.self, forCellWithReuseIdentifier: TagCell.identifier)
        tagCollectionView.allowsMultipleSelection = true
        
        memoView.addSubview(memoTextView)
        memoView.addSubview(postButton)
        memoView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(50)
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top)
        }
        tagView.snp.makeConstraints { make in
            make.bottom.equalTo(memoView.snp.top)
            make.height.equalTo(40)
            make.left.right.equalToSuperview()
        }
        memoTextView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(16)
            make.right.equalTo(postButton.snp.left).offset(-10)
        }
        postButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(10)
            make.bottom.equalTo(memoTextView.snp.bottom).inset(3)
            make.width.height.equalTo(24)
        }
        postButton.addTarget(self, action: #selector(postButtonTapped), for: .touchUpInside)
        
        memoTextView.delegate = self
        self.textHeightConstraint = memoTextView.heightAnchor.constraint(equalToConstant: 30)
        self.textHeightConstraint.isActive = true
        self.adjustTextViewHeight()
    }
    
    private func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(30), heightDimension: .absolute(28))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(3), heightDimension: .absolute(28))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func adjustTextViewHeight() {
        let fixedWidth = memoTextView.frame.size.width
        let newSize = memoTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        if newSize.height > 100 {
            
        } else {
            self.textHeightConstraint.constant = newSize.height
        }
        self.view.layoutIfNeeded()
    }
    
    @objc private func postButtonTapped(_ sender: UIButton) {
        print("메모를 등록합니다.")
    }
}

extension CustomKeyboardViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.identifier, for: indexPath) as! TagCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.identifier, for: indexPath) as! TagCell
        print(indexPath.item)
    }
}

extension CustomKeyboardViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.adjustTextViewHeight()
    }
}
