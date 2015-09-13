//
//  ChoiceView.swift
//  SpeechTimer
//
//  Created by Anson Long-Seabra on 4/4/15.
//  Copyright (c) 2015 Anson Long-Seabra. All rights reserved.
//

import UIKit

protocol ChoiceViewDelegate {
    //when this choiceView has a checkbox selected, we will send
    //ourselves to our containing view
    func choiceViewSelected(ChoiceView)
}

//Represents a choice, which is a CheckBox and UILabel
class ChoiceView: UIView, CheckBoxDelegate {
    
    //The percentage of the total width that the label takes up
    let labelRatio : CGFloat = 0.75;
    
    var checkBox : CheckBox;
    var checkBoxContainerView : PositioningView;
    var checkBoxWidth : CGFloat;

    var label : UILabel;
    var labelWidth : CGFloat;
    var labelHeight : CGFloat;
    
    //A description of what the choice represents
    var choice : String;
    
    //set up delegate(s)
    var delegate : ChoiceViewDelegate?;
    
    init(frame: CGRect, choice: String) {
        

        //setup the checkbox
        self.checkBoxWidth = frame.size.width;
        
        self.checkBox = CheckBox(frame: CGRectMake(frame.size.width / 8.0, frame.size.height / 3.0,
                                                    checkBoxWidth, frame.height));
        self.checkBoxContainerView = PositioningView(frame: CGRectMake(0,
                                                    frame.size.height / 3,
                                                    frame.size.width / 4,
                                                    frame.size.height / 3));
        self.checkBoxContainerView.addSubview(self.checkBox);
        self.checkBoxContainerView.centerSubview();
        
        //setup the label
        self.labelWidth = frame.size.width * self.labelRatio;
        self.labelHeight = frame.size.height;
        self.label = UILabel(frame: CGRectMake(frame.size.width * 0.25, 0, labelWidth, labelHeight));
        self.label.backgroundColor = UIColor.redColor();
        
        self.choice = choice;
        
        super.init(frame: frame);
    
        self.addSubview(self.checkBoxContainerView);
        self.addSubview(self.label);
        
        
        self.backgroundColor = UIColor.blueColor();
        self.checkBox.delegate = self;
    }
    
    //fired when the checkbox is tapped (button up)
    func checkBoxSelected() {
        
        //tell our containing view we have been chosen
        self.delegate?.choiceViewSelected(self);
        print("workin");
        
    }


    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
