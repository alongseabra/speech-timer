//
//  CheckBox.swift
//  SpeechTimer
//
//  Created by Anson Long-Seabra on 4/4/15.
//  Copyright (c) 2015 Anson Long-Seabra. All rights reserved.
//

import UIKit


//A simple checkbox button
class CheckBox: UIButton {


    
    var isChecked : Bool {
        didSet{
            if (isChecked == true) {
                self.setImage(checkedImage, forState: .Normal);
            } else {
                self.setImage(uncheckedImage, forState: .Normal);
            }
        }
    };
    
    lazy var checkedImage : UIImage = UIImage(named: "checked")!;
    
    lazy var uncheckedImage : UIImage = UIImage(named: "unchecked")!;
    
    
    override init(frame: CGRect) {
        
        self.isChecked = false;
        
        super.init(frame: frame);
        
        self.frame = frame;
        
        self.setImage(uncheckedImage, forState: .Normal);
        
        self.addTarget(self, action: "buttonClicked", forControlEvents: UIControlEvents.TouchUpInside);
        
    }
    
    func buttonClicked () {
    
    self.isChecked = !self.isChecked;
    
    }
    
    required  init(coder aDecoder: NSCoder) {
        self.isChecked = false;
        super.init(coder: aDecoder)
        self.setImage(uncheckedImage, forState: .Normal);
        
    }

    
    

    

}
