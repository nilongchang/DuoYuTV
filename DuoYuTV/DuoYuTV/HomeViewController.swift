//
//  HomeViewController.swift
//  DuoYuTV
//
//  Created by apple on 16/10/10.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

private let kTitleViewH:CGFloat = 40

class HomeViewController: UIViewController {
    
    
    fileprivate lazy var pageTitleView:PageTitkeView = {[weak self] in
        
        let  titles = ["推荐","游戏","娱乐","趣玩"]
        
        let titleView =  PageTitkeView(titles: titles, frame: CGRect(x: 0, y: 64, width: kScreenW, height: kTitleViewH))
        
        titleView.delegate = self as PageTitleViewDelegate?
        
        return titleView
    }()
    
    fileprivate lazy var pageContenView:PageContenView = {[weak self] in
        
        var childs = [UIViewController]()
        
        let pageContenViewFrame = CGRect(x: 0, y: 64 + kTitleViewH, width: kScreenW, height: kScreenH -  64 - kTitleViewH - kTabBarH)
        
        for tag in 0..<4{
            
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            
            vc.view.tag = tag
            
            childs.append(vc)
        }
        
        let contenView = PageContenView(frame: pageContenViewFrame , childVcs: childs, parentViewController: self)
        
        contenView.delegate = self as PageContenViewDelegate?
        
        return contenView
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
       
    }

    func setupUI(){
       
        self.automaticallyAdjustsScrollViewInsets = false
        
        setnavigetionBar()
        
        view.addSubview(pageTitleView)
        
        view.addSubview(pageContenView)
    }
    
    func setnavigetionBar(){
        
        setnavigetionLeftBar()
        
        setnaVigetionRightBar()
        
    }
    func setnavigetionLeftBar(){
        
        navigationItem.leftBarButtonItem = UIBarButtonItem (image: #imageLiteral(resourceName: "Image_launch_logo"), style: .plain, target: self, action: nil)
    }
    
    func setnaVigetionRightBar(){
        
        let historyItme  = UIBarButtonItem (image: #imageLiteral(resourceName: "image_my_history"), style: .done, target: self, action:#selector(self.historyClick))
        
        let scanItme  = UIBarButtonItem (image: #imageLiteral(resourceName: "Image_scan"), style: .done, target: self, action:#selector(self.scanClick))
        let searchItme  = UIBarButtonItem (image: #imageLiteral(resourceName: "btn_search"), style: .done, target: self, action:#selector(self.searchClick))
        
        navigationItem.rightBarButtonItems = [historyItme,scanItme,searchItme]
    }
  
    
    
    @objc private  func historyClick()  {
        print("historyClick")
    }
    @objc private  func scanClick()  {
        print("scanClick")
    }
    
    @objc private  func searchClick()  {
        print("searchClick")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    

}

//MARK:- PageTitleViewDelegate代理方法
extension HomeViewController:PageTitleViewDelegate{
    
    func pageTitleView(_ titleView: PageTitkeView, selectIndex: Int) {
        
        pageContenView.setCurrentIndex(selectIndex)
    }
    
}

//MARK:- PageContenView ---代理
extension HomeViewController:PageContenViewDelegate{
    
    func pageContenView(_ contenView: PageContenView, sourceIndex: Int, targetIndex: Int, progress: CGFloat,colorProportion:CGFloat) {
        
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex,colorProportion:colorProportion)
    }
    
    
}



