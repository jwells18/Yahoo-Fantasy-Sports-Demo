//
//  YHWebViewController.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/19/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import NJKWebViewProgress

class YHWebViewController: UIViewController, UIWebViewDelegate, NJKWebViewProgressDelegate{
    
    private var url: URL!
    private var navTitle: String!
    private var webView = UIWebView()
    private var webProgressView = NJKWebViewProgressView()
    private var webProgressProxy = NJKWebViewProgress()
    private var pageBackwardButton = UIBarButtonItem()
    private var pageForwardButton = UIBarButtonItem()
    private var exportPageButton = UIBarButtonItem()
    
    init(url: URL, navTitle: String?) {
        self.url = url
        self.navTitle = navTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup NavigationBar
        self.setupNavigationBar()
        
        //Setup View
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Add ProgressBar for displaying webpage loading status
        if(url != nil){
            self.navigationController?.navigationBar.addSubview(webProgressView)
        }
        else{
            webProgressView.removeFromSuperview()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //Hide Navigation Toolbar after dismissing view
        self.navigationController?.isToolbarHidden = true
        
        //Stop Loading Webpage after dismissing view and remove delegate
        webView.stopLoading()
        webView.delegate = nil;
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        // Remove progress view
        // because UINavigationBar is shared with other ViewControllers
        webProgressView.removeFromSuperview()
    }
    
    func setupNavigationBar(){
        //Setup Navigation Items
        self.navigationItem.title = self.navTitle.uppercased()
        
        let cancelBtn = YHBarButton(image: UIImage(named: "cancel")?.withRenderingMode(.alwaysTemplate))
        cancelBtn.tintColor = .white
        cancelBtn.addTarget(self, action: #selector(self.cancelButtonPressed(sender:)), for: .touchUpInside)
        let cancelButton = UIBarButtonItem(customView: cancelBtn)
        self.navigationItem.rightBarButtonItem = cancelButton
    }
    
    //Setup View
    func setupView(){
        //Setup WebView
        self.setupWebView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupWebView(){
        //Setup WebView
        webView = UIWebView(frame: .zero)
        webView.delegate = self
        webView.backgroundColor = .white
        webView.scalesPageToFit = true
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.scrollView.bounces = false
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(webView)
        
        //Setup WebView Progress Bar & Set Delegates
        webProgressProxy = NJKWebViewProgress()
        webView.delegate = webProgressProxy
        webProgressProxy.webViewProxyDelegate = self
        webProgressProxy.progressDelegate = self
        
        let progressBarHeight: CGFloat = 2
        let navigationBarBounds = self.navigationController?.navigationBar.bounds
        let barFrame = CGRect(x: 0, y: (navigationBarBounds?.size.height)! - progressBarHeight, width: (navigationBarBounds?.size.width)!, height: progressBarHeight);
        webProgressView.frame = barFrame
        webProgressView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        webProgressView.progressBarView.backgroundColor = YHColor.darkPurple
        
        //Setup WebView Toolbar
        self.setupWebViewToolbar()
        
        //Load WebView URL
        if(url != nil){
            let requestObj = URLRequest(url: url!)
            webView.loadRequest(requestObj)
        }
    }
    
    func setupWebViewToolbar(){
        //Setup Navigation Toolbar Appearance & Abilities
        self.navigationController?.isToolbarHidden = false
        self.navigationController?.toolbar.barTintColor = .white
        self.navigationController?.toolbar.tintColor = YHColor.darkPurple
        
        //Setup Navigation Toolbar
        pageBackwardButton = UIBarButtonItem(image: UIImage(named:"backward"), style: .plain, target: self, action: #selector(self.pageBackwardButtonPressed))
        pageForwardButton = UIBarButtonItem(image: UIImage(named:"forward"), style: .plain, target: self, action: #selector(self.pageForwardButtonPressed))
        exportPageButton = UIBarButtonItem(image: UIImage(named:"safari"), style: .plain, target: self, action: #selector(self.exportPageButtonPressed))
        let flexibleSpaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolbarItems = [pageBackwardButton, pageForwardButton, flexibleSpaceItem, flexibleSpaceItem, flexibleSpaceItem,exportPageButton]
        self.setToolbarItems(toolbarItems, animated: false)
    }
    
    func setupConstraints(){
        let viewDict = ["webView": webView] as [String : Any]
        //Width & Horizontal Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[webView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[webView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    //WebView Delegates
    func webViewDidStartLoad(_ webView: UIWebView) {
        if !webProgressView.isDescendant(of: (self.navigationController?.view)!){
            self.navigationController?.navigationBar.addSubview(webProgressView)
        }
        //Hide the activity indicator in the status bar
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        switch webView.canGoBack{
        case true:
            pageBackwardButton.isEnabled = true
            break
        case false:
            pageBackwardButton.isEnabled = false
            break
        }
        
        switch webView.canGoForward{
        case true:
            pageForwardButton.isEnabled = true
            break
        case false:
            pageForwardButton.isEnabled = false
            break
        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        //Hide the activity indicator in the status bar
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        switch webView.canGoBack{
        case true:
            pageBackwardButton.isEnabled = true
            break
        case false:
            pageBackwardButton.isEnabled = false
            break
        }
        
        switch webView.canGoForward{
        case true:
            pageForwardButton.isEnabled = true
            break
        case false:
            pageForwardButton.isEnabled = false
            break
        }
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        //Hide the activity indicator in the status bar
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        switch webView.canGoBack{
        case true:
            pageBackwardButton.isEnabled = true
            break
        case false:
            pageBackwardButton.isEnabled = false
            break
        }
        
        switch webView.canGoForward{
        case true:
            pageForwardButton.isEnabled = true
            break
        case false:
            pageForwardButton.isEnabled = false
            break
        }
        
        let code = (error as NSError).code
        if(code == NSURLErrorCancelled){
            return
        }
    }
    
    //BarButton Delegates
    func pageBackwardButtonPressed(){
        webView.goBack()
    }
    
    func pageForwardButtonPressed(){
        webView.goForward()
    }
    
    func exportPageButtonPressed(){
        //Open URL in Safari
        if #available(iOS 10.0, *) {
            UIApplication.shared.open((webView.request?.url)!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL((webView.request?.url)!)
        }
    }
    
    func cancelButtonPressed(sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    //NJKWebViewProgressDelegate
    func webViewProgress(_ webViewProgress: NJKWebViewProgress!, updateProgress progress: Float) {
        webProgressView.setProgress(progress, animated: true)
        let webTitle = self.webView.request?.url?.host
        if(navTitle == nil){
            self.navigationItem.title = webTitle
        }
    }
}
