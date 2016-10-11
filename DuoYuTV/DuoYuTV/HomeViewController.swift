//
//  HomeViewController.swift
//  DuoYuTV
//
//  Created by apple on 16/10/10.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false
        
        setnavigetionLeftBar()
        setnaVigetionRightBar()
        
        setTitleView()
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
  
    func setTitleView(){
        
        
        let  titles = ["推荐","游戏","娱乐","趣玩"]
        
        let titleView =  PageTitkeView(titles: titles, frame: CGRect(x: 0, y: 64, width: kScreenW, height: 40))
        
        self.view.addSubview(titleView)
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
