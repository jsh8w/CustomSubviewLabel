//
//  CustomSubviewLabel.swift
//  Label Drawing
//
//  Created by James Shaw on 25/07/2017.
//  Copyright © 2017 James Shaw. All rights reserved.
//

import UIKit

class CustomSubviewLabel: UILabel {

    func drawSubviews(text: String, tag: String) {

        // Remove existing subviews
        for subview in self.subviews {
            subview.removeFromSuperview()
        }

        self.attributedText = self.getAttributedStringWith(text: text, tag: tag)
    }

    private func getAttributedStringWith(text: String, tag: String) -> NSMutableAttributedString {

        // Properties of the label
        var parsedString = text
        let font = self.font!
        let textColor = self.textColor!

        // Construct attributes dictionary
        let attributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: textColor] as [String : Any]
        var attributedString = NSMutableAttributedString(string: parsedString, attributes: attributes)
        self.attributedText = attributedString

        do {
            // Find matches using a regex with pattern = tag
            let expression = try NSRegularExpression(pattern: tag, options: .caseInsensitive)
            var matches = expression.matches(in: parsedString, options: [], range: NSMakeRange(0, parsedString.characters.count))

            // Keep drawing subviews until no matches are found
            while matches.count > 0 {
                parsedString = self.drawSubview(text: parsedString, range: matches.first!.range)
                attributedString = NSMutableAttributedString(string: parsedString, attributes: attributes)
                self.attributedText = attributedString
                matches = expression.matches(in: parsedString, options: [], range: NSMakeRange(0, parsedString.characters.count))
            }
        } catch let error {
            print(error)
        }

        return attributedString
    }

    private func drawSubview(text: String, range: NSRange) -> String {

        // Replace the tag with whitespace
        let whitespace = String(repeating: "  ", count: range.length)
        let replacedString = (text as NSString).replacingCharacters(in: range, with: whitespace)

        // Get frame of the range of text
        guard let frame = self.boundingRectForCharacterRange(range: range) else {
            return text
        }

        // Construct square frame
        let width = min(frame.width, frame.height)
        let height = width
        let x = frame.origin.x + ((frame.width - width) / 2)
        let y = frame.origin.y + ((frame.height - height) / 2)

        // Draw subview
        let newSubview = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
        newSubview.backgroundColor = UIColor.red
        self.addSubview(newSubview)

        return replacedString
    }
}

extension UILabel {
    func boundingRectForCharacterRange(range: NSRange) -> CGRect? {

        guard let attributedText = attributedText else { return nil }

        self.sizeToFit()

        let textStorage = NSTextStorage(attributedString: attributedText)
        let layoutManager = NSLayoutManager()

        textStorage.addLayoutManager(layoutManager)

        let textContainer = NSTextContainer(size: self.frame.size)
        textContainer.lineFragmentPadding = 0.0
        textContainer.maximumNumberOfLines = 0

        layoutManager.addTextContainer(textContainer)

        var glyphRange = NSRange()

        // Convert the range for glyphs.
        layoutManager.characterRange(forGlyphRange: range, actualGlyphRange: &glyphRange)

        return layoutManager.boundingRect(forGlyphRange: glyphRange, in: textContainer)
    }
}
