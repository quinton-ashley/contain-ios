//
//  GameScene.m
//  CONTAIN
//
//  Created by Quinton Ashley on 12/18/14.
//  Copyright (c) 2014 Quinton Ashley. All rights reserved.
//

#import "GameScene.h"
#import "Ball.h"
#import "Paddle.h"
#import "GameViewController.h"
#import "GameKitHelper.h"
#import <GameKit/GameKit.h>

@implementation GameScene

- (void)didMoveToView:(SKView *)view {
    userInGame = userPlaying = userGameOver = userSelectMenu = false;
    self.backgroundColor = [SKColor colorWithWhite:0.05 alpha:1];
    //set game constants
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
    ballRadius = midX/160;
    padRadius0 = padRadius = midX/9.1;
    transitionTime = 0.2;
    energy0 = 400;
    eBarHeight = midX/150;
    eBarY = screenHeight-midX*2.1;
    
    SKShapeNode *border1 = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(screenWidth+40, 10)];
    border1.fillColor = [UIColor clearColor];
    border1.strokeColor = [UIColor clearColor];
    border1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(screenWidth+40, 10)];
    border1.position = CGPointMake(midX, screenHeight+15);
    border1.physicsBody.dynamic = NO;
    border1.physicsBody.categoryBitMask = boundCategory;
    border1.physicsBody.collisionBitMask = 0x1 << 10;
    border1.physicsBody.contactTestBitMask = ballCategory;
    
    SKShapeNode *border2 = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(10, screenWidth+40)];
    border2.fillColor = [UIColor clearColor];
    border2.strokeColor = [UIColor clearColor];
    border2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(10, screenWidth+40)];
    border2.position = CGPointMake(-15, screenHeight-midX);
    border2.physicsBody.dynamic = NO;
    border2.physicsBody.categoryBitMask = boundCategory;
    border2.physicsBody.collisionBitMask = 0x1 << 10;
    border2.physicsBody.contactTestBitMask = ballCategory;

    SKShapeNode *border3 = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(10, screenWidth+40)];
    border3.fillColor = [UIColor clearColor];
    border3.strokeColor = [UIColor clearColor];
    border3.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(10, screenWidth+40)];
    border3.position = CGPointMake(screenWidth+15, screenHeight-midX);
    border3.physicsBody.dynamic = NO;
    border3.physicsBody.categoryBitMask = boundCategory;
    border3.physicsBody.collisionBitMask = 0x1 << 10;
    border3.physicsBody.contactTestBitMask = ballCategory;
    
    SKShapeNode *border4 = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(screenWidth+40, 10)];
    border4.fillColor = [UIColor clearColor];
    border4.strokeColor = [UIColor clearColor];
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
    SKSpriteNode *g2 = [SKSpriteNode spriteNodeWithImageNamed:@"Contain-addballfilled"];
    SKSpriteNode *g3 = [SKSpriteNode spriteNodeWithImageNamed:@"Contain-refill"];
    SKSpriteNode *g4 = [SKSpriteNode spriteNodeWithImageNamed:@"Contain-refillready"];
    SKSpriteNode *g5 = [SKSpriteNode spriteNodeWithImageNamed:@"Contain-score"];
    
    
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
    g1.position = g2.position = u6.position = CGPointMake(midX/6, screenHeight-midX*2.4);
    g3.position = g4.position = u8.position = CGPointMake(midX*1.84, screenHeight-midX*2.4);
    g5.position = CGPointMake(midX/6, screenHeight-midX*2.76);
    g1.alpha = g3.alpha = 0.4;
    
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
    g1.size = g2.size = g3.size = g4.size = g5.size = u6.size = u8.size = CGSizeMake(midX/4, midX/3);
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
    gameArray = [[NSMutableArray alloc] initWithObjects:g0, g1, g2, g3, g4, g5, nil];
    mainArray = [[NSMutableArray alloc] initWithObjects:m0, m1, m2, m3, nil];
    selectArray = [[NSMutableArray alloc] initWithObjects:s0, s1, s2, s3, nil];
    
    paddleArray =  [[NSMutableArray alloc] initWithObjects: nil];
    
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
    
    playTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timePassed) userInfo:nil repeats:YES];
    
    scorePosition = CGPointMake(midX/6, screenHeight-midX*3);
    
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
    if (userFromLoad) {
        //omits the 0 object in each array on purpose because they are already display on the load screen
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
        [universalArray[8] removeFromParent];
        [gameArray[5] removeFromParent];
        if (scoreLabel != nil) {
            [scoreLabel removeFromParent];
        }
        if (!userGameOver) {
            [universalArray[7] removeFromParent];
        }
        for (int i=0; i<mainArray.count; i++) {
            [self addChild:mainArray[i]];
        }
        userInGame = false;
    }
    userMainMenu = true;
}

