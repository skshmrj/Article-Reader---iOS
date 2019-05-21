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
        if let paragraph = text{
            let sentences = getSentences(paragraph: paragraph)
            let closestPos = closestPosition(to: sender.location(in: self))
            
            let tappedWord = getTappedWord(sender.location(in: self))
            if let closestPos = closestPos{
                let tappedSubstring = getTappedSubstring(closestPosition: closestPos)
                if let tappedWord = tappedWord, let tappedSubstring = tappedSubstring {
                    // The while loop takes care to choose the correct sentence, if the words are repeated multiple times in the paragraph. For doing this, it checks if the current found sentence range contains the tapped point. If yes sentence is found and highlighted. If no, the loop continues on to find the next sentence
                    var isTappedIsCorrect = true
                    var correctnessIndex = 0
                    while (isTappedIsCorrect){
                        let tappedSentence = getTappedSentence(sentences: sentences, selectedWord: tappedWord, correctnessIndex: correctnessIndex)
                        let startOffset = getStartOffsetOfTappedSubstring(str: tappedSentence, searchFor: tappedSubstring)
                        let endOffset = tappedSentence.count - startOffset
                        let startPos = position(from: closestPos, offset: -startOffset)
                        let endPos = position(from: closestPos, offset: endOffset)
                        
                        if let startPos = startPos, let endPos = endPos{
                            let rect = firstRect(for: textRange(from: startPos, to: endPos)!)
                            let rect2 = firstRect(for: textRange(from: closestPos, to: position(from: closestPos, offset: 1)!)!)
                            if rect.contains(rect2.center){
                                // This logic is not perfect. Has to change later
                                selectedTextRange = textRange(from: startPos, to: endPos)
                                isTappedIsCorrect = false
                            }else{
                                selectedTextRange = textRange(from: startPos, to: endPos)
                                correctnessIndex += 1
                                if correctnessIndex >= sentences.count-1{
                                    break
                                }
                                print("Something is wrong")
                            }
                        }else{
                            break
                            NSLog("startPos, endPos is nil")
                        }
                    }
                }else{
                    NSLog("tappedWord/tappedSubstring is nil")
                }
            }else{
                NSLog("closestPos is nil")
            }
        }else{
            NSLog("textView text is nil")
        }
    }
    
    private final func getTappedWord(_ point: CGPoint) -> String?{
        if let textPosition = closestPosition(to: point)
        {
            if let range = tokenizer.rangeEnclosingPosition(textPosition, with: .word, inDirection: UITextDirection(rawValue: 1))
            {
                return text(in: range)
            }
        }
        return nil
    }
    
    func getSentences(paragraph: String) -> [String]{
        var sentences = [String]()
        var sentenceNumber = 0
        var currentSentence: String? = ""
        
        let charArray = paragraph.characters
        var period = 0
        
        for (index, char) in charArray.enumerated() {
            currentSentence! += "\(char)"
            if (char == ".") {
                period = index
                
                if (period == charArray.count-1) {
                    sentences.append(currentSentence!)
                }
            } else if ((char == " " && period == index-1 && index != 1) || period == (charArray.count-1)) {
                
                sentences.append(currentSentence!)
                currentSentence = ""
                sentenceNumber += 1
            }
        }
        return sentences
    }
    
    func getTappedSubstring(closestPosition: UITextPosition) -> String?{
        
        let finalPos = position(from: closestPosition, offset: 5)
        if let finalPos = finalPos, let tappedRange = textRange(from: closestPosition, to: finalPos) {
            let tappedChar = text(in: tappedRange)
            return tappedChar
        }else{
            NSLog("finalPos/tappedRange is nil")
            return nil
        }
    }
    
    func getTappedSentence(sentences: [String], selectedWord: String, correctnessIndex: Int) -> String{
        var index = correctnessIndex
        var sen = ""
        for sentence in sentences{
            if sentence.contains(selectedWord){
                sen = sentence
                if index <= 0{
                    break
                }
                index -= 1
            }
        }
        return sen
    }
    
    func getStartOffsetOfTappedSubstring(str: String, searchFor: String) -> Int{
        var len = searchFor.count
        var start = str.startIndex
        var end = str.index(start, offsetBy: len)
        var count = 0
        for i in 0..<str.count - len - 1{
            let substring = str[start..<end]
            start = str.index(start, offsetBy: 1)
            end = str.index(end, offsetBy: 1)
            if (substring == searchFor){
                break
            }
            count += 1
        }
        return count
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func canPerformAction(_ action: Selector, withSender
        sender: Any?) -> Bool {
        return false
    }
}

extension CGRect{
    var center: CGPoint
    {
        get { return CGPoint(x: centerX, y: centerY) }
        set { centerX = newValue.x; centerY = newValue.y }
    }
    var centerX: CGFloat
    {
        get { return midX }
        set { origin.x = newValue - width * 0.5 }
    }
    
    /** the y-coordinate of this rectangles center
     - note: Acts as a settable midY
     - returns: The y-coordinate of the center
     */
    var centerY: CGFloat
    {
        get { return midY }
        set { origin.y = newValue - height * 0.5 }
    }
}

