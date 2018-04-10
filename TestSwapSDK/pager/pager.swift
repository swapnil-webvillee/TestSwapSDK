//
//  pager.swift
//  DemoApp
//
//  Created by WVMAC3 on 09/01/18.
//  Copyright © 2018 WVMAC3. All rights reserved.
//

import UIKit

public class pager: UICollectionViewCell {
    
    var arrImage = UIImageView()
    var lblTitle = UILabel()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        headerView.backgroundColor = #colorLiteral(red: 0.9486700892, green: 0.9493889213, blue: 0.9487814307, alpha: 1)
        
        arrImage.frame = CGRect.init(x: 0, y: 0, width: headerView.frame.size.width, height: headerView.frame.size.height-60)
        headerView.addSubview(arrImage)
        
        lblTitle.frame = CGRect.init(x: 5, y:headerView.frame.size.height-50, width: headerView.frame.size.width-10, height: 45)
        lblTitle.numberOfLines = 0
        lblTitle.font = UIFont.systemFont(ofSize: 14)
        lblTitle.textColor = .red
        headerView.addSubview(lblTitle)
        
        self.addSubview(headerView)
        }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    
}
