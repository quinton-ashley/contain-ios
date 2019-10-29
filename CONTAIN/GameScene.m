//
//  GameScene.m
//  CONTAIN
//
//  Created by Quinton Ashley on 12/18/14.
//  Copyright (c) 2014 Quinton Ashley. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene {
  //arrays of game elements
  NSMutableArray *paddleArray;
  NSMutableArray *universalArray;
  NSMutableArray *gameArray;
  NSMutableArray *mainArray;
  NSMutableArray *selectArray;
  
  //timer that runs while the user is in play state
  NSTimer *playTimer;
  
  //x and y values of the midpoint of the screen
  CGFloat midX;
  CGFloat midY;
  CGFloat screenWidth;
  CGFloat screenHeight;
  
  //center of screen
  CGPoint center;
  
  //number of each element
  int numPaddles;
  int numBalls;
  int numContain;
  
  //physics groups
  uint32_t ballCategory;
  uint32_t paddleCategory;
  uint32_t boundCategory;
  
  //radius of the ball
  CGFloat ballRadius;
  
  //the vector assigned to balls in tutorial mode
  CGVector ballVector;
  
  //the speed at which the paddles move
  double ballSpeedFactor;
  
  //standard radius value
  CGFloat padRadius0;
  
  //actual radius value of paddle
  CGFloat padRadius;
  
  //the desired radius size to change the paddle to
  //CGFloat padRadiusChange;
  
  //int padToChange;
  
  //the paddle's shape
  CGMutablePathRef padPath;
  
  //the angle of rotation of the circle of paddles
  double angle;
  
  /*item is set to: -1 when the player does not have an item
   0 when the player has an addBall item
   1 when the player has an energyRefill item
   */
  int item;
  
  //time values
  int ballTime;
  int playTime;
  
  //boolean for whether the pads are revolving
  bool padRevolve;
  
  //game states the user can be in
  bool userFromLoad;
  bool userInGame;
  bool userPlaying;
  bool userMainMenu;
  bool userSelectMenu;
  bool userGameOver;
  bool userTutorial;
  
  //boolean for if the paddles radi must be changed
  //bool changePadRadius;
  
  double transitionTime;
  
  //constant for the value of the players energy at 100%
  int energy0;
  //the players actual energy in game
  int energy;
  //the energy bar's y value
  int eBarY;
  //the energy bar's height value
  int eBarHeight;
  
  //the visual representation of a player's energy
  SKShapeNode *energyBar;
  //numerical representation of the player's score
  SKLabelNode *scoreLabel;
  //numerical representation of the player's energy
  SKLabelNode *energyLabel;
  //the posistion of the scoreLabel
  CGPoint scorePosition;
  //the position of the energyLabel
  CGPoint energyPosition;
  
  //various actions the UI elements of the game can perform
  SKAction *rotaten90;
  SKAction *rotate90;
  
  SKAction *gameu0resize;
  SKAction *gameu2resize;
  SKAction *gameu1move;
  SKAction *gameu2move;
  SKAction *gameu3move;
  
  SKAction *overu0resize;
  
  SKAction *pauseboxresize;
  SKAction *pauseu0move;
  SKAction *pauseu1move;
  SKAction *pauseu2move;
  SKAction *pauseu3move;
  
  SKAction *mainu0resize;
  SKAction *mainboxresize;
  SKAction *mainu0move;
  SKAction *mainu1move;
  SKAction *mainu2move;
  SKAction *mainu3move;
  
#if TARGET_OS_IPHONE
  NSNotification *didBecomeActiveNotification;
  NSNotification *willResignActiveNotification;
#endif
}

