//
//  IndicatorCollectionViewCell.swift
//  RaffleChallenge
//
//  Created by Gregory Keeley on 5/31/21.
//

import UIKit

class IndicatorCollectionViewCell: UICollectionViewCell {
    var indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    func setup() {
        contentView.addSubview(indicator)
        indicator.center = contentView.center
        indicator.startAnimating()
    }
}
