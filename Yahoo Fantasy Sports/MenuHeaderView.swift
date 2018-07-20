//
//  MenuHeaderView.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/16/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class MenuHeaderView: UIView{
    
    var imageView = UIImageView()
    var titleLabel = UILabel()
    var subTitleLabel = UILabel()
    var accountButton = UIButton()
    var dropDownButton = UIButton()
    var cancelButton = UIButton()
    var separatorLine = UIView()
    
    public override init(frame: CGRect){
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = .white
        
        //Setup ImageView
        self.setupImageView()
        
        //Setup Title Label
        self.setupTitleLabel()
        
        //Setup SubTitle Label
        self.setupSubTitleLabel()
        
        //Setup Account Button
        self.setupAccountButton()
        
        //Setup DropDown Button
        self.setupDropDownButton()
        
        //Setup Cancel Button
        self.setupCancelButton()
        
        //Setup SeparatorLine
        self.setupSeparatorLine()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupImageView(){
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true
        self.imageView.backgroundColor = YHColor.faintGray
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.imageView);
    }
    
    func setupTitleLabel(){
        self.titleLabel.textColor = .black
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.titleLabel)
    }
    
    func setupSubTitleLabel(){
        self.subTitleLabel.textColor = .gray
        self.subTitleLabel.font = UIFont.systemFont(ofSize: 12)
        self.subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.subTitleLabel)
    }
    
    func setupAccountButton(){
        self.accountButton.setTitle("accountInfo".localized(), for: .normal)
        self.accountButton.setTitleColor(YHColor.blue, for: .normal)
        self.accountButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.accountButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.accountButton)
    }
    
    func setupDropDownButton(){
        self.dropDownButton.setImage(UIImage(named: "arrowDown"), for: .normal)
        self.dropDownButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.dropDownButton)
    }
    
    func setupCancelButton(){
        self.cancelButton.setImage(UIImage(named: "cancel"), for: .normal)
        self.cancelButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.cancelButton)
    }
    
    func setupSeparatorLine(){
        self.separatorLine.backgroundColor = .lightGray
        self.separatorLine.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.separatorLine)
    }
    
    func setupConstraints(){
        let spacerView = UIView()
        spacerView.isUserInteractionEnabled = false
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerView)
        
        let viewDict = ["imageView": imageView, "titleLabel": titleLabel, "subTitleLabel": subTitleLabel, "accountButton": accountButton, "dropDownButton": dropDownButton, "cancelButton": cancelButton, "separatorLine": separatorLine, "spacerView": spacerView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-12-[imageView(50)]-12-[titleLabel][spacerView][dropDownButton(25)]-12-[cancelButton(25)]-12-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraint(NSLayoutConstraint.init(item: self.subTitleLabel, attribute: .left, relatedBy: .equal, toItem: self.titleLabel, attribute: .left, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: self.subTitleLabel, attribute: .width, relatedBy: .equal, toItem: self.titleLabel, attribute: .width, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: self.accountButton, attribute: .left, relatedBy: .equal, toItem: self.titleLabel, attribute: .left, multiplier: 1, constant: 0))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[separatorLine]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraint(NSLayoutConstraint.init(item: self.imageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 32))
        self.addConstraint(NSLayoutConstraint.init(item: self.imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50))
        self.addConstraint(NSLayoutConstraint.init(item: self.titleLabel, attribute: .top, relatedBy: .equal, toItem: self.imageView, attribute: .top, multiplier: 1, constant: 6))
        self.addConstraint(NSLayoutConstraint.init(item: self.titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20))
        self.addConstraint(NSLayoutConstraint.init(item: self.subTitleLabel, attribute: .bottom, relatedBy: .equal, toItem: self.imageView, attribute: .bottom, multiplier: 1, constant: -6))
        self.addConstraint(NSLayoutConstraint.init(item: self.subTitleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 16))
        self.addConstraint(NSLayoutConstraint.init(item: self.dropDownButton, attribute: .centerY, relatedBy: .equal, toItem: self.titleLabel, attribute: .centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: self.dropDownButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25))
        self.addConstraint(NSLayoutConstraint.init(item: self.cancelButton, attribute: .centerY, relatedBy: .equal, toItem: self.imageView, attribute: .centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: self.cancelButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25))
        self.addConstraint(NSLayoutConstraint.init(item: self.accountButton, attribute: .top, relatedBy: .equal, toItem: self.imageView, attribute: .bottom, multiplier: 1, constant: 8.75))
        self.addConstraint(NSLayoutConstraint.init(item: self.accountButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20))
        self.addConstraint(NSLayoutConstraint.init(item: self.separatorLine, attribute: .top, relatedBy: .equal, toItem: self.accountButton, attribute: .bottom, multiplier: 1, constant: 8.75))
        self.addConstraint(NSLayoutConstraint.init(item: self.separatorLine, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: self.separatorLine, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0.5))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.layer.cornerRadius = self.imageView.frame.width/cornerRadiusDivisor
    }
    
    func configure(user: DBUser?){
        if user?.image != nil{
            self.imageView.sd_setImage(with: URL(string: (user?.image)!), placeholderImage: UIImage(named: "userImagePlaceholder"))
        }
        else{
            imageView.image = UIImage(named: "userImagePlaceholder")
        }
        self.titleLabel.text = String(format: "%@ %@", user?.firstName ?? "", user?.lastName ?? "")//"Oliver Williams"
        self.subTitleLabel.text = user?.email
    }
}