- (void)didMoveToView:(SKView *)view {
  userInGame = userPlaying = userGameOver = userSelectMenu = userTutorial = false;
  self.backgroundColor = [SKColor colorWithWhite:0.05 alpha:1];
  self.physicsWorld.gravity = CGVectorMake(0.0f, 0.0f);
  self.physicsWorld.contactDelegate = self;
  ballCategory    =  0x1 << 0;
  paddleCategory  =  0x1 << 1;
  boundCategory   =  0x1 << 2;
  if (self.size.width < 600) {
    screenWidth = self.size.width;
    screenHeight = self.size.height;
  } else {
    screenWidth = self.size.width/1.24;
    screenHeight = self.size.height;
  }
  midX = screenWidth/2;
  midY = screenHeight/2;
  center = CGPointMake(midX, screenHeight-midX);
  ballRadius = 100;
  padRadius0 = padRadius = midX/9.1;
  transitionTime = 0.2;
  energy0 = 400;
  eBarHeight = midX/150;
  eBarY = screenHeight-midX*2.1;
  item = -1;
  
  SKShapeNode *border1 = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(screenWidth+40, 10)];
  border1.fillColor = [SKColor clearColor];
  border1.strokeColor = [SKColor clearColor];
  border1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(screenWidth+40, 10)];
  border1.position = CGPointMake(midX, screenHeight+15);
  border1.physicsBody.dynamic = NO;
  border1.physicsBody.categoryBitMask = boundCategory;
  border1.physicsBody.collisionBitMask = 0x1 << 10;
  border1.physicsBody.contactTestBitMask = ballCategory;
  
  SKShapeNode *border2 = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(10, screenWidth+40)];
  border2.fillColor = [SKColor clearColor];
  border2.strokeColor = [SKColor clearColor];
  border2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(10, screenWidth+40)];
  border2.position = CGPointMake(-15, screenHeight-midX);
  border2.physicsBody.dynamic = NO;
  border2.physicsBody.categoryBitMask = boundCategory;
  border2.physicsBody.collisionBitMask = 0x1 << 10;
  border2.physicsBody.contactTestBitMask = ballCategory;
  
  SKShapeNode *border3 = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(10, screenWidth+40)];
  border3.fillColor = [SKColor clearColor];
  border3.strokeColor = [SKColor clearColor];
  border3.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(10, screenWidth+40)];
  border3.position = CGPointMake(screenWidth+15, screenHeight-midX);
  border3.physicsBody.dynamic = NO;
  border3.physicsBody.categoryBitMask = boundCategory;
  border3.physicsBody.collisionBitMask = 0x1 << 10;
  border3.physicsBody.contactTestBitMask = ballCategory;
  
  SKShapeNode *border4 = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(screenWidth+40, 10)];
  border4.fillColor = [SKColor clearColor];
  border4.strokeColor = [SKColor clearColor];
  border4.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(screenWidth+40, 10)];
  border4.position = CGPointMake(midX, screenHeight-screenWidth-15);
  border4.physicsBody.dynamic = NO;
  border4.physicsBody.categoryBitMask = boundCategory;
  border4.physicsBody.collisionBitMask = 0x1 << 10;
  border4.physicsBody.contactTestBitMask = ballCategory;
  
  SKSpriteNode *u0 = [SKSpriteNode spriteNodeWithImageNamed:@"Contain-title"];
  SKSpriteNode *u1 = [SKSpriteNode spriteNodeWithImageNamed:@"Contain-box1"];
  SKSpriteNode *u2 = [SKSpriteNode spriteNodeWithImageNamed:@"Contain-box"];
  SKSpriteNode *u3 = [SKSpriteNode spriteNodeWithImageNamed:@"Contain-box2"];
  SKSpriteNode *u4 = [SKSpriteNode spriteNodeWithImageNamed:@"Contain-box2"];
  SKSpriteNode *u5 = [SKSpriteNode spriteNodeWithImageNamed:@"Contain-box1"];
  SKSpriteNode *u6 = [SKSpriteNode spriteNodeWithImageNamed:@"Contain-returntomenu"];
  SKSpriteNode *u7 = [SKSpriteNode spriteNodeWithImageNamed:@"Contain-unpause"];
  SKSpriteNode *u8 = [SKSpriteNode spriteNodeWithImageNamed:@"Contain-reset"];
  
  SKSpriteNode *g0 = [SKSpriteNode spriteNodeWithImageNamed:@"Contain-titlefilled"];
  SKSpriteNode *g1 = [SKSpriteNode spriteNodeWithImageNamed:@"Contain-addball"];
  SKSpriteNode *g2 = [SKSpriteNode spriteNodeWithImageNamed:@"Contain-itemplaceholder"];
  SKSpriteNode *g3 = [SKSpriteNode spriteNodeWithImageNamed:@"Contain-refill"];
  SKSpriteNode *g4 = [SKSpriteNode spriteNodeWithImageNamed:@"Contain-pause"];
  SKSpriteNode *g5 = [SKSpriteNode spriteNodeWithImageNamed:@"Contain-score"];
  SKSpriteNode *g6 = [SKSpriteNode spriteNodeWithImageNamed:@"Contain-energy"];
  
  
  SKSpriteNode *m0 = [SKSpriteNode spriteNodeWithImageNamed:@"Contain-credits"];
  SKSpriteNode *m1 = [SKSpriteNode spriteNodeWithImageNamed:@"Contain-playlabel"];
  SKSpriteNode *m2 = [SKSpriteNode spriteNodeWithImageNamed:@"Contain-highscorelabel"];
  SKSpriteNode *m3 = [SKSpriteNode spriteNodeWithImageNamed:@"Contain-howtolabel"];
  
  SKSpriteNode *s0 = [SKSpriteNode spriteNodeWithImageNamed:@"Contain-selectdifficulty"];
  SKSpriteNode *s1 = [SKSpriteNode spriteNodeWithImageNamed:@"Contain-normallabel"];
  SKSpriteNode *s2 = [SKSpriteNode spriteNodeWithImageNamed:@"Contain-hardlabel"];
  SKSpriteNode *s3 = [SKSpriteNode spriteNodeWithImageNamed:@"Contain-brutallabel"];
  
  u0.position = CGPointMake(midX, screenHeight-midX);
  u1.position = CGPointMake(midX, screenHeight-midX*2.1);
  u2.position = CGPointMake(midX, screenHeight-midX*2.5);
  u3.position = CGPointMake(midX, screenHeight-midX*2.9);
  u4.position = CGPointMake(midX/6, screenHeight-midX*2.9);
  u5.position = CGPointMake(midX*1.84, screenHeight-midX*2.9);
  u7.position = CGPointMake(midX, screenHeight-midX*2.65);
  
  g0.position = CGPointMake(midX, screenHeight-midX*2.65);
  g1.position = g2.position = g3.position =  u6.position = CGPointMake(midX/6, screenHeight-midX*2.4);
  g4.position = u8.position = CGPointMake(midX*1.84, screenHeight-midX*2.4);
  g5.position = CGPointMake(midX/6, screenHeight-midX*2.76);
  g6.position = CGPointMake(midX*1.84, screenHeight-midX*2.85);
  
  m0.position = CGPointMake(midX, screenHeight-midX*1.6);
  m1.position = CGPointMake(midX, screenHeight-midX*2.1);
  m2.position = CGPointMake(midX, screenHeight-midX*2.5);
  m3.position = CGPointMake(midX, screenHeight-midX*2.9);
  
  s0.position = CGPointMake(midX, screenHeight-midX*1.6);
  s1.position = CGPointMake(midX/3, screenHeight-midX*2.2);
  s2.position = CGPointMake(midX, screenHeight-midX*2.2);
  s3.position = CGPointMake(midX*5/3, screenHeight-midX*2.2);
  
  u0.size = CGSizeMake(midX*1.5, midX);
  u1.size = u2.size = u3.size = CGSizeMake(midX, midX/3);
  u4.size = u5.size = u7.size = CGSizeMake(midX/3, midX/2);
  
  g0.size = CGSizeMake(midX, midX/2);
  g1.size = g3.size = g4.size = g5.size = g6.size = u6.size = u8.size = CGSizeMake(midX/4, midX/3);
  g2.size = CGSizeMake(midX/4.5, midX/3.5);
  g5.size = CGSizeMake(midX/5, midX/9);
  
  m0.size = CGSizeMake(midX, midX/4);
  m1.size = CGSizeMake(midX*3/4, midX/3);
  m2.size = CGSizeMake(midX*4/5, midX/4);
  m3.size = CGSizeMake(midX*3/4, midX/4);
  
  s0.size = CGSizeMake(midX, midX/4);
  s1.size = CGSizeMake(midX/2.5, midX/4);
  s2.size = CGSizeMake(midX/3, midX/4.5);
  s3.size = CGSizeMake(midX/2.5, midX/5);
  
  universalArray = [[NSMutableArray alloc] initWithObjects:u0, u1, u2, u3, u4, u5, u6, u7, u8, nil];
  gameArray = [[NSMutableArray alloc] initWithObjects:g0, g1, g2, g3, g4, g5, g6, nil];
  mainArray = [[NSMutableArray alloc] initWithObjects:m0, m1, m2, m3, nil];
  selectArray = [[NSMutableArray alloc] initWithObjects:s0, s1, s2, s3, nil];
  
  paddleArray = [[NSMutableArray alloc] init];
  
  rotaten90 = [SKAction rotateByAngle:-M_PI_2 duration:transitionTime];
  rotate90 = [SKAction rotateByAngle:M_PI_2 duration:transitionTime];
  
  gameu0resize = [SKAction resizeToWidth:midX height:midX/2 duration:transitionTime];
  gameu2resize = [SKAction resizeToWidth:midX*1.4 height:midX*1.1 duration:transitionTime];
  gameu1move = [SKAction moveTo:CGPointMake(midX/6, screenHeight-midX*2.4) duration:transitionTime];
  gameu2move = [SKAction moveTo:CGPointMake(midX, screenHeight-midX*2.65) duration:transitionTime];
  gameu3move = [SKAction moveTo:CGPointMake(midX*1.84, screenHeight-midX*2.4) duration:transitionTime];
  
  overu0resize = [SKAction resizeToWidth:midX/3 height:midX/6 duration:transitionTime];
  
  pauseboxresize = [SKAction resizeToWidth:midX/2 height:midX/3 duration:transitionTime];
  pauseu0move = [SKAction moveTo:CGPointMake(midX, screenHeight-midX*4) duration:transitionTime];
  pauseu1move = [SKAction moveTo:CGPointMake(midX/3, screenHeight-midX*2.2) duration:transitionTime];
  pauseu2move = [SKAction moveTo:CGPointMake(midX, screenHeight-midX*2.2) duration:transitionTime];
  pauseu3move = [SKAction moveTo:CGPointMake(midX*5/3, screenHeight-midX*2.2) duration:transitionTime];
  
  mainu0resize = [SKAction resizeToWidth:midX*1.5 height:midX duration:transitionTime];
  mainboxresize = [SKAction resizeToWidth:midX height:midX/3 duration:transitionTime];
  
  mainu0move = [SKAction moveTo:CGPointMake(midX, screenHeight-midX) duration:transitionTime];
  mainu1move = [SKAction moveTo:CGPointMake(midX, screenHeight-midX*2.1) duration:transitionTime];
  mainu2move = [SKAction moveTo:CGPointMake(midX, screenHeight-midX*2.5) duration:transitionTime];
  mainu3move = [SKAction moveTo:CGPointMake(midX, screenHeight-midX*2.9) duration:transitionTime];
  
  scorePosition = CGPointMake(midX/6, screenHeight-midX*3);
  energyPosition = CGPointMake(midX*1.82, screenHeight-midX*3);
  
