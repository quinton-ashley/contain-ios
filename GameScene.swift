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
	var mainArray: Array<SKNode> = [];
	var selectArray: Array<SKNode> = [];
	var gameArray: Array<SKNode> = [];
	var pauseArray: Array<SKNode> = [];
	lazy var playTimer: Timer = {
		return Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timePassed), userInfo: nil, repeats: true);
	}();
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
  var title: SKSpriteNode = SKSpriteNode(imageNamed: "title");
  var box0: SKSpriteNode = SKSpriteNode(imageNamed: "box1");
  var box1: SKSpriteNode = SKSpriteNode(imageNamed: "box0");
  var box2: SKSpriteNode = SKSpriteNode(imageNamed: "box2");
  var box3: SKSpriteNode = SKSpriteNode(imageNamed: "box2");
  var box4: SKSpriteNode = SKSpriteNode(imageNamed: "box1");
  var menuLbl: SKSpriteNode = SKSpriteNode(imageNamed: "menu");
  var playLbl: SKSpriteNode = SKSpriteNode(imageNamed: "play");
  var resetLbl: SKSpriteNode = SKSpriteNode(imageNamed: "reset");
  var title_filled: SKSpriteNode = SKSpriteNode(imageNamed: "title-filled");
  var addBallLbl: SKSpriteNode = SKSpriteNode(imageNamed: "addBall");
  var itemSlotLbl: SKSpriteNode = SKSpriteNode(imageNamed: "itemSlot");
  var refillLbl: SKSpriteNode = SKSpriteNode(imageNamed: "refill");
  var pauseLbl: SKSpriteNode = SKSpriteNode(imageNamed: "pause");
  var scoreLbl: SKSpriteNode = SKSpriteNode(imageNamed: "score");
  var energyLbl: SKSpriteNode = SKSpriteNode(imageNamed: "energy");
  var creditsLbl: SKSpriteNode = SKSpriteNode(imageNamed: "credits");
  var playGameLbl: SKSpriteNode = SKSpriteNode(imageNamed: "playGame");
  var highScoreLbl: SKSpriteNode = SKSpriteNode(imageNamed: "highScore");
  var howToPlayLbl: SKSpriteNode = SKSpriteNode(imageNamed: "howToPlay");
  var selectDifficultyLbl: SKSpriteNode = SKSpriteNode(imageNamed: "selectDifficulty");
  var normalLbl: SKSpriteNode = SKSpriteNode(imageNamed: "normal");
  var hardLbl: SKSpriteNode = SKSpriteNode(imageNamed: "hard");
  var brutalLbl: SKSpriteNode = SKSpriteNode(imageNamed: "brutal");
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
		
		title.position = CGPoint(x: midX, y: screenHeight-midX);
		box0.position = CGPoint(x: midX, y: screenHeight-midX*2.1);
		box1.position = CGPoint(x: midX, y: screenHeight-midX*2.5);
		box2.position = CGPoint(x: midX, y: screenHeight-midX*2.9);
		box3.position = CGPoint(x: midX/6, y: screenHeight-midX*2.9);
		box4.position = CGPoint(x: midX*1.84, y: screenHeight-midX*2.9);
		playLbl.position = CGPoint(x: midX, y: screenHeight-midX*2.65);
		title_filled.position = CGPoint(x: midX, y: screenHeight-midX*2.65);
		addBallLbl.position = CGPoint(x: midX/6, y: screenHeight-midX*2.4);
		itemSlotLbl.position = CGPoint(x: midX/6, y: screenHeight-midX*2.4);
		refillLbl.position = CGPoint(x: midX/6, y: screenHeight-midX*2.4);
		menuLbl.position = CGPoint(x: midX/6, y: screenHeight-midX*2.4);
		pauseLbl.position = CGPoint(x: midX*1.84, y: screenHeight-midX*2.4);
		resetLbl.position = CGPoint(x: midX*1.84, y: screenHeight-midX*2.4);
		scoreLbl.position = CGPoint(x: midX/6, y: screenHeight-midX*2.76);
		energyLbl.position = CGPoint(x: midX*1.84, y: screenHeight-midX*2.85);
		creditsLbl.position = CGPoint(x: midX, y: screenHeight-midX*1.6);
		playGameLbl.position = CGPoint(x: midX, y: screenHeight-midX*2.1);
		highScoreLbl.position = CGPoint(x: midX, y: screenHeight-midX*2.5);
		howToPlayLbl.position = CGPoint(x: midX, y: screenHeight-midX*2.9);
		selectDifficultyLbl.position = CGPoint(x: midX, y: screenHeight-midX*1.6);
		normalLbl.position = CGPoint(x: midX/3, y: screenHeight-midX*2.2);
		hardLbl.position = CGPoint(x: midX, y: screenHeight-midX*2.2);
		brutalLbl.position = CGPoint(x: midX*5/3, y: screenHeight-midX*2.2);
		title.size = CGSize(width: midX*1.5, height: midX);
		box0.size = CGSize(width: midX, height: midX/3);
		box1.size = box0.size;
		box2.size = box0.size;
		box3.size = CGSize(width: midX/3, height: midX/2);
		box4.size = box3.size;
		playLbl.size = box3.size;
		title_filled.size = CGSize(width: midX, height: midX/2);
		addBallLbl.size = CGSize(width: midX/4, height: midX/3);
		refillLbl.size = addBallLbl.size;
		pauseLbl.size = addBallLbl.size;
		scoreLbl.size = addBallLbl.size;
		energyLbl.size = addBallLbl.size;
		menuLbl.size = addBallLbl.size;
		resetLbl.size = addBallLbl.size;
		itemSlotLbl.size = CGSize(width: midX/4.5, height: midX/3.5);
		scoreLbl.size = CGSize(width: midX/5, height: midX/9);
		creditsLbl.size = CGSize(width: midX, height: midX/4);
		playGameLbl.size = CGSize(width: midX*3/4, height: midX/3);
		highScoreLbl.size = CGSize(width: midX*4/5, height: midX/4);
		howToPlayLbl.size = CGSize(width: midX*3/4, height: midX/4);
		selectDifficultyLbl.size = CGSize(width: midX, height: midX/4);
		normalLbl.size = CGSize(width: midX/2.5, height: midX/4);
		hardLbl.size = CGSize(width: midX/3, height: midX/4.5);
		brutalLbl.size = CGSize(width: midX/2.5, height: midX/5);
		universalArray = [box0, box1, box2, box3, box4];
		mainArray = [creditsLbl, playGameLbl, highScoreLbl, howToPlayLbl];
		selectArray = [selectDifficultyLbl, normalLbl, hardLbl, brutalLbl];
		gameArray = [title_filled, addBallLbl, itemSlotLbl, refillLbl, pauseLbl, scoreLbl, energyLbl];
		pauseArray = [menuLbl,playLbl,resetLbl];

		userFromLoad = true;
		addChild(border1);
		addChild(border2);
		addChild(border3);
		addChild(border4);
		addChild(title);
		addChild(creditsLbl);
    Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(setupMainMenu), userInfo: nil, repeats: false);
	}

  @objc func setupMainMenu() {
		pauseGame = false;
		if (userFromLoad) {
			numContain = -1;
			addChild(title);
			for i in 1..<3 {
				addChild(universalArray[i]);
			}
			for i in 1..<mainArray.count {
				addChild(mainArray[i]);
			}
			userFromLoad = false;
		} else if (!userPlaying) {
			backgroundColor = SKColor(white: 0.05, alpha: 1);
			title.run(mainu0resize);
			box0.run(mainboxresize);
			box1.run(mainboxresize);
			box2.run(mainboxresize);
			box0.run(rotate90);
			box2.run(rotaten90);
			title.run(mainu0move);
			box0.run(mainu1move);
			box1.run(mainu2move);
			box2.run(mainu3move);
			box3.removeFromParent();
			box4.removeFromParent();
			menuLbl.removeFromParent();
			if (!userTutorial) {
				resetLbl.removeFromParent();
			}
			scoreLbl.removeFromParent();
			energyLbl.removeFromParent();
			scoreLabel.removeFromParent();
			energyLabel.removeFromParent();
			if (!userGameOver) {
				playLbl.removeFromParent()
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
		box0.run(pauseboxresize);
		box1.run(pauseboxresize);
		box2.run(pauseboxresize);
		box0.run(pauseu1move);
		box1.run(pauseu2move);
		box2.run(pauseu3move);
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
		title.run(gameu0resize);
		title.run(gameu2move);
		if (item == -1) {
			addChild(itemSlotLbl);
		} else if (item == 0) {
			addChild(addBallLbl);
		} else if (item == 1) {
			addChild(refillLbl);
		}
		addChild(pauseLbl);
		if (userSelectMenu) {
			box1.run(gameu2resize);
			box0.run(rotaten90);
			box2.run(rotate90);
			box0.run(gameu1move);
			box1.run(gameu2move);
			box2.run(gameu3move);
			addChild(box3);
			addChild(box4);
			addChild(scoreLbl);
			addChild(energyLbl);
			for i in 0..<selectArray.count {
				selectArray[i].removeFromParent();
			}
			userSelectMenu = false;
		} else if (userMainMenu) {
			box0.run(pauseboxresize);
			box1.run(gameu2resize);
			box2.run(pauseboxresize);
			box0.run(rotaten90);
			box2.run(rotate90);
			box0.run(gameu1move);
			box1.run(gameu2move);
			box2.run(gameu3move);
			addChild(box3);
			addChild(box4);
			addChild(scoreLbl);
			addChild(energyLbl);
			for i in 0..<mainArray.count {
				mainArray[i].removeFromParent();
			}
			userMainMenu = false;
		} else if (!userPlaying) {
			menuLbl.removeFromParent()
			resetLbl.removeFromParent()
		} else if (userGameOver) {
      playTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timePassed), userInfo: nil, repeats: true);
			backgroundColor = SKColor(white: 0.05, alpha: 1);
			userPlaying = true;
			pauseGame = false;
			playLbl.removeFromParent();
		}
	}

	func setupPauseMenu() {
		if (userInGame && userPlaying && !userTutorial) {
			backgroundColor = SKColor(white: 0.4, alpha: 1);
			userPlaying = false;
			pauseGame = true;
			title.position = CGPoint(x: midX, y: screenHeight-midX*4);
			for i in 0..<pauseArray.count {
				addChild(pauseArray[i]);
			}
			if (item == -1) {
				itemSlotLbl.removeFromParent();
			} else if (item == 0) {
				addBallLbl.removeFromParent();
			} else if (item == 1) {
				refillLbl.removeFromParent();
			}
			pauseLbl.removeFromParent();
			playTimer.invalidate();
		}
	}

	func applicationDidBecomeActive() {
		if (userInGame && !userPlaying && !userTutorial) {
			pauseGame = true;
		}
	}

	func applicationWillResignActive() {
		if (userTutorial) {
			gameOver();
			itemSlotLbl.removeFromParent();
			pauseLbl.removeFromParent();
			setupMainMenu();
		} else {
			setupPauseMenu();

		}
	}

	func gameOver() {
		if (!padRevolve) {
			title_filled.removeFromParent();
		}
		if (userGameOver) {
			title.run(overu0resize);
			title.run(pauseu0move);
			addChild(menuLbl);
			if (!userTutorial) {
				addChild(resetLbl);
			}
			addBallLbl.removeFromParent();
			itemSlotLbl.removeFromParent();
			refillLbl.removeFromParent();
			pauseLbl.removeFromParent();
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
    playTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timePassed), userInfo: nil, repeats: true);
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
		if (userTutorial) {
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

  @objc func timePassed() {
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

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch in touches {
			touchDown(touch.location(in: self));
		}
	}

	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch in touches {
			touchUp(touch.location(in: self));
		}
	}

