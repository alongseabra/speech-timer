//
//  ChoiceView.swift
//  SpeechTimer
//
//  Created by Anson Long-Seabra on 4/4/15.
//  Copyright (c) 2015 Anson Long-Seabra. All rights reserved.
//

import UIKit


class ChoiceView: UIView {
    
    var checkBoxWidth : CGFloat;
    
    var checkBox : CheckBox;
    
    override init(frame: CGRect) {
        

        self.checkBoxWidth = frame.size.width / 8.0;
        
        self.checkBox = CheckBox(frame: CGRectMake(0, 0, checkBoxWidth, checkBoxWidth));
        
        super.init(frame: frame);

        self.addSubview(self.checkBox);
        
        self.backgroundColor = UIColor.blueColor();
        

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
