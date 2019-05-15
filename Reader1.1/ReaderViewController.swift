//
//  ReaderViewController.swift
//  Reader1.1
//
//  Created by Terminal-1 on 15/05/19.
//  Copyright © 2019 AscendPsychology. All rights reserved.
//

import UIKit

class ReaderViewController: UIViewController {

    // ToolBar
    var toolBar: UIToolbar!
    var shareItem: UIBarButtonItem!
    var highlightItem: UIBarButtonItem!
    var bookmarkItem: UIBarButtonItem!
    var settingsItem: UIBarButtonItem!
    var toolBarTopMargin: CGFloat!
    var toolBarBottomMargin: CGFloat!
    
    // ScrollView
    var scrollView: UIScrollView!
    
    // Container View
    var containerView: UIView!
    var closeView: UIView!
    var titleView: UIView!
    var body: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAndLayoutScrollView()
        createAndLayoutToolBar()
        createAndLayoutContents()
    }
    
    func createAndLayoutToolBar(){
        
        toolBar = UIToolbar()
        shareItem = UIBarButtonItem(image: UIImage(named: "share"), style: .plain, target: self, action: nil)
        let spaceItem1 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        highlightItem = UIBarButtonItem(image: UIImage(named: "edit"), style: .plain, target: self, action: nil)
        let spaceItem2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        bookmarkItem = UIBarButtonItem(image: UIImage(named: "star"), style: .plain, target: self, action: nil)
        let spaceItem3 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        settingsItem = UIBarButtonItem(image: UIImage(named: "font"), style: .plain, target: self, action: nil)
        toolBar.setItems([shareItem, spaceItem1, highlightItem, spaceItem2, bookmarkItem, spaceItem3, settingsItem], animated: true)
        self.view.addSubview(toolBar)
        
        // Add AutoLayout Constraints
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        let margins = view.layoutMarginsGuide
        let leading = NSLayoutConstraint(item: toolBar, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: toolBar, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: toolBar, attribute: .bottom, relatedBy: .equal, toItem: margins, attribute: .bottom, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: toolBar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 44)
        view.addConstraints([leading, trailing, bottom, height])
        
        // Customize the created toolbar
        toolBarTopMargin = toolBar.frame.origin.y
        toolBarBottomMargin = toolBarTopMargin + toolBar.frame.height + 34
        toolBar.setShadowImage(UIImage(named: "dot"), forToolbarPosition: UIBarPosition.any)
        view.bringSubviewToFront(toolBar)
    }
    
    func createAndLayoutScrollView(){
        scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        let w = self.scrollView.frame.width
        // Make sure this height is longer than scrollView.
        scrollView.contentSize = CGSize(width: w, height: CGFloat(2000))
        view.addSubview(scrollView)
        
        // Add AutoLayout Constraints
        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        let margins = view.layoutMarginsGuide
        let leading = NSLayoutConstraint(item: scrollView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: scrollView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)
        view.addConstraints([leading, top, width, bottom])
    }
    
    func createAndLayoutContents(){
        containerView = UIView()
        containerView.backgroundColor = .clear
        scrollView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let leading = NSLayoutConstraint(item: containerView, attribute: .leading, relatedBy: .equal, toItem: scrollView, attribute: .leading, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: containerView, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: containerView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: containerView, attribute: .bottom, relatedBy: .equal, toItem: scrollView.contentLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0)
        scrollView.addConstraints([leading, width, top, bottom])
        createAndLayoutCloseView()
        createAndLayoutTitleView()
        createAndLayoutBody()
    }
    
    func createAndLayoutCloseView(){
        closeView = UIView()
        closeView.backgroundColor = .clear
        containerView.addSubview(closeView)
        closeView.translatesAutoresizingMaskIntoConstraints = false
        let centerX = NSLayoutConstraint(item: closeView, attribute: .centerX, relatedBy: .equal, toItem: closeView.superview, attribute: .centerX, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: closeView, attribute: .width, relatedBy: .equal, toItem: closeView.superview, attribute: .width, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: closeView, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: closeView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
        containerView.addConstraints([centerX, width, top, height])
        
        let closeButton = UIButton()
        closeButton.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 44, height: 44))
        closeButton.setImage(UIImage(named: "Close"), for: .normal)
        closeButton.backgroundColor = .clear
        closeButton.tintColor = .black
        closeView.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        let centerY = NSLayoutConstraint(item: closeButton, attribute: .centerY, relatedBy: .equal, toItem: closeView, attribute: .centerY, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: closeButton, attribute: .trailing, relatedBy: .equal, toItem: closeView, attribute: .trailing, multiplier: 1, constant: -16)
        containerView.addConstraints([centerY, trailing])
    }
    
    func createAndLayoutTitleView(){
        titleView = UIView()
        titleView.backgroundColor = .clear
        containerView.addSubview(titleView)
        titleView.translatesAutoresizingMaskIntoConstraints = false
        let trailing = NSLayoutConstraint(item: titleView, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: titleView, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: titleView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60)
        let top = NSLayoutConstraint(item: titleView, attribute: .top, relatedBy: .equal, toItem: closeView, attribute: .bottom, multiplier: 1, constant: 0)
        containerView.addConstraints([trailing, leading, height, top])
        
        let title = UILabel()
        var font = UIFont.systemFont(ofSize: 24)
        let fontColor = UIColor.darkText
        var paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        paragraph.lineBreakMode = .byTruncatingTail
//        paragraph.line
        var titleText = NSAttributedString(string: "Swami And Friends", attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle: paragraph, NSAttributedString.Key.foregroundColor: fontColor])
        title.attributedText = titleText
        titleView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        let centerX = NSLayoutConstraint(item: title, attribute: .centerX, relatedBy: .equal, toItem: titleView, attribute: .centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: title, attribute: .centerY, relatedBy: .equal, toItem: titleView, attribute: .centerY, multiplier: 1, constant: 0)
        titleView.addConstraints([centerX, centerY])
        
        let subtitle = UILabel()
        font = UIFont.italicSystemFont(ofSize: 14)
        paragraph.alignment = .natural
        titleText = NSAttributedString(string: "- RK Narayan", attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle: paragraph, NSAttributedString.Key.foregroundColor: fontColor])
        subtitle.attributedText = titleText
        titleView.addSubview(subtitle)
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        let subtitleTrailing = NSLayoutConstraint(item: subtitle, attribute: .trailing, relatedBy: .equal, toItem: title, attribute: .trailing, multiplier: 1, constant: 0)
        let subtitleTop = NSLayoutConstraint(item: subtitle, attribute: .top, relatedBy: .equal, toItem: title, attribute: .bottom, multiplier: 1, constant: 8)
        titleView.addConstraints([subtitleTrailing, subtitleTop])
    }
    
    func createAndLayoutBody(){
        body = UILabel()
        body.numberOfLines = 0
        body.backgroundColor = .clear
        let font = UIFont.systemFont(ofSize: 17)
        let fontColor = UIColor.darkText
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .natural
        paragraph.lineBreakMode = .byClipping
        let titleText = NSAttributedString(string: Constants.article, attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle: paragraph, NSAttributedString.Key.foregroundColor: fontColor])
        body.attributedText = titleText
        containerView.addSubview(body)
        body.translatesAutoresizingMaskIntoConstraints = false
        let trailing = NSLayoutConstraint(item: body, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: -16)
        let leading = NSLayoutConstraint(item: body, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 16)
        let bottom = NSLayoutConstraint(item: body, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: body, attribute: .top, relatedBy: .equal, toItem: titleView, attribute: .bottom, multiplier: 1, constant: 50)
        containerView.addConstraints([trailing, leading, bottom, top])
    }
    
    @objc func share(){
    
    }
}