//  override func mouseDown(with event: NSEvent) {
//    touchDown(atPoint: event.location(in: self));
//  }
//
//  override func mouseDragged(with event: NSEvent) {
//    touchMoved(toPoint: event.location(in: self));
//  }
//
//  override func mouseUp(with event: NSEvent) {
//    touchUp(atPoint: event.location(in: self));
//  }

  func touchDown(_ pos : CGPoint) {
		if (!userInGame) {
			if (userMainMenu) {
				if (box0.frame.contains(pos)) {
					userMainMenu = false
					setupSelectMenu()
				} else if (box1.frame.contains(pos)) {
					viewHighScores()
				} else if (box2.frame.contains(pos)) {
					setupHowToPlay()
				}
			} else if (userSelectMenu) {
				if (box0.frame.contains(pos)) {
					numContain = 1
				} else if (box1.frame.contains(pos)) {
					numContain = 2
				} else if (box2.frame.contains(pos)) {
					numContain = 3
				}
				if (numContain != 0) {
					setupGameButtons()
					startGame()
				}
			} else if (userGameOver) {
				if (box0.frame.contains(pos)) {
					setupMainMenu()
				} else if (box2.frame.contains(pos) && !userTutorial) {
					setupGameButtons()
					startGame()
				}
			}
		} else if (userPlaying) {
      if (box0.frame.contains(pos)) {
        if (item == 0) {
          addBall()
          item = -1
          addBallLbl.removeFromParent()
          addChild(itemSlotLbl)
        } else if (item == 1) {
          energy = energy0
          item = -1
          refillLbl.removeFromParent()
          addChild(itemSlotLbl)
        }
      } else if (box1.frame.contains(pos)) {
        print("pad");
        padRevolve = !padRevolve;
      } else if (box2.frame.contains(pos) && padRevolve) {
				setupPauseMenu();
      }
    } else if userGameOver {
      if (box0.frame.contains(pos)) {
        gameOver();
        setupMainMenu();
      } else if (box1.frame.contains(pos)) {
        setupGameButtons();
      } else if (box2.frame.contains(pos)) {
        gameOver();
        setupGameButtons();
        startGame();
      }
		}
	}

	func touchUp(_ pos: CGPoint) {
		if (userInGame && userPlaying && !padRevolve) {
			padRevolve = !padRevolve;
			title_filled.removeFromParent();
		}
	}

  override func update(_ currentTime: TimeInterval) {
		if (userInGame && userPlaying) {
			if (padRevolve) {
				angle += 1.5
				if (angle >= 360) {
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

  @objc func screenFlash() {
		if (userPlaying && !userGameOver) {
			backgroundColor = SKColor(white: 0.05, alpha: 1)
		}
	}

	public func didBegin(_ contact: SKPhysicsContact) {
		var firstBody: SKPhysicsBody
		var secondBody: SKPhysicsBody
		if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
			firstBody = contact.bodyA
			secondBody = contact.bodyB
		} else {
			firstBody = contact.bodyB
			secondBody = contact.bodyA

		}
		if ((firstBody.categoryBitMask&ballCategory) != 0) {
			if ((secondBody.categoryBitMask&paddleCategory) != 0 && !padRevolve) {
				let chance: UInt32 = arc4random_uniform(100)
				if firstBody.node!.name!.isEqual("ball_blink") {
					firstBody.node!.alpha = 0.4;
					let vectorTotal: CGFloat = abs((firstBody.node!.position.x) - secondBody.node!.position.x) + abs(firstBody.node!.position.y - secondBody.node!.position.y)
					let multi: CGFloat = (midX*(ballSpeedFactor/10000))/vectorTotal;
					firstBody.velocity = CGVector(dx: (firstBody.node!.position.x - secondBody.node!.position.x) * multi*3, dy: (firstBody.node!.position.y - secondBody.node!.position.y) * multi*3);
					firstBody.node?.name = "ball_speedshift"
				} else {
					if (chance < 10 && (firstBody.node!.name!.isEqual("ball_normal"))) {
						firstBody.node!.name = "ball_blink";
					} else {
						if (firstBody.node!.name!.isEqual("ball_speedshift") && item == -1) {
							if (chance > 50) {
								item = 0;
								addChild(addBallLbl);
							} else {
								item = 1;
								addChild(refillLbl);

							}
							itemSlotLbl.removeFromParent();
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
          perform(#selector(screenFlash), with: nil, afterDelay: 0.1);
				}
			}
		}
	}
}