#if TARGET_OS_IPHONE
  
  if (didBecomeActiveNotification == nil) {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidBecomeActive)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:didBecomeActiveNotification];
  }
  if (willResignActiveNotification == nil) {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillResignActive)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:willResignActiveNotification];
  }
  
#endif
  
  userFromLoad = true;
  
  [self addChild:border1];
  [self addChild:border2];
  [self addChild:border3];
  [self addChild:border4];
  [self addChild:universalArray[0]];
  [self addChild:mainArray[0]];
  
  [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(setupMainMenu) userInfo:nil repeats:NO];
}

- (void)setupMainMenu { //this menu can be accessed from the load screen, pause menu, game over menu, how to menu, and the high score list
  _pauseGame = false;
  if (userFromLoad) {
    //omits the 0 object in each array on purpose because they are already display on the load screen
    numContain = -1;
    for (int i=1; i<4; i++) {
      [self addChild:universalArray[i]];
    }
    for (int i=1; i<mainArray.count; i++) {
      [self addChild:mainArray[i]];
    }
    userFromLoad = false;
  } else if (!userPlaying) {
    self.backgroundColor = [SKColor colorWithWhite:0.05 alpha:1];
    [universalArray[0] runAction:mainu0resize];
    [universalArray[1] runAction:mainboxresize];
    [universalArray[2] runAction:mainboxresize];
    [universalArray[3] runAction:mainboxresize];
    [universalArray[1] runAction:rotate90];
    [universalArray[3] runAction:rotaten90];
    [universalArray[0] runAction:mainu0move];
    [universalArray[1] runAction:mainu1move];
    [universalArray[2] runAction:mainu2move];
    [universalArray[3] runAction:mainu3move];
    [universalArray[4] removeFromParent];
    [universalArray[5] removeFromParent];
    [universalArray[6] removeFromParent];
    if (!userTutorial) {
      [universalArray[8] removeFromParent];
    }
    [gameArray[5] removeFromParent];
    [gameArray[6] removeFromParent];
    if (scoreLabel != nil) {
      [scoreLabel removeFromParent];
    }
    if (energyLabel != nil) {
      [energyLabel removeFromParent];
    }
    //if the user is coming from the pause menu then remove pause menu specific graphics
    if (!userGameOver) {
      [universalArray[7] removeFromParent];
    }
    for (int i=0; i<mainArray.count; i++) {
      [self addChild:mainArray[i]];
    }
    userTutorial = false;
    userInGame = false;
  }
  userMainMenu = true;
}

