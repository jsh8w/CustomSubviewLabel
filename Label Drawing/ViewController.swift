//
//  ViewController.swift
//  Label Drawing
//
//  Created by James Shaw on 17/05/2017.
//  Copyright © 2017 James Shaw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: CustomSubviewLabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func buttonPressed(sender: UIButton) {

        let randomString = self.fetchTestString()
        let tag = "<tag>"
        self.label.drawSubviews(text: randomString, tag: tag)
    }

    func fetchTestString() -> String {
        let testString1 = "Test <tag> string <tag>."
        let testString2 = "This is a very long string that wraps onto multiple lines. The first view will be drawn here: <tag>, the second here: <tag> and the third here: <tag>."
        let testString3 = "Draw view here: <tag>, and here: <tag>."
        let testString4 = "Testing drawing on multiple lines <tag> using a long <tag> string."

        let testStrings = [testString1, testString2, testString3, testString4]
        let randomString = testStrings[Int(arc4random_uniform(UInt32(testStrings.count)))]

        return randomString
    }
}

