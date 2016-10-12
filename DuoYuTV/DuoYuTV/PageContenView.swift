//
//  PageContenView.swift
//  DuoYuTV
//
//  Created by apple on 16/10/12.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

private let ContentCellID = "ContentCellID"

class PageContenView: UIView {

    // MARK:-定义属性
    fileprivate var childVcs:[UIViewController]
    fileprivate weak var parentViewController:UIViewController?
    fileprivate var startOffsetX:CGFloat = 0
    fileprivate var isForbidScrollDelegate:Bool = false
    
    fileprivate lazy var collectionView :UICollectionView = {[weak self] in
       
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPrefetchingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self as UICollectionViewDataSource?
        collectionView.delegate = self as! UICollectionViewDelegate?
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
extension PageContenView:UICollectionViewDataSource{
    
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
    
}
















