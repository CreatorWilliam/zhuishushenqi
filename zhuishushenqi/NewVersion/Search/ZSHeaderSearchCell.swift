//
//  ZSHeaderSearchCell.swift
//  zhuishushenqi
//
//  Created by caony on 2019/10/22.
//  Copyright © 2019 QS. All rights reserved.
//

import UIKit

enum ZSHeaderSearchType {
    case hot
    case recommend
}

class ZSHeaderSearchCell: UITableViewCell {
    
    var clickHandler:ZSSearchHotHandler?
    
    private var type:ZSHeaderSearchType = .hot { didSet { reloadData() } }
    
    private var model:ZSHeaderSearch?
    
    private var topView:ZSHeaderSearchTopView = ZSHeaderSearchTopView(frame: .zero)
    
    private var hotView:ZSSearchHotView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(topView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.topView.frame = CGRect(x: 0, y: 0, width: self.contentView.bounds.width, height: 55)
        hotView?.frame = CGRect(x: 0, y: 55, width: self.contentView.bounds.width, height: self.contentView.bounds.height - 55)
    }
    
    func configure(model:ZSHeaderSearch) {
        self.model = model
        self.type = model.type
    }

    private func reloadData() {
        removeOtherSubview()
        switch self.type {
        case .hot:
            showHotView()
        case .recommend:
            showRecommendView()
        default:
            break
        }
    }
    
    private func showHotView() {
        let hotView = ZSSearchHotView(frame: CGRect(x: 0, y: 0, width: self.contentView.bounds.width, height: (model?.height ?? 0)))
        hotView.cellsFrame = model?.items as! [ZSSearchHotwords]
        hotView.clickHandler = { [unowned self] model in
            self.clickHandler?(model)
        }
        self.hotView = hotView
        topView.titleLabel.text = model?.headerTitle
        topView.detailButton.setTitle(model?.headerDetail ?? "", for: .normal)
        self.contentView.addSubview(hotView)
    }
    
    private func showRecommendView() {
        
    }
    
    private func removeOtherSubview() {
        for subview in self.contentView.subviews {
            if !subview.isKind(of: ZSHeaderSearchTopView.self) {
                subview.removeFromSuperview()
            }
        }
    }
}

class ZSHeaderSearchTopView:UIView {
    lazy var titleLabel:UILabel = {
        let lb = UILabel(frame: .zero)
        lb.textColor = UIColor.black
        lb.font = UIFont.systemFont(ofSize: 17)
        return lb
    }()
    
    lazy var detailButton:UIButton = {
        let bt = UIButton(type: .custom)
        bt.setTitleColor(UIColor.gray, for: .normal)
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return bt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(self.titleLabel)
        addSubview(self.detailButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel.frame = CGRect(x: 20, y: 20, width: 200, height: 21)
        self.detailButton.frame = CGRect(x: self.bounds.width - 100, y: 0, width: 100, height: 55)
    }
}
