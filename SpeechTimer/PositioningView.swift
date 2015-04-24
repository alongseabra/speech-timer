//
//  PositioningView.swift
//  SpeechTimer
//
//  Created by Anson Long-Seabra on 4/6/15.
//  Copyright (c) 2015 Anson Long-Seabra. All rights reserved.
//

import UIKit


//A class that can position its subview
class PositioningView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame);
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func centerSubview()
    {
        var sub : UIView = self.subviews[0] as UIView;
        sub.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    }

}
