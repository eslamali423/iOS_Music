//
//  MainTableViewController.swift
//  Podcast
//
//  Created by Eslam Ali  on 29/06/2022.
//

import UIKit

class MainTableViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1 = UINavigationController(rootViewController: MusicViewController())
        let vc2 = UINavigationController(rootViewController: PodcastViewController())
     
        
        vc1.tabBarItem.image = UIImage(systemName: "music.note")
        vc2.tabBarItem.image = UIImage(systemName: "music.mic")
        
        vc1.title = "Music"
        vc2.title = "Podcasts"
        
        tabBar.tintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        
        setViewControllers([vc1,vc2], animated: false)
        
    }

  
    
    

   

}
