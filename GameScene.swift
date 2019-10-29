//
//  GameScene.swift
//  CONTAIN
//
//  Created by Quinton Ashley on 10/29/19.
//  Copyright © 2019 Quinton Ashley. All rights reserved.
//
import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {

	var paddleArray: Array<SKNode> = [];
	var universalArray: Array<SKNode> = [];
	var gameArray: Array<SKNode> = [];
	var mainArray: Array<SKNode> = [];
	var selectArray: Array<SKNode> = [];
	lazy var playTimer: Timer = {
		return Timer.scheduledTimer(timeInterval: 1, target: self, selector: Selector(("timePassed")), userInfo: nil, repeats: true);
	}();
//	var screenWidth: CGFloat = size.width;
//	var screenHeight: CGFloat = size.height;
	lazy var screenWidth: CGFloat = {
		if (size.width < 600) {
			return size.width;
		} else {
			return size.width/1.24;
		}
	}();
	lazy var screenHeight: CGFloat = {
		return size.height;
	}();
	lazy var midX: CGFloat = {
		return screenWidth/2;
	}();
	lazy var midY: CGFloat = {
		return screenWidth/2;
	}();
	lazy var center: CGPoint = {
		return CGPoint(x: midX, y: screenHeight-midX);
	}();
	var numPaddles: CGFloat = 0;
	var numBalls: CGFloat = 0;
	var numContain: CGFloat = 0;
	var ballCategory: UInt32 = 0x1<<0;
	var paddleCategory: UInt32 = 0x1<<1;
	var boundCategory: UInt32 = 0x1<<2;
	var ballRadius: CGFloat = 100;
	lazy var ballVector: CGVector = {
		return CGVector(dx: 0, dy: -midX*(ballSpeedFactor/10000));
	}();
	var ballSpeedFactor: CGFloat = 1100;
	lazy var padRadius0: CGFloat = {
		return midX/9.1;
	}();
	lazy var padRadius: CGFloat = {
		return midX/9.1;
	}();
	var angle: CGFloat = 0.0;
	var item: CGFloat = -1;
	var ballTime: CGFloat = 0.0;
	var playTime: CGFloat = 0.0;
	var padRevolve: Bool = false;
	var userFromLoad: Bool = false;
	var userInGame: Bool = false;
	var userPlaying: Bool = false;
	var userMainMenu: Bool = false;
	var userSelectMenu: Bool = false;
	var userGameOver: Bool = false;
	var userTutorial: Bool = false;
	var pauseGame: Bool = false;
	var transitionTime: TimeInterval = 0.2;
	var energy0: CGFloat = 400;
	var energy: CGFloat = 400;
	lazy var eBarY: CGFloat = {
		return screenHeight-midX*2.1;
	}();
	lazy var eBarHeight: CGFloat = {
		return midX/150;
	}();
	lazy var energyBar: SKShapeNode = {
		return SKShapeNode(rect: CGRect(x: 0, y: eBarY, width: midX*2*energy/energy0, height: eBarHeight));
	}();
	lazy var scoreLabel: SKLabelNode = {
		return SKLabelNode(text: "\(playTime*5)");
	}();
	lazy var energyLabel: SKLabelNode = {
		return SKLabelNode(text: "\(energy/4)");
	}();
	lazy var scorePosition: CGPoint = {
		return CGPoint(x: midX/6, y: screenHeight-midX*3);
	}();
	lazy var energyPosition: CGPoint = {
		return CGPoint(x: midX*1.82, y: screenHeight-midX*3);
	}();
	lazy var rotaten90: SKAction = {
		return SKAction.rotate(byAngle: -.pi/2, duration: transitionTime);
	}();
	lazy var rotate90: SKAction = {
		return SKAction.rotate(byAngle: .pi/2, duration: transitionTime);
	}();
	lazy var gameu0resize: SKAction = {
		return SKAction.resize(toWidth: midX, height: midX/2, duration: transitionTime);
	}();
	lazy var gameu2resize: SKAction = {
		return SKAction.resize(toWidth: midX*1.4, height: midX*1.1, duration: transitionTime);
	}();
	lazy var gameu1move: SKAction = {
		return SKAction.move(to: CGPoint(x: midX/6, y: screenHeight-midX*2.4), duration: transitionTime);
	}();
	lazy var gameu2move: SKAction = {
		return SKAction.move(to: CGPoint(x: midX, y: screenHeight-midX*2.65), duration: transitionTime);
	}();
	lazy var gameu3move: SKAction = {
		return SKAction.move(to: CGPoint(x: midX*1.84, y: screenHeight-midX*2.4), duration: transitionTime);
	}();
	lazy var overu0resize: SKAction = {
		return SKAction.resize(toWidth: midX/3, height: midX/6, duration: transitionTime);
	}();
	lazy var pauseboxresize: SKAction = {
		return SKAction.resize(toWidth: midX/2, height: midX/3, duration: transitionTime);
	}();
	lazy var pauseu0move: SKAction = {
		return SKAction.move(to: CGPoint(x: midX, y: screenHeight-midX*4), duration: transitionTime);
	}();
	lazy var pauseu1move: SKAction = {
		return SKAction.move(to: CGPoint(x: midX/3, y: screenHeight-midX*2.2), duration: transitionTime);
	}();
	lazy var pauseu2move: SKAction = {
		return SKAction.move(to: CGPoint(x: midX, y: screenHeight-midX*2.2), duration: transitionTime);
	}();
	lazy var pauseu3move: SKAction = {
		return SKAction.move(to: CGPoint(x: midX*5/3, y: screenHeight-midX*2.2), duration: transitionTime);
	}();
	lazy var mainboxresize: SKAction = {
		return SKAction.resize(toWidth: midX, height: midX/3, duration: transitionTime);
	}();
	lazy var mainu0resize: SKAction = {
		return SKAction.resize(toWidth: midX*1.5, height: midX, duration: transitionTime);
	}();
	lazy var mainu0move: SKAction = {
		return SKAction.move(to: CGPoint(x: midX, y: screenHeight-midX), duration: transitionTime);
	}();
	lazy var mainu1move: SKAction = {
		return SKAction.move(to: CGPoint(x: midX, y: screenHeight-midX*2.1), duration: transitionTime);
	}();
	lazy var mainu2move: SKAction = {
		return SKAction.move(to: CGPoint(x: midX, y: screenHeight-midX*2.5), duration: transitionTime);
	}();
	lazy var mainu3move: SKAction = {
		return SKAction.move(to: CGPoint(x: midX, y: screenHeight-midX*2.9), duration: transitionTime);
	}();
//  lazy var didBecomeActiveNotification: NSNotification = {
//    return NSNotification(name: UIApplication.didBecomeActiveNotification, object: self);
//  }();
//  lazy var willResignActiveNotification: NSNotification = {
//    return NSNotification(name: UIApplication.willResignActiveNotification, object: self);
//  }();
  
  override init(size: CGSize) {
    super.init(size: size);
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override public func didMove(to view: SKView) {
    print("Hiii");
		backgroundColor = SKColor(white: 0.05, alpha: 1);
		physicsWorld.gravity = CGVector(dx: 0.0, dy:0.0);
		physicsWorld.contactDelegate = self;
		let border1: SKShapeNode = SKShapeNode(rectOf: CGSize(width: screenWidth+40, height: 10));
		border1.fillColor = SKColor.clear;
		border1.strokeColor = SKColor.clear;
		border1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: screenWidth+40, height: 10));
		border1.position = CGPoint(x: midX, y: screenHeight+15);
		border1.physicsBody?.isDynamic = false;
		border1.physicsBody?.categoryBitMask = boundCategory;
		border1.physicsBody?.collisionBitMask = 0x1<<10;
		border1.physicsBody?.contactTestBitMask = ballCategory;
		let border2: SKShapeNode = SKShapeNode(rectOf: CGSize(width: 10, height: screenWidth+40));
		border2.fillColor = SKColor.clear;
		border2.strokeColor = SKColor.clear;
		border2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 10, height: screenWidth+40));
		border2.position = CGPoint(x: -15, y: screenHeight-midX);
		border2.physicsBody?.isDynamic = false;
		border2.physicsBody?.categoryBitMask = boundCategory;
		border2.physicsBody?.collisionBitMask = 0x1<<10;
		border2.physicsBody?.contactTestBitMask = ballCategory;
		let border3: SKShapeNode = SKShapeNode(rectOf: CGSize(width: 10, height: screenWidth+40));
		border3.fillColor = SKColor.clear;
		border3.strokeColor = SKColor.clear;
		border3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 10, height: screenWidth+40));
		border3.position = CGPoint(x: screenWidth+15, y: screenHeight-midX);
		border3.physicsBody?.isDynamic = false;
		border3.physicsBody?.categoryBitMask = boundCategory;
		border3.physicsBody?.collisionBitMask = 0x1<<10;
		border3.physicsBody?.contactTestBitMask = ballCategory;
		let border4: SKShapeNode = SKShapeNode(rectOf: CGSize(width: screenWidth+40, height: 10));
		border4.fillColor = SKColor.clear;
		border4.strokeColor = SKColor.clear;
		border4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: screenWidth+40, height: 10));
		border4.position = CGPoint(x: midX, y: screenHeight-screenWidth-15);
		border4.physicsBody?.isDynamic = false;
		border4.physicsBody?.categoryBitMask = boundCategory;
		border4.physicsBody?.collisionBitMask = 0x1<<10;
		border4.physicsBody?.contactTestBitMask = ballCategory;
		let u0: SKSpriteNode = SKSpriteNode(imageNamed: "Contain-title");
		let u1: SKSpriteNode = SKSpriteNode(imageNamed: "Contain-box1");
		let u2: SKSpriteNode = SKSpriteNode(imageNamed: "Contain-box");
		let u3: SKSpriteNode = SKSpriteNode(imageNamed: "Contain-box2");
		let u4: SKSpriteNode = SKSpriteNode(imageNamed: "Contain-box2");
		let u5: SKSpriteNode = SKSpriteNode(imageNamed: "Contain-box1");
		let u6: SKSpriteNode = SKSpriteNode(imageNamed: "Contain-returntomenu");
		let u7: SKSpriteNode = SKSpriteNode(imageNamed: "Contain-unpause");
		let u8: SKSpriteNode = SKSpriteNode(imageNamed: "Contain-reset");
		let g0: SKSpriteNode = SKSpriteNode(imageNamed: "Contain-titlefilled");
		let g1: SKSpriteNode = SKSpriteNode(imageNamed: "Contain-addball");
		let g2: SKSpriteNode = SKSpriteNode(imageNamed: "Contain-itemplaceholder");
		let g3: SKSpriteNode = SKSpriteNode(imageNamed: "Contain-refill");
		let g4: SKSpriteNode = SKSpriteNode(imageNamed: "Contain-pause");
		let g5: SKSpriteNode = SKSpriteNode(imageNamed: "Contain-score");
		let g6: SKSpriteNode = SKSpriteNode(imageNamed: "Contain-energy");
		let m0: SKSpriteNode = SKSpriteNode(imageNamed: "Contain-credits");
		let m1: SKSpriteNode = SKSpriteNode(imageNamed: "Contain-playlabel");
		let m2: SKSpriteNode = SKSpriteNode(imageNamed: "Contain-highscorelabel");
		let m3: SKSpriteNode = SKSpriteNode(imageNamed: "Contain-howtolabel");
		let s0: SKSpriteNode = SKSpriteNode(imageNamed: "Contain-selectdifficulty");
		let s1: SKSpriteNode = SKSpriteNode(imageNamed: "Contain-normallabel");
		let s2: SKSpriteNode = SKSpriteNode(imageNamed: "Contain-hardlabel");
		let s3: SKSpriteNode = SKSpriteNode(imageNamed: "Contain-brutallabel");
		u0.position = CGPoint(x: midX, y: screenHeight-midX);
		u1.position = CGPoint(x: midX, y: screenHeight-midX*2.1);
		u2.position = CGPoint(x: midX, y: screenHeight-midX*2.5);
		u3.position = CGPoint(x: midX, y: screenHeight-midX*2.9);
		u4.position = CGPoint(x: midX/6, y: screenHeight-midX*2.9);
		u5.position = CGPoint(x: midX*1.84, y: screenHeight-midX*2.9);
		u7.position = CGPoint(x: midX, y: screenHeight-midX*2.65);
		g0.position = CGPoint(x: midX, y: screenHeight-midX*2.65);
		g1.position = CGPoint(x: midX/6, y: screenHeight-midX*2.4);
		g2.position = CGPoint(x: midX/6, y: screenHeight-midX*2.4);
		g3.position = CGPoint(x: midX/6, y: screenHeight-midX*2.4);
		u6.position = CGPoint(x: midX/6, y: screenHeight-midX*2.4);
		g4.position = CGPoint(x: midX*1.84, y: screenHeight-midX*2.4);
		u8.position = CGPoint(x: midX*1.84, y: screenHeight-midX*2.4);
		g5.position = CGPoint(x: midX/6, y: screenHeight-midX*2.76);
		g6.position = CGPoint(x: midX*1.84, y: screenHeight-midX*2.85);
		m0.position = CGPoint(x: midX, y: screenHeight-midX*1.6);
		m1.position = CGPoint(x: midX, y: screenHeight-midX*2.1);
		m2.position = CGPoint(x: midX, y: screenHeight-midX*2.5);
		m3.position = CGPoint(x: midX, y: screenHeight-midX*2.9);
		s0.position = CGPoint(x: midX, y: screenHeight-midX*1.6);
		s1.position = CGPoint(x: midX/3, y: screenHeight-midX*2.2);
		s2.position = CGPoint(x: midX, y: screenHeight-midX*2.2);
		s3.position = CGPoint(x: midX*5/3, y: screenHeight-midX*2.2);
		u0.size = CGSize(width: midX*1.5, height: midX);
		u1.size = CGSize(width: midX, height: midX/3);
		u2.size = u1.size;
		u3.size = u1.size;
		u4.size = CGSize(width: midX/3, height: midX/2);
		u5.size = u4.size;
		u7.size = u4.size;
		g0.size = CGSize(width: midX, height: midX/2);
		g1.size = CGSize(width: midX/4, height: midX/3);
		g3.size = g1.size;
		g4.size = g1.size;
		g5.size = g1.size;
		g6.size = g1.size;
		u6.size = g1.size;
		u8.size = g1.size;
		g2.size = CGSize(width: midX/4.5, height: midX/3.5);
		g5.size = CGSize(width: midX/5, height: midX/9);
		m0.size = CGSize(width: midX, height: midX/4);
		m1.size = CGSize(width: midX*3/4, height: midX/3);
		m2.size = CGSize(width: midX*4/5, height: midX/4);
		m3.size = CGSize(width: midX*3/4, height: midX/4);
		s0.size = CGSize(width: midX, height: midX/4);
		s1.size = CGSize(width: midX/2.5, height: midX/4);
		s2.size = CGSize(width: midX/3, height: midX/4.5);
		s3.size = CGSize(width: midX/2.5, height: midX/5);
		universalArray = [u0,u1,u2,u3,u4,u5,u6,u7,u8];
		gameArray = [g0,g1,g2,g3,g4,g5,g6];
		mainArray = [m0,m1,m2,m3];
		selectArray = [s0,s1,s2,s3];

		userFromLoad = true;
		addChild(border1);
		addChild(border2);
		addChild(border3);
		addChild(border4);
		addChild(universalArray[0]);
		addChild(mainArray[0]);
		Timer.scheduledTimer(timeInterval: 3, target: self, selector: Selector(("setupMainMenu")), userInfo: nil, repeats: false);
	}

	func setupMainMenu() {
		pauseGame = false;
		if (userFromLoad) {
			numContain = -1;
			for i in 1..<4 {
				addChild(universalArray[i]);
			}
			for i in 1..<mainArray.count {
				addChild(mainArray[i]);
			}
			userFromLoad = false;
		} else if (!userPlaying) {
			backgroundColor = SKColor(white: 0.05, alpha: 1);
			universalArray[0].run(mainu0resize);
			universalArray[1].run(mainboxresize);
			universalArray[2].run(mainboxresize);
			universalArray[3].run(mainboxresize);
			universalArray[1].run(rotate90);
			universalArray[3].run(rotaten90);
			universalArray[0].run(mainu0move);
			universalArray[1].run(mainu1move);
			universalArray[2].run(mainu2move);
			universalArray[3].run(mainu3move);
			universalArray[4].removeFromParent();
			universalArray[5].removeFromParent();
			universalArray[6].removeFromParent();
			if (!userTutorial) {
				universalArray[8].removeFromParent();
			}
			gameArray[5].removeFromParent();
			gameArray[6].removeFromParent();
			scoreLabel.removeFromParent();
			energyLabel.removeFromParent();
			if (!userGameOver) {
				universalArray[7].removeFromParent()
			}
			for i in 0..<mainArray.count {
				addChild(mainArray[i]);
			}
			userTutorial = false;
			userInGame = false;
		}
		userMainMenu = true;
	}

	func setupSelectMenu() {
		pauseGame = false
		for i in 0..<mainArray.count {
			mainArray[i].removeFromParent();
		}
		universalArray[1].run(pauseboxresize);
		universalArray[2].run(pauseboxresize);
		universalArray[3].run(pauseboxresize);
		universalArray[1].run(pauseu1move);
		universalArray[2].run(pauseu2move);
		universalArray[3].run(pauseu3move);
		for i in 0..<selectArray.count {
			addChild(selectArray[i]);
		}
		userSelectMenu = true;
	}

	func viewHighScores() {
		pauseGame = false;
	}

	func setupHowToPlay() {
		userTutorial = true;
		numContain = 1;
		setupGameButtons();
		startGame();
	}

	func setupGameButtons() {
		universalArray[0].run(gameu0resize);
		universalArray[0].run(gameu2move);
		if (item == -1) {
			addChild(gameArray[2]);
		} else if (item == 0) {
			addChild(gameArray[1]);
		} else if (item == 1) {
			addChild(gameArray[3]);
		}
		addChild(gameArray[4]);
		if (userSelectMenu) {
			universalArray[2].run(gameu2resize);
			universalArray[1].run(rotaten90);
			universalArray[3].run(rotate90);
			universalArray[1].run(gameu1move);
			universalArray[2].run(gameu2move);
			universalArray[3].run(gameu3move);
			addChild(universalArray[4]);
			addChild(universalArray[5]);
			addChild(gameArray[5]);
			addChild(gameArray[6]);
			for i in 0..<selectArray.count {
				selectArray[i].removeFromParent();
			}
			userSelectMenu = false;
		} else if (userMainMenu) {
			universalArray[1].run(pauseboxresize);
			universalArray[2].run(gameu2resize);
			universalArray[3].run(pauseboxresize);
			universalArray[1].run(rotaten90);
			universalArray[3].run(rotate90);
			universalArray[1].run(gameu1move);
			universalArray[2].run(gameu2move);
			universalArray[3].run(gameu3move);
			addChild(universalArray[4]);
			addChild(universalArray[5]);
			addChild(gameArray[5]);
			addChild(gameArray[6]);
			for i in 0..<mainArray.count {
				mainArray[i].removeFromParent();
			}
			userMainMenu = false;
		} else if (!userPlaying) {
			universalArray[6].removeFromParent()
			universalArray[8].removeFromParent()
		} else if (userGameOver) {
			playTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: Selector(("timePassed")), userInfo: nil, repeats: true);
			backgroundColor = SKColor(white: 0.05, alpha: 1);
			userPlaying = true;
			pauseGame = false;
			universalArray[7].removeFromParent();
		}
	}

	func setupPauseMenu() {
		if userInGame && userPlaying && !userTutorial {
			backgroundColor = SKColor(white: 0.4, alpha: 1);
			userPlaying = false;
			pauseGame = true;
			universalArray[0].position = CGPoint(x: midX, y: screenHeight-midX*4);
			addChild(universalArray[6]);
			addChild(universalArray[7]);
			addChild(universalArray[8]);
			if item == -1 {
				gameArray[2].removeFromParent();
			} else if item == 0 {
				gameArray[1].removeFromParent();
			} else if item == 1 {
				gameArray[3].removeFromParent();
			}
			gameArray[4].removeFromParent();
			playTimer.invalidate();
		}
	}

	func applicationDidBecomeActive() {
		if userInGame && !userPlaying && !userTutorial {
			pauseGame = true;
		}
	}

	func applicationWillResignActive() {
		if userTutorial {
			gameOver();
			gameArray[2].removeFromParent();
			gameArray[4].removeFromParent();
			setupMainMenu();
		} else {
			setupPauseMenu();

		}
	}

	func gameOver() {
		if !padRevolve {
			gameArray[0].removeFromParent();
		}
		if userGameOver {
			universalArray[0].run(overu0resize);
			universalArray[0].run(pauseu0move);
			addChild(universalArray[6]);
			if !userTutorial {
				addChild(universalArray[8]);
			}
			gameArray[1].removeFromParent();
			gameArray[2].removeFromParent();
			gameArray[3].removeFromParent();
			gameArray[4].removeFromParent();
		} else {
			pauseGame = false

		}
		enumerateChildNodes(withName: "ball_normal", using: { (node: SKNode, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
			node.removeFromParent();
		});
		enumerateChildNodes(withName: "ball_blink", using: { (node: SKNode, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
			node.removeFromParent();
		});
		
		
		enumerateChildNodes(withName: "ball_speedshift", using: { (node: SKNode, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
			node.removeFromParent();
		});
		for i in 0..<paddleArray.count {
			paddleArray[i].removeFromParent();
		}
		energyBar.removeFromParent();
		playTimer.invalidate();
		userPlaying = false;
		userInGame = false;
	}

	func startGame() {
		playTimer.invalidate();
		playTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: Selector(("timePassed")), userInfo: nil, repeats: true);
		backgroundColor = SKColor(white: 0.05, alpha: 1);
		numBalls = 0;
		angle = 0;
		playTime = 0;
		item = -1;
		numPaddles = 8;
		ballSpeedFactor = 1100;
		energy = energy0;
		energyBar.fillColor = SKColor.white;
		addChild(energyBar);
		
		scoreLabel.removeFromParent();
		energyLabel.removeFromParent();
		
		scoreLabel = SKLabelNode(text: "\(playTime*10000)");
		scoreLabel.position = scorePosition;
		scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center;
		scoreLabel.fontSize = 20;
		scoreLabel.fontName = "AvenirNext-Regular";
		addChild(scoreLabel);
		energyLabel = SKLabelNode(text: "\(energy/4)");
		energyLabel.position = energyPosition;
		energyLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center;
		energyLabel.fontSize = 20;
		energyLabel.fontName = "AvenirNext-Regular";
		addChild(energyLabel);
		if userTutorial {
			ballTime = -1;
		} else {
			ballTime = 2;
			addBall();
			if (numContain > 1) {
				addBall();
			}

		}
		padRadius = padRadius0;
		let padPath = CGMutablePath();
		padPath.addArc(center: CGPoint(x: 0, y: 0), radius: padRadius, startAngle: CGFloat(GLKMathDegreesToRadians(348)), endAngle: CGFloat(GLKMathDegreesToRadians(208)), clockwise: true);
		padPath.addArc(center: CGPoint(x: 0, y: 0), radius: padRadius-padRadius/8, startAngle: CGFloat(GLKMathDegreesToRadians(555)), endAngle: CGFloat(GLKMathDegreesToRadians(0)), clockwise: true);
		for i in 0..<paddleArray.count {
			paddleArray[i] = Paddle(path: padPath, radius: padRadius);
			addChild(paddleArray[i]);
		}
		userGameOver = false
		userInGame = true;
		userPlaying = true;
		padRevolve = true;
	}

	func timePassed() {
		if (userPlaying) {
			playTime += 1;
			scoreLabel.removeFromParent();
			scoreLabel.position = scorePosition;
			scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center;
			scoreLabel.fontSize = 20;
			scoreLabel.fontName = "AvenirNext-Regular";
			addChild(scoreLabel);
			energyLabel.removeFromParent();
			energyLabel = SKLabelNode(text: "\(energy/4)");
			energyLabel.position = energyPosition;
			energyLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center;
			energyLabel.fontSize = 20;
			energyLabel.fontName = "AvenirNext-Regular";
			addChild(energyLabel);
			if (playTime == ballTime) {
				addBall();
				ballTime = playTime+40+(numContain*5);
			}
			enumerateChildNodes(withName: "ball_blink", using: { (node: SKNode, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
				if node.alpha == 1.0 {
					node.alpha = 0.4
				} else {
					node.alpha = 1.0

				}

			});
			if (userTutorial) {
				if (playTime == 5) {
					addTutorialBall();
				} else if (playTime == 4) {
					userGameOver = true;
					gameOver();
				}
			}
		}
	}

	func touchesBegan(_ touches: Set<UITouch>, withEvent event: UIEvent) {
		for touch in touches {
			response0(touch.location(in: self));
		}
	}

	func touchesEnded(_ touches: Set<UITouch>, withEvent event: UIEvent) {
		for touch in touches {
			response1(touch.location(in: self));
		}
	}

//  override func mouseDown(with event: NSEvent) {
//    self.touchDown(atPoint: event.location(in: self));
//  }
//
//  override func mouseDragged(with event: NSEvent) {
//    self.touchMoved(toPoint: event.location(in: self));
//  }
//
//  override func mouseUp(with event: NSEvent) {
//    self.touchUp(atPoint: event.location(in: self));
//  }

	func response0(_ location: CGPoint) {
		if !userInGame {
			if userMainMenu {
				if universalArray[1].frame.contains(location) {
					userMainMenu = false
					setupSelectMenu()
				} else if universalArray[2].frame.contains(location) {
					viewHighScores()
				} else if universalArray[3].frame.contains(location) {
					setupHowToPlay()
				}
			} else if userSelectMenu {
				if universalArray[1].frame.contains(location) {
					numContain = 1
				} else if universalArray[2].frame.contains(location) {
					numContain = 2
				} else if universalArray[3].frame.contains(location) {
					numContain = 3
				}
				if numContain != 0 {
					setupGameButtons()
					startGame()
				}
			} else if userGameOver {
				if universalArray[1].frame.contains(location) {
					setupMainMenu()
				} else if universalArray[3].frame.contains(location) && !userTutorial {
					setupGameButtons()
					startGame()
				}
			}
		} else {
			if userPlaying {
				if location.y < midY {
					if location.x < midX/4 {
						if universalArray[1].frame.contains(location) {
							if item == 0 {
								addBall()
								item = -1
								gameArray[1].removeFromParent()
								addChild(gameArray[2])
							} else if item == 1 {
								energy = energy0
								item = -1
								gameArray[3].removeFromParent()
								addChild(gameArray[2])
							}
						}
					} else if location.x < midX*7/4 {
						padRevolve = !padRevolve;
					} else {
						if universalArray[3].frame.contains(location) && padRevolve {
							setupPauseMenu();
						}

					}
				}
			} else {
				if (universalArray[1].frame.contains(location)) {
					gameOver();
					setupMainMenu();
				} else if (universalArray[2].frame.contains(location)) {
					setupGameButtons();
				} else if (universalArray[3].frame.contains(location)) {
					gameOver();
					setupGameButtons();
					startGame();
				}

			}

		}
	}

	func response1(_ location: CGPoint) {
		if (userInGame && userPlaying && !padRevolve) {
			padRevolve = !padRevolve;
			gameArray[0].removeFromParent();
		}
	}

	func update() {
		if userInGame && userPlaying {
			if padRevolve {
				angle += 1.5
				if angle >= 360 {
					angle = 0
				}
				for i in 0..<paddleArray.count {
					paddleArray[i].position = CGPoint(x: (sin(CGFloat(GLKMathDegreesToRadians(Float(angle+CGFloat(i)*45))))*midX)+midX, y: (cos(CGFloat(GLKMathDegreesToRadians(Float(angle+CGFloat(i)*45))))*midX)+(screenHeight-midX));
					paddleArray[i].zRotation = CGFloat(-GLKMathDegreesToRadians(Float(angle+8+CGFloat(i)*45)));
				}
			} else {
				energy -= 1;

			}
			energyBar.removeFromParent();
			energyBar.fillColor = SKColor.white;
			addChild(energyBar);
			if (energy < 0) {
				energyLabel.removeFromParent();
				energyLabel.position = energyPosition;
				energyLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center;
				energyLabel.fontSize = 20;
				energyLabel.fontName = "AvenirNext-Regular";
				addChild(energyLabel);
				userGameOver = true;
				gameOver();
			}
		}
	}

	func addBall() {
		let ball = Ball(radius: ballRadius, position: center, speed: midX*CGFloat((ballSpeedFactor/10000)));
		ball.name = "ball_normal";
		addChild(ball);
		numBalls += 1;
	}

	func addTutorialBall() {
		let ball = Ball(radius: ballRadius, position: center, vector: ballVector);
		ball.name = "ball_normal";
		addChild(ball);
		numBalls += 1;
	}

	func screenFlash() {
		if (userPlaying && !userGameOver) {
			backgroundColor = SKColor(white: 0.05, alpha: 1)
		}
	}

	public func didBegin(_ contact: SKPhysicsContact) {
		var firstBody: SKPhysicsBody
		var secondBody: SKPhysicsBody
		if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
			firstBody = contact.bodyA
			secondBody = contact.bodyB
		} else {
			firstBody = contact.bodyB
			secondBody = contact.bodyA

		}
		if (firstBody.categoryBitMask&ballCategory) != 0 {
			if (secondBody.categoryBitMask&paddleCategory) != 0 && !padRevolve {
				let chance: UInt32 = arc4random_uniform(100)
				if firstBody.node!.name!.isEqual("ball_blink") {
					firstBody.node!.alpha = 0.4;
					let vectorTotal: CGFloat = abs((firstBody.node!.position.x)-secondBody.node!.position.x)+abs(firstBody.node!.position.y-secondBody.node!.position.y)
					let multi: CGFloat = (midX*(ballSpeedFactor/10000))/vectorTotal;
					firstBody.velocity = CGVector(dx: (firstBody.node!.position.x-secondBody.node!.position.x)*multi*3, dy: (firstBody.node!.position.y-secondBody.node!.position.y)*multi*3);
					firstBody.node?.name = "ball_speedshift"
				} else {
					if chance < 10 && (firstBody.node!.name!.isEqual("ball_normal")) {
						firstBody.node!.name = "ball_blink";
					} else {
						if firstBody.node!.name!.isEqual("ball_speedshift") && item == -1 {
							if chance > 50 {
								item = 0;
								addChild(gameArray[1]);
							} else {
								item = 1;
								addChild(gameArray[3]);

							}
							gameArray[2].removeFromParent();
						}
						firstBody.node?.alpha = 1.0;
						firstBody.node?.name = "ball_normal";

					}
					let vectorTotal: CGFloat = abs(firstBody.node!.position.x-secondBody.node!.position.x)+abs(firstBody.node!.position.y-secondBody.node!.position.y)
					let multi: CGFloat = (midX*(ballSpeedFactor/10000))/vectorTotal
					firstBody.velocity = CGVector(dx: (firstBody.node!.position.x-secondBody.node!.position.x)*multi, dy: (firstBody.node!.position.y-secondBody.node!.position.y)*multi)

				}
				ballSpeedFactor += 1;
				energy = energy+26-numContain-25;
				energy *= numContain+25*numBalls;
				if (energy > energy0) {
					energy = energy0;
				}
			} else if ((secondBody.categoryBitMask&boundCategory) != 0) {
				firstBody.node?.removeFromParent();
				numBalls -= 1;
				if (numBalls == numContain-1) {
					if (userTutorial) {
						playTime = 4;
					} else {
						userGameOver = true;
						gameOver();

					}
				} else {
					backgroundColor = SKColor(white: 0.2, alpha: 1);
					perform(Selector(("screenFlash")), with: nil, afterDelay: 0.1);
				}
			}
		}
	}
}