- (void)setupSelectMenu { //this menu can only be acessed through the main menu
  _pauseGame = false;
  for (int i=0; i<mainArray.count; i++) {
    [mainArray[i] removeFromParent];
  }
  [universalArray[1] runAction:pauseboxresize];
  [universalArray[2] runAction:pauseboxresize];
  [universalArray[3] runAction:pauseboxresize];
  [universalArray[1] runAction:pauseu1move];
  [universalArray[2] runAction:pauseu2move];
  [universalArray[3] runAction:pauseu3move];
  for (int i=0; i<selectArray.count; i++) {
    [self addChild:selectArray[i]];
  }
  userSelectMenu = true;
}

- (void)viewHighScores {
  _pauseGame = false;
//#if TARGET_OS_IPHONE
//  [[NSNotificationCenter defaultCenter] postNotificationName:PresentGameCenterViewController object:self userInfo:nil];
//#endif
}

- (void)setupHowToPlay {
  userTutorial = true;
  numContain = 1;
  [self setupGameButtons];
  [self startGame];
}

- (void)setupGameButtons { //the game buttons user interface can be set up through the pause menu, game over menu, and select difficulty menu, or main menu via the tutorial
  [universalArray[0] runAction:gameu0resize];
  [universalArray[0] runAction:gameu2move];
  if (item == -1) {
    [self addChild:gameArray[2]];
  } else if (item == 0) {
    [self addChild:gameArray[1]];
  } else if (item == 1) {
    [self addChild:gameArray[3]];
  }
  [self addChild:gameArray[4]];
  if (userSelectMenu) {
    [universalArray[2] runAction:gameu2resize];
    [universalArray[1] runAction:rotaten90];
    [universalArray[3] runAction:rotate90];
    [universalArray[1] runAction:gameu1move];
    [universalArray[2] runAction:gameu2move];
    [universalArray[3] runAction:gameu3move];
    [self addChild:universalArray[4]];
    [self addChild:universalArray[5]];
    [self addChild:gameArray[5]];
    [self addChild:gameArray[6]];
    for (int i=0; i<selectArray.count; i++) {
      [selectArray[i] removeFromParent];
    }
    userSelectMenu = false;
  } else if (userMainMenu) {
    [universalArray[1] runAction:pauseboxresize];
    [universalArray[2] runAction:gameu2resize];
    [universalArray[3] runAction:pauseboxresize];
    [universalArray[1] runAction:rotaten90];
    [universalArray[3] runAction:rotate90];
    [universalArray[1] runAction:gameu1move];
    [universalArray[2] runAction:gameu2move];
    [universalArray[3] runAction:gameu3move];
    [self addChild:universalArray[4]];
    [self addChild:universalArray[5]];
    [self addChild:gameArray[5]];
    [self addChild:gameArray[6]];
    for (int i=0; i<mainArray.count; i++) {
      [mainArray[i] removeFromParent];
    }
    userMainMenu = false;
  } else if (!userPlaying) {
    [universalArray[6] removeFromParent];
    [universalArray[8] removeFromParent];
    //delete item pictures
    if (userGameOver) {
      //remove end game stats
    } else {
      playTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timePassed) userInfo:nil repeats:YES];
      self.backgroundColor = [SKColor colorWithWhite:0.05 alpha:1];
      userPlaying = true;
      _pauseGame = false;
      [universalArray[7] removeFromParent];
    }
  }
}

