//
//  LeaguePlayersSectionView.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/19/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class LeaguePlayersSectionView: UIView{
    
    var label1 = UILabel()
    var label2 = UILabel()
    var label3 = UILabel()
    var label4 = UILabel()
    var separatorViewTop = UIView()
    var separatorViewBottom = UIView()
    
    public override init(frame: CGRect){
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func setupView(){
        self.backgroundColor = .white
        self.clipsToBounds = false
        
        //Setup Labels
        self.setupLabels()
        
        //Setup Separator Views
        self.setupSeparatorViews()
        
        //Setup Constraints
        self.setupConstraints()
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
    
    func setupSeparatorViews(){
        let separators = [self.separatorViewTop, self.separatorViewBottom]
        for separator in separators{
            separator.backgroundColor = .lightGray
            separator.isUserInteractionEnabled = false
            separator.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(separator)
        }
    }
    
    func setupConstraints(){
        let viewDict = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "separatorViewTop": separatorViewTop, "separatorViewBottom": separatorViewBottom] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label1(==label2)][label2(==label3)][label3(==label4)][label4(==label1)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[separatorViewTop]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[separatorViewBottom]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints([NSLayoutConstraint.init(item: label1, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: label2, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: label3, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: label4, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[separatorViewTop(0.5)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[separatorViewBottom(0.5)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    func configure(titles: [String]){
        if titles.count >= 4{
            self.label1.text = titles[0]
            self.label2.text = titles[1]
            self.label3.text = titles[2]
            self.label4.text = titles[3]
        }
    }
}
