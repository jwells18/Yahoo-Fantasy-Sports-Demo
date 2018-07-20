//
//  LeagueMyTeamSummaryCell.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/19/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

protocol LeagueMyTeamSummaryCellDelegate {
    func didPressMyTeamEditButton(sender: UIButton)
}

class LeagueMyTeamSummaryCell: UITableViewCell{
    
    var leagueMyTeamSummaryCellDelegate: LeagueMyTeamSummaryCellDelegate!
    var mainImageView = UIImageView()
    var mainTitleLabel = UILabel()
    var mainSubTitleLabel = UILabel()
    var editButton = UIButton()
    var rightTitleLabel = UILabel()
    var rightSubTitleLabel = UILabel()
    
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
        
        //Setup Main Title Label
        self.setupMainTitleLabel()
        
        //Setup Main SubTitle Label
        self.setupMainSubTitleLabel()
        
        //Setup Edit Button
        self.setupEditButton()
        
        //Setup Right Title Label
        self.setupRightTitleLabel()
        
        //Setup Right SubTitle Label
        self.setupRightSubTitleLabel()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupMainImageView(){
        self.mainImageView.backgroundColor = YHColor.faintGray
        self.mainImageView.clipsToBounds = true
        self.mainImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.mainImageView)
    }
    
    func setupMainTitleLabel(){
        self.mainTitleLabel.textColor = .orange
        self.mainTitleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.mainTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.mainTitleLabel)
    }
    
    func setupMainSubTitleLabel(){
        self.mainSubTitleLabel.textColor = .darkGray
        self.mainSubTitleLabel.font = UIFont.systemFont(ofSize: 12)
        self.mainSubTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mainSubTitleLabel)
    }
    
    func setupEditButton(){
        self.editButton.setImage(UIImage(named: "edit"), for: .normal)
        self.editButton.tintColor = .gray
        self.editButton.addTarget(self, action: #selector(editButtonPressed(sender:)), for: .touchUpInside)
        self.editButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.editButton)
    }
    
    func setupRightTitleLabel(){
        self.rightTitleLabel.text = "0.00";
        self.rightTitleLabel.textColor = .darkGray
        self.rightTitleLabel.textAlignment = .right
        self.rightTitleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.rightTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.rightTitleLabel)
    }
    
    func setupRightSubTitleLabel(){
        self.rightSubTitleLabel.text = "Proj 0.00";
        self.rightSubTitleLabel.textColor = .gray
        self.rightSubTitleLabel.textAlignment = .right
        self.rightSubTitleLabel.font = UIFont.systemFont(ofSize: 12)
        self.rightSubTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(rightSubTitleLabel)
    }
    
    func setupConstraints(){
        let spacerViewTop = UIView()
        spacerViewTop.isUserInteractionEnabled = false
        spacerViewTop.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerViewTop)
        let spacerViewBottom = UIView()
        spacerViewBottom.isUserInteractionEnabled = false
        spacerViewBottom.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerViewBottom)
        let spacerView = UIView()
        spacerView.isUserInteractionEnabled = false
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerView)
        
        let viewDict = ["mainImageView": mainImageView, "mainTitleLabel": mainTitleLabel, "mainSubTitleLabel": mainSubTitleLabel,"editButton": editButton, "rightTitleLabel": rightTitleLabel, "rightSubTitleLabel": rightSubTitleLabel, "spacerViewTop": spacerViewTop, "spacerViewBottom": spacerViewBottom, "spacerView": spacerView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[mainImageView(50)]-[mainTitleLabel]-2-[editButton(16)][spacerView][rightTitleLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints([NSLayoutConstraint.init(item: mainSubTitleLabel, attribute: .left, relatedBy: .equal, toItem: mainTitleLabel, attribute: .left, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: mainSubTitleLabel, attribute: .width, relatedBy: .equal, toItem: mainTitleLabel, attribute: .width, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: rightSubTitleLabel, attribute: .right, relatedBy: .equal, toItem: rightTitleLabel, attribute: .right, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: rightSubTitleLabel, attribute: .width, relatedBy: .equal, toItem: rightTitleLabel, attribute: .width, multiplier: 1, constant: 0)])
        //Height & Vertical Alignment
        self.addConstraints([NSLayoutConstraint.init(item: mainImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: mainImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)])
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[spacerViewTop(==spacerViewBottom)][mainTitleLabel][mainSubTitleLabel][spacerViewBottom(==spacerViewTop)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints([NSLayoutConstraint.init(item: editButton, attribute: .bottom, relatedBy: .equal, toItem: mainTitleLabel, attribute: .bottom, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: editButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 16)])
        self.addConstraints([NSLayoutConstraint.init(item: rightTitleLabel, attribute: .top, relatedBy: .equal, toItem: mainTitleLabel, attribute: .top, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: rightTitleLabel, attribute: .height, relatedBy: .equal, toItem: mainTitleLabel, attribute: .height, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: rightSubTitleLabel, attribute: .top, relatedBy: .equal, toItem: mainSubTitleLabel, attribute: .top, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: rightSubTitleLabel, attribute: .height, relatedBy: .equal, toItem: mainSubTitleLabel, attribute: .height, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: spacerViewTop, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)])
        self.addConstraints([NSLayoutConstraint.init(item: spacerViewBottom, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //Set Frames
        self.mainImageView.layer.cornerRadius = 50/cornerRadiusDivisor //self.mainImageView.frame.width/cornerRadiusDivisor
    }
    
    func configure(league: League?){
        //Set MainContainerView
        if league?.image != nil{
            mainImageView.sd_setImage(with: URL(string: (league?.image)!), placeholderImage: UIImage(named: "footballLeaguePlaceholder"))
        }
        else{
            mainImageView.image = UIImage(named: "footballLeaguePlaceholder")
        }
        mainTitleLabel.text = "Morgan Stanley Team"//league?.name
        mainSubTitleLabel.text = "Oliver"
    }
    
    //Button Delegates
    func editButtonPressed(sender: UIButton){
        leagueMyTeamSummaryCellDelegate.didPressMyTeamEditButton(sender: sender)
    }
}
