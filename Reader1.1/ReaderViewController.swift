//
//  ReaderViewController.swift
//  Reader1.1
//
//  Created by Terminal-1 on 15/05/19.
//  Copyright © 2019 AscendPsychology. All rights reserved.
//

import UIKit

protocol TextSettingsViewControllerDelegate {
    func readingModeWillChange(to mode: ReadingMode)
    func changeFontSize(senderValue: CGFloat)
    func configureStatusBar(for mode: ReadingMode)
}

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
    var titleLabel: UILabel!
    var subtitleLabel: UILabel!
    var closeButton: UIButton!
    var body: TextView!
    
    // Text Settings Control
    var textSettingsVC: TextSettingsViewController?
    
    var statusBarIsHidden: Bool = false{
        didSet {
            UIView.animate(withDuration: Constants.animations.duration.statusBarHide) { () -> Void in
                self.setNeedsStatusBarAppearanceUpdate()
            }
        }
    }
    var statusBarStyle:UIStatusBarStyle = .default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAndLayoutScrollView()
        createAndLayoutToolBar()
        createAndLayoutContents()
        setUpReadingMode()
        customizeMenuItemActions()
        scrollView.delegate = self
    }
    
    func createAndLayoutToolBar(){
        
        toolBar = UIToolbar()
        shareItem = UIBarButtonItem(image: UIImage(named: "share"), style: .plain, target: self, action: nil)
        let spaceItem1 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        highlightItem = UIBarButtonItem(image: UIImage(named: "edit"), style: .plain, target: self, action: nil)
        let spaceItem2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        bookmarkItem = UIBarButtonItem(image: UIImage(named: "star"), style: .plain, target: self, action: nil)
        let spaceItem3 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        settingsItem = UIBarButtonItem(image: UIImage(named: "font"), style: .plain, target: self, action: #selector(showTextSettingsControl))
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
        toolBar.tintColor = .darkText
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
        
        closeButton = UIButton()
        closeButton.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 44, height: 44))
        closeButton.setImage(UIImage(named: "Close"), for: .normal)
        closeButton.backgroundColor = .clear
        closeButton.tintColor = .black
        closeButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
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
        
        titleLabel = UILabel()
        var font = UIFont.systemFont(ofSize: 24)
        let fontColor = UIColor.darkText
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        paragraph.lineBreakMode = .byTruncatingTail
//        paragraph.line
        var titleText = NSAttributedString(string: "Swami And Friends", attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle: paragraph, NSAttributedString.Key.foregroundColor: fontColor])
        titleLabel.attributedText = titleText
        titleView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let centerX = NSLayoutConstraint(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: titleView, attribute: .centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: titleView, attribute: .centerY, multiplier: 1, constant: 0)
        titleView.addConstraints([centerX, centerY])
        
        subtitleLabel = UILabel()
        font = UIFont.italicSystemFont(ofSize: 14)
        paragraph.alignment = .natural
        titleText = NSAttributedString(string: "- RK Narayan", attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle: paragraph, NSAttributedString.Key.foregroundColor: fontColor])
        subtitleLabel.attributedText = titleText
        titleView.addSubview(subtitleLabel)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        let subtitleTrailing = NSLayoutConstraint(item: subtitleLabel, attribute: .trailing, relatedBy: .equal, toItem: titleLabel, attribute: .trailing, multiplier: 1, constant: 0)
        let subtitleTop = NSLayoutConstraint(item: subtitleLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 8)
        titleView.addConstraints([subtitleTrailing, subtitleTop])
    }
    
    func createAndLayoutBody(){
        body = TextView()
        body.backgroundColor = .clear
        body.isScrollEnabled = false
        let font = UIFont.systemFont(ofSize: 17)
        let fontColor = UIColor.darkText
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .natural
        paragraph.lineBreakMode = .byWordWrapping
        var attributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle: paragraph, NSAttributedString.Key.foregroundColor: fontColor]
        Constants.article.addAttributes(attributes, range: NSRange(location: 0, length: Constants.article.length))