- (void)setupPauseMenu {
  if (userInGame && userPlaying && !userTutorial) {
    self.backgroundColor = [SKColor colorWithWhite:0.4 alpha:1];
    userPlaying = false;
    _pauseGame = true;
    [(CALayer *)universalArray[0] setPosition:CGPointMake(midX, screenHeight-midX*4)];
    [self addChild:universalArray[6]];
    [self addChild:universalArray[7]];
    [self addChild:universalArray[8]];
    if (item == -1) {
      [gameArray[2] removeFromParent];
    } else if (item == 0) {
      [gameArray[1] removeFromParent];
    } else if (item == 1) {
      [gameArray[3] removeFromParent];
    }
    
    [gameArray[4] removeFromParent];
    [playTimer invalidate];
    playTimer = nil;
  }
}

- (void)applicationDidBecomeActive {
  if (userInGame && !userPlaying && !userTutorial) {
    _pauseGame = true;
  }
}

- (void)applicationWillResignActive {
  if (userTutorial) {
    [self gameOver];
    [gameArray[2] removeFromParent];
    [gameArray[4] removeFromParent];
    [self setupMainMenu];
  } else {
    [self setupPauseMenu];
  }
}

- (void)gameOver {
  if (!padRevolve) {
    [gameArray[0] removeFromParent];
  }
  if (userGameOver) {
    [universalArray[0] runAction:overu0resize];
    [universalArray[0] runAction:pauseu0move];
    [self addChild:universalArray[6]];
    if (!userTutorial) {
      [self addChild:universalArray[8]];
    }
    [gameArray[1] removeFromParent];
    [gameArray[2] removeFromParent];
    [gameArray[3] removeFromParent];
    [gameArray[4] removeFromParent];
  } else {
    _pauseGame = false;
  }
  [self enumerateChildNodesWithName:@"ball_normal" usingBlock:^(SKNode *node, BOOL *stop) {
    [node removeFromParent];
  }];
  [self enumerateChildNodesWithName:@"ball_blink" usingBlock:^(SKNode *node, BOOL *stop) {
    [node removeFromParent];
  }];
  [self enumerateChildNodesWithName:@"ball_speedshift" usingBlock:^(SKNode *node, BOOL *stop) {
    [node removeFromParent];
  }];
  for (int i=0; i<numPaddles; i++) {
    [paddleArray[i] removeFromParent];
  }
  [energyBar removeFromParent];
  [playTimer invalidate];
  playTimer = nil;
//#if TARGET_OS_IPHONE
//  if (!userTutorial) {
//    if (numContain == 1) {
//      [self reportScore:@"contain.score.leaderboard"];
//    } else if (numContain == 2) {
//      [self reportScore:@"contain.score.leaderboard2"];
//    } else if (numContain == 3) {
//      [self reportScore:@"contain.score.leaderboard3"];
//    }
//  }
//#endif
  userPlaying = userInGame = false;
}
//#if TARGET_OS_IPHONE
//- (void)reportScore:(NSString *)leaderboardID {
//  if ([GKLocalPlayer localPlayer].isAuthenticated) {
//    GKScore *score = [[GKScore alloc] initWithLeaderboardIdentifier:leaderboardID player:[GKLocalPlayer localPlayer]];
//    score.value = playTime*5;
//    [GKScore reportScores:@[score] withCompletionHandler:^(NSError *error) {
//      if (error != nil) {
//        NSLog(@"%@", [error localizedDescription]);
//      }
//    }];
//  }
//}
//#endif

