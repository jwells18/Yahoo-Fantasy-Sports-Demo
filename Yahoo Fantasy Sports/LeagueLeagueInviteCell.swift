//
//  LeagueLeagueInviteCell.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/19/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

protocol LeagueLeagueInviteCellDelegate {
    func didPressCopyButton(sender: UIButton)
    func didPressShareButton(sender: UIButton)
}

class LeagueLeagueInviteCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    var leagueLeagueInviteCellDelegate: LeagueLeagueInviteCellDelegate!
    private var cellIdentifier = "cell"
    lazy var collectionView: UICollectionView = {
        //Setup CollectionView Flow Layout
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //Setup CollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        return collectionView
    }()
    var titleLabel = UILabel()
    var separatorView = UIView()
    var subTitleLabel = UILabel()
    var copyButton = UIButton()
    var copyLabel = UILabel()
    var shareButton = UIButton()
    var shareLabel = UILabel()
    
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
        
        //Setup Title Label
        self.setupTitleLabel()
        
        //Setup Separator View
        self.setupSeparatorView()

        //Setup CollectionView
        self.setupCollectionView()
        
        //Setup SubTitle Label
        self.setupSubTitleLabel()
        
        //Setup Copy Button
        self.setupCopyButton()
        
        //Setup Copy Label
        self.setupCopyLabel()
        
        //Setup Share Button
        self.setupShareButton()
        
        //Setup Share Label
        self.setupShareLabel()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupTitleLabel(){
        self.titleLabel.text = "inviteFriendsToYourLeague".localized()
        self.titleLabel.textColor = .darkGray
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.titleLabel)
    }
    
    func setupSeparatorView(){
        self.separatorView.backgroundColor = .lightGray
        self.separatorView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.separatorView)
    }
    
    func setupCollectionView(){
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.backgroundColor = .white
        self.collectionView.isScrollEnabled = false
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.register(LeagueLeagueInviteCollectionCell.self, forCellWithReuseIdentifier: cellIdentifier)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(collectionView)
    }
    
    func setupSubTitleLabel(){
        self.subTitleLabel.textColor = .gray
        self.subTitleLabel.textAlignment = .center
        self.subTitleLabel.font = UIFont.systemFont(ofSize: 12)
        self.subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subTitleLabel)
    }
    
    func setupCopyButton(){
        self.copyButton.setImage(UIImage(named: "copy"), for: .normal)
        self.copyButton.clipsToBounds = true
        self.copyButton.layer.cornerRadius = 80/2
        self.copyButton.addTarget(self, action: #selector(copyButtonPressed(sender:)), for: .touchUpInside)
        self.copyButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.copyButton)
    }
    
    func setupCopyLabel(){
        self.copyLabel.text = "copyLink".localized()
        self.copyLabel.textColor = .darkGray
        self.copyLabel.textAlignment = .center
        self.copyLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.copyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(copyLabel)
    }
    
    func setupShareButton(){
        self.shareButton.setImage(UIImage(named: "share"), for: .normal)
        self.shareButton.clipsToBounds = true
        self.shareButton.layer.cornerRadius = 80/2
        self.shareButton.addTarget(self, action: #selector(shareButtonPressed(sender:)), for: .touchUpInside)
        self.shareButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.shareButton)
    }
    
    func setupShareLabel(){
        self.shareLabel.text = "share".localized()
        self.shareLabel.textColor = .darkGray
        self.shareLabel.textAlignment = .center
        self.shareLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.shareLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(shareLabel)
    }
    
    func setupConstraints(){
        let viewDict = ["titleLabel": titleLabel, "separatorView": separatorView, "collectionView": collectionView, "subTitleLabel": subTitleLabel, "copyButton": copyButton, "copyLabel": copyLabel, "shareButton": shareButton, "shareLabel": shareLabel] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[separatorView]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[collectionView]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[subTitleLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[copyLabel(==shareLabel)][shareLabel(==copyLabel)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraint(NSLayoutConstraint.init(item: self.copyButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80))
        self.addConstraint(NSLayoutConstraint.init(item: self.copyButton, attribute: .centerX, relatedBy: .equal, toItem: self.copyLabel, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: self.shareButton, attribute: .width, relatedBy: .equal, toItem: self.copyButton, attribute: .width, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: self.shareButton, attribute: .centerX, relatedBy: .equal, toItem: self.shareLabel, attribute: .centerX, multiplier: 1, constant: 0))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[titleLabel(18)]-10-[separatorView(0.5)][collectionView(40)]-4-[subTitleLabel(16)]-20-[copyButton(80)]-2-[copyLabel(18)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraint(NSLayoutConstraint.init(item: self.shareButton, attribute: .top, relatedBy: .equal, toItem: self.copyButton, attribute: .top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: self.shareButton, attribute: .height, relatedBy: .equal, toItem: self.copyButton, attribute: .height, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: self.shareLabel, attribute: .top, relatedBy: .equal, toItem: self.copyLabel, attribute: .top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: self.shareLabel, attribute: .height, relatedBy: .equal, toItem: self.copyLabel, attribute: .height, multiplier: 1, constant: 0))
    }
    
    func configure(){
        self.subTitleLabel.text = "1 Confirmed Team (4 required to draft)"
    }
    
    //CollectionView DataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView (_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: collectionView.frame.width/10, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! LeagueLeagueInviteCollectionCell
        //Manually setting for demo purposes
        if(indexPath.row == 0){
            cell.configure(image: UIImage(named: "footballLeaguePlaceholder"))
        }
        return cell
    }
    
    //CollectionViewCell Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    //Button Delegates
    func copyButtonPressed(sender: UIButton){
        leagueLeagueInviteCellDelegate.didPressCopyButton(sender: sender)
    }
    
    func shareButtonPressed(sender: UIButton){
        leagueLeagueInviteCellDelegate.didPressShareButton(sender: sender)
    }
}
