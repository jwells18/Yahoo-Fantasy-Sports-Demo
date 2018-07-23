//
//  MessagingViewCell.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/16/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import SDWebImage
import DateToolsSwift

class MessagingViewCell: UITableViewCell{
    
    var mainImageButton = UIButton()
    var titleLabel = UILabel()
    var subTitleLabel = UILabel()
    var dateLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //Setup View
        self.setupView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func setupView(){
        self.backgroundColor = .white
        self.clipsToBounds = false
        self.selectionStyle = .none
        
        //Setup Main ImageButton
        self.setupMainImageButton()
        
        //Setup Title Label
        self.setupTitleLabel()
        
        //Setup SubTitle Label
        self.setupSubTitleLabel()
        
        //Setup Date Label
        self.setupDateLabel()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupMainImageButton(){
        self.mainImageButton.backgroundColor = YHColor.blue
        self.mainImageButton.contentMode = .scaleAspectFit
        self.mainImageButton.clipsToBounds = true
        self.mainImageButton.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6)
        self.mainImageButton.isUserInteractionEnabled = false
        self.mainImageButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.mainImageButton)
    }
    
    func setupTitleLabel(){
        self.titleLabel.textColor = .darkGray
        self.titleLabel.font = UIFont.systemFont(ofSize: 18)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.titleLabel)
    }
    
    func setupSubTitleLabel(){
        self.subTitleLabel.textColor = .gray
        self.subTitleLabel.font = UIFont.systemFont(ofSize: 14)
        self.subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subTitleLabel)
    }
    
    func setupDateLabel(){
        self.dateLabel.textColor = .gray
        self.dateLabel.textAlignment = .right
        self.dateLabel.font = UIFont.systemFont(ofSize: 12)
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.dateLabel)
    }
    
    func setupConstraints(){
        let spacerView = UIView()
        spacerView.isUserInteractionEnabled = false
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerView)
        let spacerViewTop = UIView()
        spacerViewTop.isUserInteractionEnabled = false
        spacerViewTop.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerViewTop)
        let spacerViewBottom = UIView()
        spacerViewBottom.isUserInteractionEnabled = false
        spacerViewBottom.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerViewBottom)
        
        let viewDict = ["mainImageButton": mainImageButton, "titleLabel": titleLabel, "subTitleLabel": subTitleLabel, "dateLabel": dateLabel, "spacerView": spacerView, "spacerViewTop": spacerViewTop, "spacerViewBottom": spacerViewBottom] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[mainImageButton(50)]-[titleLabel][spacerView(>=8)][dateLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints([NSLayoutConstraint.init(item: subTitleLabel, attribute: .left, relatedBy: .equal, toItem: titleLabel, attribute: .left, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: subTitleLabel, attribute: .width, relatedBy: .equal, toItem: titleLabel, attribute: .width, multiplier: 1, constant: 0)])
        //Height & Vertical Alignment
        self.addConstraints([NSLayoutConstraint.init(item: mainImageButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: mainImageButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)])
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[spacerViewTop(==spacerViewBottom)][titleLabel][subTitleLabel(>=18)][spacerViewBottom(==spacerViewTop)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints([NSLayoutConstraint.init(item: dateLabel, attribute: .top, relatedBy: .equal, toItem: self.mainImageButton, attribute: .top, multiplier: 1, constant: 0)])
    }
    
    func configure(chat: DBChat?){
        if (chat?.image != nil){
            mainImageButton.sd_setImage(with: URL(string: (chat?.image!)!), for: .normal, placeholderImage: UIImage(named: "messaging"), options: SDWebImageOptions(rawValue: 0), completed: nil)
        }
        else{
            self.mainImageButton.setImage(UIImage(named: "messaging"), for: .normal)
        }
        self.titleLabel.text = chat?.name
        self.subTitleLabel.text = chat?.lastMessage
        self.dateLabel.text = chat?.updatedAt.dateValue().shortTimeAgoSinceNow
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.mainImageButton.layer.cornerRadius = self.mainImageButton.frame.width/cornerRadiusDivisor
    }
}