- (void)startGame {
  if (playTimer != nil) {
    [playTimer invalidate];
    playTimer = nil;
  }
  playTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timePassed) userInfo:nil repeats:YES];
  self.backgroundColor = [SKColor colorWithWhite:0.05 alpha:1];
  numBalls = angle = playTime = 0;
  item = -1;
  numPaddles = 8;
  ballSpeedFactor = 1100;
  energy = energy0;
  energyBar = [SKShapeNode shapeNodeWithRect:CGRectMake(0, eBarY, midX*2, eBarHeight)];
  energyBar.fillColor = [SKColor whiteColor];
  [self addChild:energyBar];
  if (scoreLabel != nil) {
    [scoreLabel removeFromParent];
  }
  if (energyLabel != nil) {
    [energyLabel removeFromParent];
  }
  scoreLabel = [SKLabelNode labelNodeWithText:[@(playTime*10000) stringValue]];
  scoreLabel.position = scorePosition;
  scoreLabel.verticalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
  scoreLabel.fontSize = 20;
  scoreLabel.fontName = @"AvenirNext-Regular";
  [self addChild:scoreLabel];
  energyLabel = [SKLabelNode labelNodeWithText:[@((int) energy/4) stringValue]];
  energyLabel.position = energyPosition;
  energyLabel.verticalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
  energyLabel.fontSize = 20;
  energyLabel.fontName = @"AvenirNext-Regular";
  [self addChild:energyLabel];
  if (userTutorial) {
    ballTime = -1;
  } else {
    ballTime = 2;
    [self addBall];
    if (numContain > 1) {
      [self addBall];
    }
  }
  padRadius = padRadius0;
  padPath = CGPathCreateMutable();
  CGPathAddArc(padPath, NULL, 0,0, padRadius, GLKMathDegreesToRadians(348), GLKMathDegreesToRadians(208), YES);
  CGPathAddArc(padPath, NULL, 0,0, padRadius-padRadius/8, GLKMathDegreesToRadians(555), GLKMathDegreesToRadians(0), YES);
  for (int i=0; i<numPaddles; i++) {
    paddleArray[i] = [Paddle newPaddleWithPath:padPath withRadius:padRadius];
//    [paddleArray[i] setFillColor:[SKColor colorWithWhite:0.4 alpha:1].CGColor];
    [self addChild:paddleArray[i]];
  }
  //padRadiusChange = padRadius0;
  //changePadRadius =
  userGameOver = false;
  userInGame = userPlaying = padRevolve = true;
}

- (void)timePassed {
  if (userPlaying) {
    playTime++;
    [scoreLabel removeFromParent];
    scoreLabel = [SKLabelNode labelNodeWithText:[@(playTime*5) stringValue]];
    scoreLabel.position = scorePosition;
    scoreLabel.verticalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    scoreLabel.fontSize = 20;
    scoreLabel.fontName = @"AvenirNext-Regular";
    [self addChild:scoreLabel];
    [energyLabel removeFromParent];
    energyLabel = [SKLabelNode labelNodeWithText:[@((int) energy/4) stringValue]];
    energyLabel.position = energyPosition;
    energyLabel.verticalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    energyLabel.fontSize = 20;
    energyLabel.fontName = @"AvenirNext-Regular";
    [self addChild:energyLabel];
    if (playTime == ballTime) {
      [self addBall];
      ballTime = playTime+40+(numContain*5);
    }
    [self enumerateChildNodesWithName:@"ball_blink" usingBlock:^(SKNode *node, BOOL *stop) {
      if (node.alpha == 1.0) {
        [node setAlpha:0.4];
      } else {
        [node setAlpha:1.0];
      }
    }];
    if (userTutorial) {
      if (playTime == 5) {
        ballVector = CGVectorMake(0, -midX*(ballSpeedFactor/10000));
        [self addTutorialBall];
      } else if (playTime == 4) {
        userGameOver = true;
        [self gameOver];
      }
    }
  }
}

