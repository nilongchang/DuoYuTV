//
//  PageTitkeView.swift
//  DuoYuTV
//
//  Created by apple on 16/10/10.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate:class  {
    
    func pageTitleView(_ titleView:PageTitkeView,selectIndex:Int)
}


fileprivate let kDufauilColor:UIColor = UIColor.gray
fileprivate let kSelectColor:UIColor = UIColor.orange
fileprivate let kScrollLineH:CGFloat  = 2
class PageTitkeView: UIView {
    
    var titles :[String]
    
    
    //懒加载
    fileprivate lazy var currentIndex :Int = 0
    fileprivate lazy var labels :[UILabel] = [UILabel]()
    
    weak var delegate:PageTitleViewDelegate?
    
    fileprivate lazy var scrollView:UIScrollView = {
        
        let scrollView = UIScrollView()
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        
        return scrollView
        
    }()
    
    fileprivate lazy var scrollLine:UIView = {
       
        let scrollLine = UIView()
        
        scrollLine.backgroundColor = kSelectColor
        
        
        return scrollLine
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
        
        
        print("setupUI")
        //1.添加scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
       
        //2.添加Label
        setLabels()
        
        //3.添加底部线
        
        setViewbottomLine()
        
        //4.添加colltionView
        
        
    }
    
    
    func setLabels(){
        
        let labelW:CGFloat = kScreenW/(CGFloat)(titles.count)
        let labelH:CGFloat = bounds.height - kScrollLineH
        let labelY:CGFloat = 0
        
        
        for(index,title) in titles.enumerated(){
            
            let labelX:CGFloat = labelW * (CGFloat)(index)
          
            let titleLabel = UILabel()
            
            titleLabel.tag = index
            titleLabel.text = title
            titleLabel.textColor = kDufauilColor
           
            titleLabel.textAlignment = .center
            titleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
            titleLabel.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(titleLabel)
            labels.append(titleLabel)
            
            titleLabel.isUserInteractionEnabled = true
            
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(_:)))
            
            titleLabel.addGestureRecognizer(tapGes)
        }
    }
    
    func setViewbottomLine(){
        
        let viewLine = UIView()
        viewLine.backgroundColor = UIColor.lightGray
        viewLine.frame = CGRect(x: 0, y: frame.height - 1, width: frame.width, height: 1)
        
        addSubview(viewLine)
        
        let cureenLabel = labels[currentIndex]
        cureenLabel.textColor = kSelectColor
        
        
        scrollLine.frame = CGRect(x: cureenLabel.frame.origin.x, y: scrollView.frame.height - kScrollLineH, width: cureenLabel.frame.width, height: kScrollLineH)
        
        scrollView.addSubview(scrollLine)
        
    }
    
}
extension PageTitkeView{
    
    @objc fileprivate func titleLabelClick(_ tapGes:UITapGestureRecognizer){
        
        guard  let currentLabel = tapGes.view as? UILabel else{return}
        
        if currentLabel.tag == currentIndex {return}
        
        let oldLabel = labels[currentIndex]
        
        oldLabel.textColor = kDufauilColor
        currentLabel.textColor = kSelectColor
        
        currentIndex = currentLabel.tag
        
        
        
        UIView.animate(withDuration: 0.15) {
            
           self.scrollLine.frame.origin.x = currentLabel.frame.origin.x
        }
        
        delegate?.pageTitleView(self, selectIndex: currentIndex)
    }
    
    
}
extension PageTitkeView{
    
    func setTitleWithProgress(_ progress: CGFloat, sourceIndex: Int, targetIndex: Int,colorProportion:CGFloat) {
        
        let scrollLineX =  progress * kScreenW/(CGFloat)(titles.count)
        
        self.scrollLine.frame.origin.x +=  scrollLineX
        
        let oldLabel = labels[sourceIndex]
        let currentLabel = labels[targetIndex]
        
        oldLabel.textColor = kDufauilColor
        currentLabel.textColor = kSelectColor
        
        print("colorProportion = \(colorProportion)")
    }
}













