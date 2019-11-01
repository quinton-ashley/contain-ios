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
    
    let view = self.view as! SKView
      // Load the SKScene from 'GameScene.sks'
    let scene = GameScene(size: self.view.frame.size);
        // Set the scale mode to scale to fit the window
//        scene.scaleMode = .aspectFill;
    view.presentScene(scene);
    view.ignoresSiblingOrder = true;
		
		// debugging
    view.showsFPS = true;
    view.showsNodeCount = true;
		view.showsPhysics = true;
		view.showsFields = true;
  }
  
  override var shouldAutorotate: Bool {
    return true;
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
		return .portrait;
//    if UIDevice.current.userInterfaceIdiom == .phone {
//      return .allButUpsideDown;
//    } else {
//      return .all;
//    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning();
    // Release any cached data, images, etc that aren't in use.
  }
  
  override var prefersStatusBarHidden: Bool {
    return true;
  }
}
