//
//  ChoiceContainerView.swift
//  SpeechTimer
//
//  Created by Anson Long-Seabra on 4/6/15.
//  Copyright (c) 2015 Anson Long-Seabra. All rights reserved.
//

import UIKit

class ChoiceContainerView: UIView{
    
    var choiceViews : [ChoiceView];
    var selectedChoice : ChoiceView!;
    
    override init(frame: CGRect) {

        self.choiceViews = [ChoiceView]();
        super.init(frame: frame);
        
    }


    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
