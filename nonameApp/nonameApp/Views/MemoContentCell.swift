//
//  MemoContentCell.swift
//  nonameApp
//
//  Created by heyji on 2024/02/22.
//

import UIKit

protocol MemoContentCellDelegate: AnyObject {
    func bookmarkButtonTapped(cell: MemoContentCell)
}

final class MemoContentCell: UITableViewCell {

    static let identifier: String = "MemoContentCell"
    
    weak var delegate: MemoContentCellDelegate?
    
    private let cellView: UIView = {
        let view = UIView()
        return view
    }()
    
    var contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    lazy var tagCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    var lastDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 12)
        label.text = "2024.02.11 오전 10:11"
        return label
    }()
    
    var bookmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.tintColor = .black
        button.isSelected = false
        button.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [tagCollectionView, lastDateLabel, bookmarkButton])
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(cellView)
        cellView.addSubview(contentLabel)
        cellView.addSubview(stackView)
        
        cellView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(8)
        }
        contentLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(24)
            make.bottom.equalToSuperview()
        }
        
        tagCollectionView.alwaysBounceVertical = false
        tagCollectionView.dataSource = self
        tagCollectionView.collectionViewLayout = collectionViewLayout()
        tagCollectionView.register(TagListCell.self, forCellWithReuseIdentifier: TagListCell.identifier)
    }
    
    private func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(30), heightDimension: .absolute(24))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(3), heightDimension: .absolute(24))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    @objc private func bookmarkButtonTapped(_ sender: UIButton) {
        delegate?.bookmarkButtonTapped(cell: self)
    }
}

extension MemoContentCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagListCell.identifier, for: indexPath) as! TagListCell
        return cell
    }
}