- (void)setupSelectMenu { //this menu can only be acessed through the main menu
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

-(void)viewHighScores {
    [[NSNotificationCenter defaultCenter] postNotificationName:PresentGameCenterViewController object:self userInfo:nil];
}

- (void)setupGameButtons { //the game user interface can be set up through the pause menu, game over menu, and select difficulty menu
    [universalArray[0] runAction:gameu0resize];
    [universalArray[0] runAction:gameu2move];
    [self addChild:gameArray[1]];
    [self addChild:gameArray[3]];
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
        for (int i=0; i<selectArray.count; i++) {
            [selectArray[i] removeFromParent];
        }
        userSelectMenu = false;
    } else if (!userPlaying) {
        [universalArray[6] removeFromParent];
        [universalArray[8] removeFromParent];
        if (userGameOver) {
            //remove end game stats
        } else {
            self.backgroundColor = [SKColor colorWithWhite:0 alpha:1];
            userPlaying = true;
            self.paused = false;
            [universalArray[7] removeFromParent];
        }
    }
}

- (void)setupPauseMenu {
    if (userInGame && userPlaying) {
        self.backgroundColor = [SKColor colorWithWhite:0.4 alpha:1];
        userPlaying = false;
        self.paused = true;
        [universalArray[0] setPosition:CGPointMake(midX, screenHeight-midX*4)];
        [self addChild:universalArray[6]];
        [self addChild:universalArray[7]];
        [self addChild:universalArray[8]];
        [gameArray[1] removeFromParent];
        [gameArray[3] removeFromParent];
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
        [self addChild:universalArray[8]];
        [gameArray[1] removeFromParent];
        [gameArray[3] removeFromParent];
    } else {
        self.paused = false;
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
    userPlaying = userInGame = false;
}

- (void)startGame {
    self.backgroundColor = [SKColor colorWithWhite:0.05 alpha:1];
    numBalls = angle = playTime = item0Amount = item1Amount = 0;
    [gameArray[1] setAlpha:0.4];
    [gameArray[3] setAlpha:0.4];
    numPaddles = 8;
    ballTime = 2;
    ballSpeedFactor = 1100;
    energy = energy0;
    energyBar = [SKShapeNode shapeNodeWithRect:CGRectMake(0, eBarY, midX*2, eBarHeight)];
    energyBar.fillColor = [UIColor whiteColor];
    [self addChild:energyBar];
    if (scoreLabel != nil) {
        [scoreLabel removeFromParent];
    }
    scoreLabel = [SKLabelNode labelNodeWithText:[@(playTime*10000) stringValue]];
    scoreLabel.position = scorePosition;
    scoreLabel.verticalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    scoreLabel.fontSize = 18;
    [self addChild:scoreLabel];
    [self addBall];
    if (numContain > 1) {
        [self addBall];
    }
    padRadius = padRadius0;
    padPath = CGPathCreateMutable();
    CGPathAddArc(padPath, NULL, 0,0, padRadius, GLKMathDegreesToRadians(348), GLKMathDegreesToRadians(208), YES);
    CGPathAddArc(padPath, NULL, 0,0, padRadius-padRadius/8, GLKMathDegreesToRadians(555), GLKMathDegreesToRadians(0), YES);
    for (int i=0; i<numPaddles; i++) {
        paddleArray[i] = [Paddle newPaddleWithPath:padPath withRadius:padRadius];
        [paddleArray[i] setFillColor:(__bridge CGColorRef)([UIColor colorWithWhite:0.4 alpha:1])];
        [self addChild:paddleArray[i]];
    }
    //padRadiusChange = padRadius0;
    //changePadRadius =
    userGameOver = false;
    userInGame = userPlaying = padRevolve = true;
}

-(void)timePassed {
    if (userPlaying) {
        playTime++;
        [scoreLabel removeFromParent];
        scoreLabel = [SKLabelNode labelNodeWithText:[@(playTime*10000) stringValue]];
        scoreLabel.position = scorePosition;
        scoreLabel.verticalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        scoreLabel.fontSize = 18;
        [self addChild:scoreLabel];
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
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if (!userInGame) {
            if (userMainMenu) {
                if (CGRectContainsPoint([universalArray[1] frame], location)) {
                    userMainMenu = false;
                    [self setupSelectMenu];
                }
                else if (CGRectContainsPoint([universalArray[2] frame], location)) {
                    [self viewHighScores];
                } else if (CGRectContainsPoint([universalArray[3] frame], location)) {
                    //[self setupHowTo];
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
                } else if (CGRectContainsPoint([universalArray[3] frame], location)) {
                    [self setupGameButtons];
                    [self startGame];
                }
            }
        } else {
            if (userPlaying) {
                if (location.y < midY) {
                    if (location.x < midX/4) {
                        if (CGRectContainsPoint([universalArray[1] frame], location)) {
                            if (item0Amount > 0) {
                                [self addBall];
                                item0Amount--;
                                if (item0Amount == 0) {
                                    [gameArray[1] setAlpha:0.4];
                                }
                            }
                        }
                    } else if (location.x < midX*7/4) {
                        padRevolve = !padRevolve;
                        for (int i=0; i<numPaddles; i++) {
                            [paddleArray[i] setFillColor:(__bridge CGColorRef)([UIColor whiteColor])];
                        }
                        [self addChild:gameArray[0]];
                    } else {
                        if (CGRectContainsPoint([universalArray[3] frame], location)) {
                            if (item1Amount > 0) {
                                energy = energy0;
                                item1Amount--;
                                if (item1Amount == 0) {
                                    [gameArray[3] setAlpha:0.4];
                                }
                            }
                        }
                    }
                } else if (padRevolve) {
                    [self setupPauseMenu];
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
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (userInGame && userPlaying && !padRevolve) {
        padRevolve = !padRevolve;
        for (int i=0; i<numPaddles; i++) {
            [paddleArray[i] setFillColor:(__bridge CGColorRef)([UIColor colorWithWhite:0.4 alpha:1])];
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
                [paddleArray[i] setPosition:CGPointMake((sin(GLKMathDegreesToRadians(angle+i*45))*midX)+midX, (cos(GLKMathDegreesToRadians(angle+i*45))*midX)+(screenHeight-midX))];
                [paddleArray[i] setZRotation:-GLKMathDegreesToRadians(angle+8+i*45)];
            }
        } else {
            energy--;
        }
        [energyBar removeFromParent];
        energyBar = [SKShapeNode shapeNodeWithRect:CGRectMake(0, eBarY, midX*2*energy/energy0, eBarHeight)];
        energyBar.fillColor = [UIColor whiteColor];
        [self addChild:energyBar];
        if (energy < 0) {
            userGameOver = true;
            [self gameOver];
        }
    }
}

- (void)addBall {
    Ball *newBall = [Ball newBallWithRadiusOf:ballRadius atPoint:center withSpeed:(midX*(ballSpeedFactor/10000))];
    newBall.name = @"ball_normal";
    [self addChild:newBall];
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
//        [paddleArray[i] setFillColor:(__bridge CGColorRef)([UIColor colorWithWhite:0.4 alpha:1])];
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
    }
    else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    if ((firstBody.categoryBitMask & ballCategory) != 0) {
        if ((secondBody.categoryBitMask & paddleCategory) != 0 && !padRevolve) {
            int chance = arc4random_uniform(100);
            if ([[firstBody.node name] isEqualToString:@"ball_blink"]) {
                [firstBody.node setAlpha:0.4];
                double vectorTotal = abs(firstBody.node.position.x - secondBody.node.position.x) + abs(firstBody.node.position.y - secondBody.node.position.y);
                double multi = (midX*(ballSpeedFactor/10000))/vectorTotal;
                firstBody.velocity = CGVectorMake((firstBody.node.position.x - secondBody.node.position.x)*multi*3, (firstBody.node.position.y - secondBody.node.position.y)*multi*3);
                firstBody.node.name = @"ball_speedshift";
            } else {
                if (chance < 10 && [[firstBody.node name] isEqualToString:@"ball_normal"]) {
                    firstBody.node.name = @"ball_blink";
                } else {
                    if ([[firstBody.node name] isEqualToString:@"ball_speedshift"]) {
                        if (chance > 50) {
                            item0Amount++;
                            [gameArray[1] setAlpha:1.0];
                        } else {
                            item1Amount++;
                            [gameArray[3] setAlpha:1.0];
                        }
                    }
                    [firstBody.node setAlpha:1.0];
                    firstBody.node.name = @"ball_normal";
                }
                double vectorTotal = abs(firstBody.node.position.x - secondBody.node.position.x) + abs(firstBody.node.position.y - secondBody.node.position.y);
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
                userGameOver = true;
                [self gameOver];
            } else {
                self.backgroundColor = [SKColor colorWithWhite:0.2 alpha:1];
                [self performSelector:@selector(screenFlash) withObject:nil afterDelay:0.1];
            }
        }
    }
}

@end

