//
//  TextSettingsViewController.swift
//  Reader1.1
//
//  Created by Terminal-1 on 16/05/19.
//  Copyright © 2019 AscendPsychology. All rights reserved.
//

import UIKit

class TextSettingsViewController: UIViewController {
    
    var delegate: TextSettingsViewControllerDelegate?
    var containerView: UIView!
    var fontSizeControl: UISlider!
    var brightnessControl: UISlider!
    var readModeChangeControl: UISwitch!
    var readModeChangeIcon: UIImageView!
    var readModeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .clear
        createAndLayoutContainerView()
        createAndLayoutControls()
        setupReadingMode()
    }
    
    func createAndLayoutContainerView(){
        containerView = UIView(frame: view.frame)
//        containerView.backgroundColor = .clear
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        // Add autoLayout constraints
        let width = NSLayoutConstraint(item: containerView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 240)
        let height = NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 160)
        let centerX = NSLayoutConstraint(item: containerView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
        view.addConstraints([centerY, centerX, width, height])
    }
    
    func createAndLayoutControls(){
        createAndLayoutFontSizeControl()
        createAndLayoutBrightnessControl()
        createAndLayoutReadModeChangeControl()
    }
    
    func createAndLayoutFontSizeControl(){
        fontSizeControl = UISlider()
        fontSizeControl.value = 0.5
        fontSizeControl.minimumValue = 0.0
        fontSizeControl.maximumValue = 1.0
        fontSizeControl.minimumValueImage = UIImage(named: "small_text_limit")
        fontSizeControl.maximumValueImage = UIImage(named: "large_text_limit")
        fontSizeControl.tintColor = #colorLiteral(red: 0.1194586232, green: 0.1295717061, blue: 0.1424147785, alpha: 1)
        containerView.addSubview(fontSizeControl)
        fontSizeControl.translatesAutoresizingMaskIntoConstraints = false
        // Add AutoLayout Constraints
        let centerX = NSLayoutConstraint(item: fontSizeControl, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: fontSizeControl, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1, constant: 16)
        let width = NSLayoutConstraint(item: fontSizeControl, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200)
        containerView.addConstraints([centerX, top, width])
    }
    
    func createAndLayoutBrightnessControl(){
        brightnessControl = UISlider()
        brightnessControl.value = 0.5
        brightnessControl.minimumValue = 0.0
        brightnessControl.maximumValue = 1.0
        brightnessControl.minimumValueImage = UIImage(named: "lower_brightness")
        brightnessControl.maximumValueImage = UIImage(named: "max_brightness")
        brightnessControl.tintColor = #colorLiteral(red: 0.1194586232, green: 0.1295717061, blue: 0.1424147785, alpha: 1)
        containerView.addSubview(brightnessControl)
        brightnessControl.translatesAutoresizingMaskIntoConstraints = false
        // Add AutoLayout Constraints
        let centerX = NSLayoutConstraint(item: brightnessControl, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: brightnessControl, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200)
        let top = NSLayoutConstraint(item: brightnessControl, attribute: .top, relatedBy: .equal, toItem: fontSizeControl, attribute: .bottom, multiplier: 1, constant: 8)
        containerView.addConstraints([centerX, width, top])
    }
    
    func createAndLayoutReadModeChangeControl(){
        readModeView = UIView()
        readModeView.backgroundColor = .clear
        containerView.addSubview(readModeView)
        readModeView.translatesAutoresizingMaskIntoConstraints = false
        let centerX = NSLayoutConstraint(item: readModeView, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: readModeView, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .width, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: readModeView, attribute: .top, relatedBy: .equal, toItem: brightnessControl, attribute: .bottom, multiplier: 1, constant: 8)
        let height = NSLayoutConstraint(item: readModeView, attribute: .height, relatedBy: .equal, toItem: brightnessControl, attribute: .height, multiplier: 1, constant: 0)
        containerView.addConstraints([centerX, width, top, height])
        
        // Layout the switch
        readModeChangeControl = UISwitch()
        readModeChangeControl.tintColor = #colorLiteral(red: 0.1194586232, green: 0.1295717061, blue: 0.1424147785, alpha: 1)
        readModeChangeControl.onTintColor = #colorLiteral(red: 0.1194586232, green: 0.1295717061, blue: 0.1424147785, alpha: 1)
        configureReadingModeToggle()
        readModeChangeControl.addTarget(self, action: #selector(switchMode), for: .valueChanged)
        readModeView.addSubview(readModeChangeControl)
        readModeChangeControl.translatesAutoresizingMaskIntoConstraints = false
        let switchCenterY = NSLayoutConstraint(item: readModeChangeControl, attribute: .centerY, relatedBy: .equal, toItem: readModeView, attribute: .centerY, multiplier: 1, constant: 0)
        let switchTrailing = NSLayoutConstraint(item: readModeChangeControl, attribute: .trailing, relatedBy: .equal, toItem: readModeView, attribute: .trailing, multiplier: 1, constant: -14)
        readModeView.addConstraints([switchCenterY, switchTrailing])
        
        // Layout the readModeIcon
        readModeChangeIcon = UIImageView(image: UIImage(named: "dark_mode"))
        readModeChangeIcon.tintColor = #colorLiteral(red: 0.1194586232, green: 0.1295717061, blue: 0.1424147785, alpha: 1)
        readModeChangeIcon.contentMode = .scaleAspectFit
        readModeView.addSubview(readModeChangeIcon)
        readModeChangeIcon.translatesAutoresizingMaskIntoConstraints = false
        let iconCenterY = NSLayoutConstraint(item: readModeChangeIcon, attribute: .centerY, relatedBy: .equal, toItem: readModeView, attribute: .centerY, multiplier: 1, constant: 0)
        let iconLeading = NSLayoutConstraint(item: readModeChangeIcon, attribute: .leading, relatedBy: .equal, toItem: readModeView, attribute: .leading, multiplier: 1, constant: 18)
        let iconWidth = NSLayoutConstraint(item: readModeChangeIcon, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 16)
        let iconHeight = NSLayoutConstraint(item: readModeChangeIcon, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 16)
        readModeView.addConstraints([iconCenterY, iconLeading, iconWidth, iconHeight])
        
    }
    
    @objc func switchMode(){
        var darkModeIsOn = UserDefaults.standard.bool(forKey: Constants.userDefaultsKey.darkMode)
        darkModeIsOn = !darkModeIsOn
        UserDefaults.standard.set(darkModeIsOn, forKey: Constants.userDefaultsKey.darkMode)
        setupReadingMode()
    }
    
    func setupReadingMode(){
        let isDarkModeOn = UserDefaults.standard.bool(forKey: Constants.userDefaultsKey.darkMode)
        
        if isDarkModeOn{
            // Configure for dark mode
            
            //Customize the Font Resize Slider Control's Color
            fontSizeControl.tintColor = Constants.mode.light.color1
            
            // Customise the Brightness Slider Control's Color
            brightnessControl.tintColor = Constants.mode.light.color1
            
            // Customise the Dark Mode Icon's Color
            readModeChangeIcon.tintColor = Constants.mode.light.color1
            
            // Customise the current view's backgroundColor
            self.popoverPresentationController?.backgroundColor = Constants.mode.dark.color1
            
            //Change the parent controller's mode
            delegate?.readingModeWillChange(to: .dark)
            
            // Change the status bar appearance
            delegate?.configureStatusBar(for: .dark)
            
        } else {
            // Configure for light mode
            
            // Customize the Font Resize Slider Control's Color
            fontSizeControl.tintColor = Constants.mode.dark.color2
            
            // Customise the Brightness Slider Control's Color
            brightnessControl.tintColor = Constants.mode.dark.color2
            
            // Customise the Dark Mode Icon's Color
            readModeChangeIcon.tintColor = Constants.mode.dark.color2
            
            // Customise the current view's backgroundColor
            self.popoverPresentationController?.backgroundColor = Constants.mode.light.color1
            
            // change the parent controller's mode
            delegate?.readingModeWillChange(to: .light)
            
            // Change the status bar appearance
            delegate?.configureStatusBar(for: .light)
        }
    }
    
    func configureReadingModeToggle(){
        let isDarkModeOn = UserDefaults.standard.bool(forKey: Constants.userDefaultsKey.darkMode)
        
        if isDarkModeOn{
            readModeChangeControl.isOn = true
        } else {
            readModeChangeControl.isOn = false
        }
        // Resize the toggle for dark mode
        readModeChangeControl.transform = CGAffineTransform(scaleX: Constants.readModeSwitchScaleX, y: Constants.readModeSwitchScaleY)
    }
    
}
