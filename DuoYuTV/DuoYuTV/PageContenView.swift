//
//  PageContenView.swift
//  DuoYuTV
//
//  Created by apple on 16/10/12.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

private let ContentCellID = "ContentCellID"

protocol PageContenViewDelegate:class {
    
    func pageContenView(_ contenView:PageContenView,sourceIndex:Int,targetIndex:Int,progress:CGFloat,colorProportion:CGFloat)
}

class PageContenView: UIView {

    // MARK:-定义属性
    fileprivate var childVcs:[UIViewController]
    fileprivate weak var parentViewController:UIViewController?
    fileprivate var startOffsetX:CGFloat = 0
    fileprivate var isForbidScrollDelegate:Bool = false
    fileprivate var colorProportion:CGFloat = 0
    
    weak var delegate:PageContenViewDelegate?
    
    
    fileprivate lazy var collectionView :UICollectionView = {[weak self] in
       
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self as UICollectionViewDataSource?
        collectionView.delegate = self as UICollectionViewDelegate?
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
        
    }()
    
    init(frame: CGRect,childVcs:[UIViewController],parentViewController:UIViewController?) {
        
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        for childVc in childVcs{
            
            parentViewController?.addChildViewController(childVc)
        }
        
        
        addSubview(collectionView)
        collectionView.frame = bounds
        
    }
}

//MARK:- UICollectionmView 数据源方法 和  代理方法
extension PageContenView:UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.childVcs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        for view in cell.contentView.subviews{
            
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        
        childVc.view.frame = cell.contentView.bounds
        
        cell.contentView.addSubview(childVc.view)
        
        
        return cell
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
      
        // 关闭禁止代理方法
        isForbidScrollDelegate = false
        
        print("scrollViewWillBeginDragging")
        startOffsetX = scrollView.contentOffset.x
        colorProportion = 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        // 0.判断是否是点击事件
        if isForbidScrollDelegate { return }
        // 1.定义需要的获取的数据
        var progress :CGFloat = 0
        var sourceIndex :Int = 0
        var targetIndex :Int = 0
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
//        if currentOffsetX > startOffsetX {//左滑
        
            progress = (currentOffsetX - startOffsetX)/scrollViewW
            
            sourceIndex = Int(startOffsetX / scrollViewW)
            
            targetIndex = Int(currentOffsetX / scrollViewW)
        print("scrollViewDidScroll")
//        print("scrollViewDidScroll startOffsetX:\(startOffsetX) currentOffsetX:\(currentOffsetX) progress:\(progress)")
        colorProportion += progress
        if colorProportion >= 1 {
            colorProportion = 1
        }else if colorProportion <= 0{
            colorProportion = 0
        }
        
        startOffsetX = currentOffsetX
        delegate?.pageContenView(self, sourceIndex: sourceIndex, targetIndex: targetIndex, progress: progress,colorProportion:colorProportion)
        
        
//        }
        
        
        
        
    }
    
}

extension PageContenView{
    
    func setCurrentIndex(_ currentIndex:Int){
        
        
        // 0.记录需要禁止的代理方法
        isForbidScrollDelegate = true
        
        let offsetX = CGFloat( currentIndex) * collectionView.bounds.width
        
        collectionView.setContentOffset(CGPoint(x:offsetX,y:0), animated: false)
        
    }
}