//        let titleText = NSAttributedString(string: Constants.article, attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle: paragraph, NSAttributedString.Key.foregroundColor: fontColor])
        body.attributedText = Constants.article
        containerView.addSubview(body)
        body.translatesAutoresizingMaskIntoConstraints = false
        let trailing = NSLayoutConstraint(item: body, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: -16)
        let leading = NSLayoutConstraint(item: body, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 16)
        let bottom = NSLayoutConstraint(item: body, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: body, attribute: .top, relatedBy: .equal, toItem: titleView, attribute: .bottom, multiplier: 1, constant: 50)
        containerView.addConstraints([trailing, leading, bottom, top])
    }
    
    func setUpReadingMode(){
        let darkMode = UserDefaults.standard.bool(forKey: Constants.userDefaultsKey.darkMode)
        if darkMode {
            // Configure for dark mode
            readingModeWillChange(to: .dark)
        } else {
            // Configure for light mode
            readingModeWillChange(to: .light)
        }
    }
    
    @objc func dismissView(){
        // Restore the status bar settings
        self.statusBarStyle = .default
        self.setStatusBarBackgroundColor(color: .clear)
        self.setNeedsStatusBarAppearanceUpdate()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func showTextSettingsControl(){
        textSettingsVC = TextSettingsViewController()
        textSettingsVC?.preferredContentSize = CGSize(width: Constants.readModeSettingsWidth, height: Constants.readModeSettingsHeight)
        // Use the popover presentation style for your view controller.
        textSettingsVC?.modalPresentationStyle = .popover
        // Specify the anchor point for the popover.
        textSettingsVC?.popoverPresentationController?.barButtonItem = toolBar.items?.last
        textSettingsVC?.popoverPresentationController?.delegate = self
        setUpReadingMode()
        present(textSettingsVC!, animated: true, completion: {
            self.textSettingsVC!.delegate = self
        })
    }
    
    @objc func share(){
        
    }
    
    func customizeMenuItemActions(){
        let highlight = UIMenuItem(title: "Highlight", action: #selector(highlightText))
        UIMenuController.shared.menuItems = [highlight]
    }
    //
    @objc func highlightText(){
        //        storeHighlight(range: text.selectedRange)
        Constants.article.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.yellow, range: body.selectedRange)
        body.attributedText = Constants.article
    }
}

extension ReaderViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension ReaderViewController: TextSettingsViewControllerDelegate{
    
    func changeFontSize(senderValue: CGFloat){
        let newSize = Constants.minFontSize + ((Constants.maxFontSize-Constants.minFontSize)*senderValue)
        body.font = body.font?.withSize(newSize)
    }
    
    func readingModeWillChange(to mode: ReadingMode){
        if (mode == .dark){
            // Make changes for dark mode
    
            // Customise ScrollView
            scrollView.backgroundColor = Constants.mode.dark.color2
    
            // Customise Title TextColor
            titleLabel.textColor = Constants.mode.light.color1
    
            // Customise SubTitle TextColor
            subtitleLabel.textColor = Constants.mode.light.color1
    
            // Customise Body TextColor
            body.textColor = Constants.mode.light.color1
    
            // Customise ToolBar Color
            toolBar.barTintColor = Constants.mode.dark.color3
            toolBar.tintColor = Constants.mode.light.color1
    
            // Customise Close Button's Color
            closeButton.tintColor = Constants.mode.light.color1
            
        } else {
            // Make changes for light mode
    
            // Customise ScrollView
            scrollView.backgroundColor = Constants.mode.light.color1
    
            // Customise Title Text Color
            titleLabel.textColor = Constants.mode.dark.color2
    
            // Customise SubTitle Text Color
            subtitleLabel.textColor = Constants.mode.dark.color2
    
            // Customise Body TextColor
            body.textColor = Constants.mode.dark.color2
    
            // Customise ToolBar Color
            toolBar.barTintColor = Constants.mode.light.color1
            toolBar.tintColor = Constants.mode.dark.color1
    
            // Customise Close Button's Color
            closeButton.tintColor = Constants.mode.dark.color3
            
        }
    }
}

extension ReaderViewController {
    // Extension for Status Bar Customisations
    /* Setup Status Bar */
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation{
        return .slide
    }
    
    
    override var prefersStatusBarHidden: Bool{
        return statusBarIsHidden
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.statusBarStyle
    }
    
    func setStatusBarBackgroundColor(color: UIColor) {
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        statusBar.backgroundColor = color
    }
    
    func configureStatusBar(for mode: ReadingMode){
        if mode == .dark{
            // Customise status bar for dark mode
            self.statusBarStyle = .lightContent
            self.setStatusBarBackgroundColor(color: Constants.mode.dark.color3)
            self.setNeedsStatusBarAppearanceUpdate()
        } else {
            // Customise status bar for light mode
            self.statusBarStyle = .default
            setStatusBarBackgroundColor(color: Constants.mode.light.color1)
            setNeedsStatusBarAppearanceUpdate()
        }
    }
}

extension ReaderViewController: UIScrollViewDelegate{
    // Scroll View Delegate
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0{
            animateToolBar(hidden: true, animated: true)
            statusBarIsHidden = true
        }
        else{
            animateToolBar(hidden: false, animated: true)
            statusBarIsHidden = false
        }
    }
    
    func animateToolBar(hidden:Bool, animated: Bool){
        if toolBar.isHidden == hidden{ return }
        let frame = toolBar.frame
        let offset = hidden ? frame.size.height+Constants.bottomBarHeight : -frame.size.height-Constants.bottomBarHeight
        let duration:TimeInterval = (animated ? Constants.animations.duration.toolBarHide : 0.0)
        toolBar.isHidden = false
        
        UIView.animate(withDuration: duration, animations: {
            self.toolBar.frame = frame.offsetBy(dx: 0, dy: offset)
            
        }, completion: { (true) in
            self.toolBar.isHidden = hidden
        })
    }
}

enum ReadingMode{
    case dark
    case light
}
