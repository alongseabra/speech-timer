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
    var choices : [ChoiceView]?;
    
    override init(frame: CGRect) {

        super.init(frame: frame);
        
    }
    
    //Adds a choiceView as a subview, and assigns self as delegate
    //also adds to the array
    func addChoiceView(choiceView : ChoiceView)
    {
        self.addSubview(choiceView);
        self.choices?.append(choiceView);
        choiceView.delegate = self;
    }
    
    
    
    func choiceViewSelected(view : ChoiceView)
    {
        print(view.choice + " was selected");
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
