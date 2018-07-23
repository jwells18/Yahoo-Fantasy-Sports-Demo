//
//  LeagueMenuLeagueCell.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/18/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class LeagueMenuLeagueCell: UICollectionViewCell{
    
    var mainImageView = UIImageView()
    var titleLabel = UILabel()
    var subTitleLabel = UILabel()
    var pointsLabel = UILabel()
    var sportImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func setupView(){
        self.backgroundColor = .white
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        
        //Setup Main ImageView
        self.setupMainImageView()
        
        //Setup Title Label
        self.setupTitleLabel()
        
        //Setup SubTitle Label
        self.setupSubTitleLabel()
        
        //Setup Points Label
        self.setupPointsLabel()
        
        //Setup Sport ImageView
        self.setupSportImageView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupMainImageView(){
        self.mainImageView.backgroundColor = YHColor.faintGray
        self.mainImageView.contentMode = .scaleAspectFit
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
        self.subTitleLabel.numberOfLines = 0
        self.subTitleLabel.font = UIFont.systemFont(ofSize: 12)
        self.subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subTitleLabel)
    }
    
    func setupPointsLabel(){
        self.pointsLabel.textColor = .gray
        self.pointsLabel.textAlignment = .right
        self.pointsLabel.font = UIFont.systemFont(ofSize: 14)
        self.pointsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.pointsLabel)
    }
    
    func setupSportImageView(){
        self.sportImageView.clipsToBounds = true
        self.sportImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.sportImageView)
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
        
        let viewDict = ["mainImageView": mainImageView, "titleLabel": titleLabel, "subTitleLabel": subTitleLabel, "sportImageView": sportImageView, "pointsLabel": pointsLabel, "spacerView": spacerView, "spacerViewTop": spacerViewTop, "spacerViewBottom": spacerViewBottom] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[mainImageView(40)]-[titleLabel][spacerView][pointsLabel]-[sportImageView(25)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints([NSLayoutConstraint.init(item: subTitleLabel, attribute: .left, relatedBy: .equal, toItem: titleLabel, attribute: .left, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: subTitleLabel, attribute: .width, relatedBy: .equal, toItem: titleLabel, attribute: .width, multiplier: 1, constant: 0)])
        //Height & Vertical Alignment
        self.addConstraints([NSLayoutConstraint.init(item: mainImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: mainImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)])
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[spacerViewTop(==spacerViewBottom)][titleLabel][subTitleLabel][spacerViewBottom(==spacerViewTop)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints([NSLayoutConstraint.init(item: sportImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: sportImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25)])
        self.addConstraints([NSLayoutConstraint.init(item: pointsLabel, attribute: .top, relatedBy: .equal, toItem: self.titleLabel, attribute: .top, multiplier: 1, constant: 0)])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.mainImageView.layer.cornerRadius = self.mainImageView.frame.width/cornerRadiusDivisor
    }
    
    func configure(team: DBTeam){
        if team.image != nil{
            mainImageView.sd_setImage(with: URL(string: (team.image)!), placeholderImage: UIImage(named: "footballLeaguePlaceholder"))
        }
        else{
            mainImageView.image = UIImage(named: "footballLeaguePlaceholder")
        }
        self.titleLabel.text = String(format: "%@ %@", team.name, "team".localized())
        self.subTitleLabel.text = team.leagueName
        self.pointsLabel.text = String(format: "%@ %@", String(Int(team.points)), "pts".localized())
        self.sportImageView.image = UIImage(named: team.sport)?.withRenderingMode(.alwaysTemplate)
        self.sportImageView.tintColor = .darkGray
    }
}
