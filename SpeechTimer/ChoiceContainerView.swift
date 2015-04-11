//
//  ChoiceContainerView.swift
//  SpeechTimer
//
//  Created by Anson Long-Seabra on 4/6/15.
//  Copyright (c) 2015 Anson Long-Seabra. All rights reserved.
//

import UIKit


//Contains ChoiceViews. Only one can be selected at a time, like a radio button
class ChoiceContainerView: UIView, ChoiceViewDelegate{
    
    //the choice currently selected
    var selectedChoice : ChoiceView!;
    
    //all ChoiceViews contained in this class
    var choices : [ChoiceView];
    
    override init(frame: CGRect) {

        self.choices = [ChoiceView]();
        super.init(frame: frame);
        
    }
    
    //Adds a choiceView as a subview, and assigns self as delegate
    //also adds to the array
    func addChoiceView(choiceView : ChoiceView)
    {
        self.addSubview(choiceView);
        self.choices.append(choiceView);
        choiceView.delegate = self;
    }
    
    
    //Each time a different ChoiceView is seleced, we uncheck
    //the other ones and set selectedChoice to the current selection
    func choiceViewSelected(view : ChoiceView)
    {
        self.selectedChoice = view;
        for row in self.choices {
            if (row.choice != view.choice) {
                row.checkBox.isChecked = false;
            }
        
        }
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
