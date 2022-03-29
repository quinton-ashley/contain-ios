//
//  GameViewController.swift
//  SwiftGame
//
//  Created by Quinton Ashley on 10/29/19.
//  Copyright © 2019 Quinton Ashley. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
		let view = self.view as! SKView;
    let scene = GameScene(size: self.view.frame.size);
    view.presentScene(scene);
    view.ignoresSiblingOrder = true;
		
		// debugging
    view.showsFPS = true;
//    view.showsNodeCount = true;
//		view.showsPhysics = true;
//		view.showsFields = true;
  }
  
  override var shouldAutorotate: Bool {
    return true;
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
		return .portrait;
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning();
    // Release any cached data, images, etc that aren't in use.
  }
  
  override var prefersStatusBarHidden: Bool {
    return true;
  }
}
