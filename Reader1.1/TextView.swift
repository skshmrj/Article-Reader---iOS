//
//  TextView.swift
//  highlighter
//
//  Created by Terminal-1 on 21/05/19.
//  Copyright © 2019 AscendPsychology. All rights reserved.
//

import UIKit

class TextView: UITextView {
    
    var attrStr: NSMutableAttributedString!
    var textToHighlight: String?
    var arrayOfRanges: [NSRange]?
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        backgroundColor = .clear
        isScrollEnabled = false
        addTapGestureRecognizer()
    }
    
    func addTapGestureRecognizer(){
        let singleTap = UITapGestureRecognizer(target: self, action:#selector(self.singleTapAction))
        singleTap.numberOfTapsRequired = 1
        addGestureRecognizer(singleTap)
    }
    
    @objc func singleTapAction(_ sender: UITapGestureRecognizer){
        becomeFirstResponder()
        let sentenceRange = getTappedSentenceRange(sender.location(in: self))
        selectedTextRange = sentenceRange
    }
    
    private final func getTappedSentenceRange(_ point: CGPoint) -> UITextRange?{
        if let textPosition = closestPosition(to: point)
        {
            if let range = tokenizer.rangeEnclosingPosition(textPosition, with: .sentence, inDirection: UITextDirection(rawValue: 1))
            {
                return range
            }
        }
        return nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func canPerformAction(_ action: Selector, withSender
        sender: Any?) -> Bool {
        return false
    }
}
