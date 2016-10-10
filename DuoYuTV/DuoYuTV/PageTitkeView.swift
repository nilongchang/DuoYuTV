//
//  PageTitkeView.swift
//  DuoYuTV
//
//  Created by apple on 16/10/10.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class PageTitkeView: UIView {
    
    var titles :[String]
    
    //懒加载
    fileprivate lazy var currentIndex :Int = 0
    fileprivate lazy var labels :[UILabel] = [UILabel]()
    
    fileprivate lazy var scrollView:UIScrollView = {
        
        let scrollView = UIScrollView()
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        
        return scrollView
        
    }()
    
    init(titles:[String],frame:CGRect){
        
        self.titles = titles
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        //1.添加scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //2.添加Label
        setLabels()
    }
    func setLabels(){
        
        let labelW:CGFloat = kScreenW/(CGFloat)(titles.count)
        let labelH:CGFloat = bounds.height - 2
        let labelY:CGFloat = 0
        
        
        
        
        
        for(index,title) in titles.enumerated(){
            
            let labelX:CGFloat = labelW * (CGFloat)(index)
          
            let titleLabel = UILabel()
            
            titleLabel.tag = index
            titleLabel.text = title
            titleLabel.textColor = UIColor.lightGray
            titleLabel.textAlignment = .center
            titleLabel.font = UIFont.systemFont(ofSize: 16.0)
            titleLabel.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(titleLabel)
            labels.append(titleLabel)
            
            titleLabel.isUserInteractionEnabled = true
            
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(_:)))
            
            titleLabel.addGestureRecognizer(tapGes)
        }
    }
    
}
extension PageTitkeView{
    
    @objc fileprivate func titleLabelClick(_ tapGes:UITapGestureRecognizer){
        
        guard  let currentLabel = tapGes.view as? UILabel else{return}
        
        if currentLabel.tag == currentIndex {return}
        
        let oldLabel = labels[currentIndex]
        
        
        
        
        currentIndex = currentLabel.tag
        
        
    }
    
    
}














