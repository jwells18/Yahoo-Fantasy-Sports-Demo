//
//  LeagueMenuView.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/17/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class LeagueMenuView: UIView{
    
    var tapGestureRecognizer = UITapGestureRecognizer()
    var collectionViewHeightConstraint = NSLayoutConstraint()
    lazy var collectionView: UICollectionView = {
        //Setup CollectionView Flow Layout
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 12, left: 8, bottom: 0, right: 8)
        
        //Setup CollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        return collectionView
    }()
    var cancelButton = UIButton()
    
    public override init(frame: CGRect){
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = .clear
        
        //Setup Tap Gesture Recognizer
        self.setupTapGestureRecognizer()
        
        //Setup CollectionView
        self.setupCollectionView()
        
        //Setup Cancel Button
        self.setupCancelButton()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupTapGestureRecognizer(){
        //Add Tap Gesture Recognizers
        self.tapGestureRecognizer.numberOfTapsRequired = 1
        self.tapGestureRecognizer.cancelsTouchesInView = false
        self.addGestureRecognizer(self.tapGestureRecognizer)
    }
    
    func setupCollectionView(){
        //Setup CollectionView
        self.collectionView.backgroundColor = .clear
        self.collectionView.alwaysBounceVertical = true;
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(collectionView)
    }
    
    func setupCancelButton(){
        self.cancelButton.setImage(UIImage(named: "cancel")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.cancelButton.backgroundColor = .white
        self.tintColor = .black
        self.cancelButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.cancelButton)
    }
    
    func setupConstraints(){
        let viewDict = ["collectionView": collectionView, "cancelButton": cancelButton] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[collectionView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints([NSLayoutConstraint.init(item: self.cancelButton, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 8)])
        self.addConstraints([NSLayoutConstraint.init(item: self.cancelButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)])
        //Height & Vertical Alignment
        self.addConstraints([NSLayoutConstraint.init(item: self.collectionView, attribute: .bottom, relatedBy: .equal, toItem: self.cancelButton, attribute: .top, multiplier: 1, constant: -8)])
        self.collectionViewHeightConstraint = NSLayoutConstraint.init(item: self.collectionView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
        self.addConstraint(self.collectionViewHeightConstraint)
        self.addConstraints([NSLayoutConstraint.init(item: self.cancelButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -8)])
        self.addConstraints([NSLayoutConstraint.init(item: self.cancelButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.cancelButton.layer.cornerRadius = self.cancelButton.frame.width/2
    }

}
