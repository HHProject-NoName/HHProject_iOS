//
//  TagListCell.swift
//  nonameApp
//
//  Created by heyji on 2024/02/22.
//

import UIKit

final class TagListCell: UICollectionViewCell {
    
    static let identifier: String = "TagListCell"
    
    private let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    var tagLebel: UILabel = {
        let label = UILabel()
        label.text = "#태그"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        addSubview(cellView)
        cellView.addSubview(tagLebel)
        cellView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tagLebel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
    }
}