#if TARGET_OS_IPHONE

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  for (UITouch *touch in touches) {
    [self response0:[touch locationInNode:self]];
  }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  for (UITouch *touch in touches) {
    [self response1:[touch locationInNode:self]];
  }
}

#else

- (void)mouseDown:(NSEvent *)event {
  CGPoint location = [self.view convertPoint:[event locationInWindow] fromView:nil];
  NSLog(@"%f, %f", location.x, location.y);
  [self response0:location];
}

- (void)mouseUp:(NSEvent *)event {
  CGPoint location = [self.view convertPoint:[event locationInWindow] fromView:nil];
  NSLog(@"%f, %f", location.x, location.y);
  [self response1:location];
}

#endif

- (void)response0:(CGPoint)location {
  if (!userInGame) {
    if (userMainMenu) {
      if (CGRectContainsPoint([universalArray[1] frame], location)) {
        userMainMenu = false;
        [self setupSelectMenu];
      } else if (CGRectContainsPoint([universalArray[2] frame], location)) {
        [self viewHighScores];
      } else if (CGRectContainsPoint([universalArray[3] frame], location)) {
        [self setupHowToPlay];
      }
    } else if (userSelectMenu) {
      if (CGRectContainsPoint([universalArray[1] frame], location)) {
        numContain = 1;
      } else if (CGRectContainsPoint([universalArray[2] frame], location)) {
        numContain = 2;
      } else if (CGRectContainsPoint([universalArray[3] frame], location)) {
        numContain = 3;
      }
      if (numContain != 0) {
        [self setupGameButtons];
        [self startGame];
      }
    } else if (userGameOver) {
      if (CGRectContainsPoint([universalArray[1] frame], location)) {
        [self setupMainMenu];
      } else if (CGRectContainsPoint([universalArray[3] frame], location) && !userTutorial) {
        [self setupGameButtons];
        [self startGame];
      }
    }
  } else {
    if (userPlaying) {
      if (location.y < midY) {
        if (location.x < midX/4) {
          if (CGRectContainsPoint([universalArray[1] frame], location)) {
            if (item == 0) {
              [self addBall];
              item = -1;
              [gameArray[1] removeFromParent];
              [self addChild:gameArray[2]];
            } else if (item == 1) {
              energy = energy0;
              item = -1;
              [gameArray[3] removeFromParent];
              [self addChild:gameArray[2]];
            }
          }
        } else if (location.x < midX*7/4) {
          padRevolve = !padRevolve;
          for (int i=0; i<numPaddles; i++) {
//            [paddleArray[i] setFillColor:[SKColor whiteColor].CGColor];
          }
//          [self addChild:gameArray[0]];
        } else {
          if (CGRectContainsPoint([universalArray[3] frame], location) && padRevolve) {
            [self setupPauseMenu];
          }
        }
      }
    } else {
      if (CGRectContainsPoint([universalArray[1] frame], location)) {
        [self gameOver];
        [self setupMainMenu];
      } else if (CGRectContainsPoint([universalArray[2] frame], location)) {
        [self setupGameButtons];
      } else if (CGRectContainsPoint([universalArray[3] frame], location)) {
        [self gameOver];
        [self setupGameButtons];
        [self startGame];
      }
    }
  }
}

-(void)response1:(CGPoint)location {
  if (userInGame && userPlaying && !padRevolve) {
    padRevolve = !padRevolve;
    for (int i=0; i<numPaddles; i++) {
      //      [paddleArray[i] setFillColor:[SKColor colorWithWhite:0.4 alpha:1].CGColor];
    }
    [gameArray[0] removeFromParent];
  }
}

- (void)update:(CFTimeInterval)currentTime {
  /* Called before each frame is rendered */
  if (userInGame && userPlaying) {
    if (padRevolve) {
      //            if (changePadRadius) {
      //                [self changePadsSize];
      //            }
      angle+=1.5;
      if (angle >= 360) {
        angle = 0;
      }
      for (int i=0; i<numPaddles; i++) {
        [(CALayer *)paddleArray[i] setPosition:CGPointMake((sin(GLKMathDegreesToRadians(angle+i*45))*midX)+midX, (cos(GLKMathDegreesToRadians(angle+i*45))*midX)+(screenHeight-midX))];
        [paddleArray[i] setZRotation:-GLKMathDegreesToRadians(angle+8+i*45)];
      }
    } else {
      energy--;
    }
    [energyBar removeFromParent];
    energyBar = [SKShapeNode shapeNodeWithRect:CGRectMake(0, eBarY, midX*2*energy/energy0, eBarHeight)];
    energyBar.fillColor = [SKColor whiteColor];
    [self addChild:energyBar];
    if (energy < 0) {
      [energyLabel removeFromParent];
      energyLabel = [SKLabelNode labelNodeWithText:[@((int) energy/4) stringValue]];
      energyLabel.position = energyPosition;
      energyLabel.verticalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
      energyLabel.fontSize = 20;
      energyLabel.fontName = @"AvenirNext-Regular";
      [self addChild:energyLabel];
      userGameOver = true;
      [self gameOver];
    }
  }
}

