//
//  LeaguePlayersPlayerTableCell.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/19/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class LeaguePlayersPlayerTableCell: UITableViewCell{
    
    var mainImageView = UIImageView()
    var titleLabel = UILabel()
    var subTitleLabel = UILabel()
    var separatorViewTop = UIView()
    var separatorViewBottom = UIView()
    var label1 = UILabel()
    var label2 = UILabel()
    var label3 = UILabel()
    var label4 = UILabel()
    
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
        
        //Setup Main ImageView
        self.setupMainImageView()
        
        //Setup Title Label
        self.setupTitleLabel()
        
        //Setup SubTitle Label
        self.setupSubTitleLabel()
        
        //Setup Separator Views
        self.setupSeparatorViews()
        
        //Setup Labels
        self.setupLabels()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupMainImageView(){
        self.mainImageView.backgroundColor = .white
        self.mainImageView.contentMode = .scaleAspectFill
        self.mainImageView.clipsToBounds = true
        self.mainImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.mainImageView)
    }
    
    func setupTitleLabel(){
        self.titleLabel.textColor = .darkGray
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.titleLabel)
    }
    
    func setupSubTitleLabel(){
        self.subTitleLabel.textColor = .gray
        self.subTitleLabel.font = UIFont.systemFont(ofSize: 12)
        self.subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subTitleLabel)
    }
    
    func setupSeparatorViews(){
        let separators = [self.separatorViewTop, self.separatorViewBottom]
        for separator in separators{
            separator.backgroundColor = .lightGray
            separator.isUserInteractionEnabled = false
            separator.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(separator)
        }
    }
    
    func setupLabels(){
        let labels = [label1, label2, label3, label4]
        for label in labels{
            label.textColor = .darkGray
            label.textAlignment = .center
            label.font = UIFont.boldSystemFont(ofSize: 12)
            label.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(label)
        }
    }
    
    func setupConstraints(){
        let viewDict = ["mainImageView": mainImageView, "titleLabel": titleLabel, "subTitleLabel": subTitleLabel, "label1": label1, "label2": label2, "label3": label3, "label4": label4, "separatorViewTop": separatorViewTop, "separatorViewBottom": separatorViewBottom] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-32-[mainImageView(40)]-[titleLabel]-32-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints([NSLayoutConstraint.init(item: subTitleLabel, attribute: .left, relatedBy: .equal, toItem: titleLabel, attribute: .left, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: subTitleLabel, attribute: .width, relatedBy: .equal, toItem: titleLabel, attribute: .width, multiplier: 1, constant: 0)])
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label1(==label2)][label2(==label3)][label3(==label4)][label4(==label1)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[separatorViewTop]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[separatorViewBottom]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-2-[mainImageView(40)][separatorViewTop(0.5)][label1(17)][separatorViewBottom(0.5)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints([NSLayoutConstraint.init(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self.mainImageView, attribute: .top, multiplier: 1, constant: 3)])
        self.addConstraints([NSLayoutConstraint.init(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 18)])
        self.addConstraints([NSLayoutConstraint.init(item: subTitleLabel, attribute: .top, relatedBy: .equal, toItem: self.titleLabel, attribute: .bottom, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: subTitleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 16)])
        self.addConstraints([NSLayoutConstraint.init(item: label2, attribute: .centerY, relatedBy: .equal, toItem: self.label1, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: label2, attribute: .height, relatedBy: .equal, toItem: self.label1, attribute: .height, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: label3, attribute: .centerY, relatedBy: .equal, toItem: self.label1, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: label3, attribute: .height, relatedBy: .equal, toItem: self.label1, attribute: .height, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: label4, attribute: .centerY, relatedBy: .equal, toItem: self.label1, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: label4, attribute: .height, relatedBy: .equal, toItem: self.label1, attribute: .height, multiplier: 1, constant: 0)])
    }
    
    func configure(player: Player?, rank: Int?){
        if player?.image != nil{
            mainImageView.sd_setImage(with: URL(string: (player?.image)!), placeholderImage: UIImage())
        }
        else{
            mainImageView.image = UIImage()
        }
        self.titleLabel.text = String(format: "%@ %@", player?.firstName ?? "", player?.lastName ?? "")
        self.subTitleLabel.text = String(format: "%@ v %@", player?.nextGameDate.dayAndTime() ?? "N/A",player?.nextGameTeam ?? "N/A")
        switch rank == nil{
        case true:
            self.label1.text = player?.adds.stringValue ?? "0"
            self.label2.text = player?.drops.stringValue ?? "0"
            self.label3.text = player?.trades.stringValue ?? "0"
            switch (player?.ownershipType)!{
            case .freeAgent:
                self.label4.text = "FA"
            }  
        case false:
            self.label1.text = String(rank!+1)
            self.label2.text = player?.nextGameProjPts.stringValue ?? "0"
            self.label3.text = player?.adds.stringValue ?? "0"
            self.label4.text = String(format: "%@%%",player?.ownedPercentage.stringValue ?? "0")
        }
        
    }
}