- (void)addBall {
  Ball *ball = [Ball newBallWithRadius:ballRadius position:center speed:(midX*(ballSpeedFactor/10000))];
  ball.name = @"ball_normal";
  [self addChild:ball];
  numBalls++;
}

- (void)addTutorialBall {
  Ball *ball = [Ball newBallWithRadius:ballRadius position:center vector:ballVector];
  ball.name = @"ball_normal";
  [self addChild:ball];
  numBalls++;
}

//-(void)changePadsSize {
//    if ((padRadius < padRadiusChange && padRadius > padRadiusChange-5) || (padRadius > padRadiusChange && padRadius < padRadiusChange+5)) {
//        changePadRadius = false;
//    }
//    if (padRadius < padRadiusChange+5) {
//        padRadius++;
//    } else {
//        padRadius--;
//    }
//    padPath = CGPathCreateMutable();
//    CGPathAddArc(padPath, NULL, 0,0, padRadius, GLKMathDegreesToRadians(348), GLKMathDegreesToRadians(208), YES);
//    CGPathAddArc(padPath, NULL, 0,0, padRadius-padRadius/8, GLKMathDegreesToRadians(555), GLKMathDegreesToRadians(0), YES);
//    for (int i=0; i<numPaddles; i++) {
//        [paddleArray[i] removeFromParent];
//        paddleArray[i] = [Paddle newPaddleWithPath:padPath withRadius:padRadius];
//        [paddleArray[i] setFillColor:(__bridge CGColorRef)([SKColor colorWithWhite:0.4 alpha:1])];
//        [self addChild:paddleArray[i]];
//    }
//}

-(void)screenFlash {
  if (userPlaying && !userGameOver) {
    self.backgroundColor = [SKColor colorWithWhite:0.05 alpha:1];
  }
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
  SKPhysicsBody *firstBody, *secondBody;
  if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
    firstBody = contact.bodyA;
    secondBody = contact.bodyB;
  } else {
    firstBody = contact.bodyB;
    secondBody = contact.bodyA;
  }
  if ((firstBody.categoryBitMask & ballCategory) != 0) {
    if ((secondBody.categoryBitMask & paddleCategory) != 0 && !padRevolve) {
      int chance = arc4random_uniform(100);
      if ([[firstBody.node name] isEqualToString:@"ball_blink"]) {
        [firstBody.node setAlpha:0.4];
        double vectorTotal = fabs(firstBody.node.position.x - secondBody.node.position.x) + fabs(firstBody.node.position.y - secondBody.node.position.y);
        double multi = (midX*(ballSpeedFactor/10000))/vectorTotal;
        firstBody.velocity = CGVectorMake((firstBody.node.position.x - secondBody.node.position.x)*multi*3, (firstBody.node.position.y - secondBody.node.position.y)*multi*3);
        firstBody.node.name = @"ball_speedshift";
      } else {
        if (chance < 10 && [[firstBody.node name] isEqualToString:@"ball_normal"]) {
          firstBody.node.name = @"ball_blink";
        } else {
          if ([[firstBody.node name] isEqualToString:@"ball_speedshift"] && item == -1) {
            if (chance > 50) {
              item = 0;
              [self addChild:gameArray[1]];
            } else {
              item = 1;
              [self addChild:gameArray[3]];
            }
            [gameArray[2] removeFromParent];
          }
          [firstBody.node setAlpha:1.0];
          firstBody.node.name = @"ball_normal";
        }
        double vectorTotal = fabs(firstBody.node.position.x - secondBody.node.position.x) + fabs(firstBody.node.position.y - secondBody.node.position.y);
        double multi = (midX*(ballSpeedFactor/10000))/vectorTotal;
        firstBody.velocity = CGVectorMake((firstBody.node.position.x - secondBody.node.position.x)*multi, (firstBody.node.position.y - secondBody.node.position.y)*multi);
      }
      ballSpeedFactor++;
      energy = energy+26-numContain-25*numContain+25*numBalls;
      if (energy > energy0) {
        energy = energy0;
      }
    } else if ((secondBody.categoryBitMask & boundCategory) != 0) {
      [firstBody.node removeFromParent];
      numBalls--;
      if (numBalls == numContain-1) {
        if (userTutorial) {
          playTime = 4;
          //notify tutorial
        } else {
          userGameOver = true;
          [self gameOver];
        }
      } else {
        self.backgroundColor = [SKColor colorWithWhite:0.2 alpha:1];
        [self performSelector:@selector(screenFlash) withObject:nil afterDelay:0.1];
      }
    }
  }
}

@end
