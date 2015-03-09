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

@implementation GameScene

- (void)didMoveToView:(SKView *)view {
    userInGame = userPlaying = userGameOver = userSelectMenu = userGotItem = false;
    self.backgroundColor = [SKColor colorWithWhite:0.05 alpha:1];
    //set game constants
    self.physicsWorld.gravity = CGVectorMake(0.0f, 0.0f);
    self.physicsWorld.contactDelegate = self;
    ballCategory    =  0x1 << 0;
    paddleCategory  =  0x1 << 1;
    boundCategory   =  0x1 << 2;
    midX = self.size.width/2;
    midY = self.size.height/2;
    center = CGPointMake(midX, self.size.height-midX);
    ballRadius = midX/160;
    padRadius0 = padRadius = midX/9.1;
    transitionTime = 0.2;
    energy0 = 400;
    eBarHeight = midX/150;
    eBarY = self.size.height-midX*2.1;
    
    SKShapeNode *border1 = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(self.size.width+40, 10)];
    border1.fillColor = [UIColor clearColor];
    border1.strokeColor = [UIColor clearColor];
    border1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.size.width+40, 10)];
    border1.position = CGPointMake(midX, self.size.height+15);
    border1.physicsBody.dynamic = NO;
    border1.physicsBody.categoryBitMask = boundCategory;
    border1.physicsBody.collisionBitMask = 0x1 << 10;
    border1.physicsBody.contactTestBitMask = ballCategory;
    
    SKShapeNode *border2 = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(10, self.size.width+40)];
    border2.fillColor = [UIColor clearColor];
    border2.strokeColor = [UIColor clearColor];
    border2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(10, self.size.width+40)];
    border2.position = CGPointMake(-15, self.size.height-midX);
    border2.physicsBody.dynamic = NO;
    border2.physicsBody.categoryBitMask = boundCategory;
    border2.physicsBody.collisionBitMask = 0x1 << 10;
    border2.physicsBody.contactTestBitMask = ballCategory;

    SKShapeNode *border3 = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(10, self.size.width+40)];
    border3.fillColor = [UIColor clearColor];
    border3.strokeColor = [UIColor clearColor];
    border3.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(10, self.size.width+40)];
    border3.position = CGPointMake(self.size.width+15, self.size.height-midX);
    border3.physicsBody.dynamic = NO;
    border3.physicsBody.categoryBitMask = boundCategory;
    border3.physicsBody.collisionBitMask = 0x1 << 10;
    border3.physicsBody.contactTestBitMask = ballCategory;
    
    SKShapeNode *border4 = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(self.size.width+40, 10)];
    border4.fillColor = [UIColor clearColor];
    border4.strokeColor = [UIColor clearColor];
    border4.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.size.width+40, 10)];
    border4.position = CGPointMake(midX, self.size.height-self.size.width-15);
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
    
    u0.position = CGPointMake(midX, self.size.height-midX);
    u1.position = CGPointMake(midX, self.size.height-midX*2.2);
    u2.position = CGPointMake(midX, self.size.height-midX*2.6);
    u3.position = CGPointMake(midX, self.size.height-midX*3);
    u4.position = CGPointMake(midX/6, self.size.height-midX*2.9);
    u5.position = CGPointMake(midX*1.84, self.size.height-midX*2.9);
    u7.position = CGPointMake(midX, self.size.height-midX*2.65);
    
    g0.position = CGPointMake(midX, self.size.height-midX*2.65);
    g1.position = g2.position = u6.position = CGPointMake(midX/6, self.size.height-midX*2.4);
    g3.position = g4.position = u8.position = CGPointMake(midX*1.84, self.size.height-midX*2.4);
    g5.position = CGPointMake(midX/6, self.size.height-midX*2.76);
    
    m0.position = CGPointMake(midX, self.size.height-midX*1.6);
    m1.position = CGPointMake(midX, self.size.height-midX*2.2);
    m2.position = CGPointMake(midX, self.size.height-midX*2.6);
    m3.position = CGPointMake(midX, self.size.height-midX*3);
    
    s0.position = CGPointMake(midX, self.size.height-midX*1.6);
    s1.position = CGPointMake(midX/3, self.size.height-midX*2.2);
    s2.position = CGPointMake(midX, self.size.height-midX*2.2);
    s3.position = CGPointMake(midX*5/3, self.size.height-midX*2.2);
    
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
    gameu1move = [SKAction moveTo:CGPointMake(midX/6, self.size.height-midX*2.4) duration:transitionTime];
    gameu2move = [SKAction moveTo:CGPointMake(midX, self.size.height-midX*2.65) duration:transitionTime];
    gameu3move = [SKAction moveTo:CGPointMake(midX*1.84, self.size.height-midX*2.4) duration:transitionTime];
    
    overu0resize = [SKAction resizeToWidth:midX/3 height:midX/6 duration:transitionTime];
    
    pauseboxresize = [SKAction resizeToWidth:midX/2 height:midX/3 duration:transitionTime];
    pauseu0move = [SKAction moveTo:CGPointMake(midX, self.size.height-midX*4) duration:transitionTime];
    pauseu1move = [SKAction moveTo:CGPointMake(midX/3, self.size.height-midX*2.2) duration:transitionTime];
    pauseu2move = [SKAction moveTo:CGPointMake(midX, self.size.height-midX*2.2) duration:transitionTime];
    pauseu3move = [SKAction moveTo:CGPointMake(midX*5/3, self.size.height-midX*2.2) duration:transitionTime];
    
    mainu0resize = [SKAction resizeToWidth:midX*1.5 height:midX duration:transitionTime];
    mainboxresize = [SKAction resizeToWidth:midX height:midX/3 duration:transitionTime];
    
    mainu0move = [SKAction moveTo:CGPointMake(midX, self.size.height-midX) duration:transitionTime];
    mainu1move = [SKAction moveTo:CGPointMake(midX, self.size.height-midX*2.2) duration:transitionTime];
    mainu2move = [SKAction moveTo:CGPointMake(midX, self.size.height-midX*2.6) duration:transitionTime];
    mainu3move = [SKAction moveTo:CGPointMake(midX, self.size.height-midX*3) duration:transitionTime];
    
    playTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timePassed) userInfo:nil repeats:YES];
    
    userFromLoad = true;
    
    [self addChild:border1];
    [self addChild:border2];
    [self addChild:border3];
    [self addChild:border4];
    [self setupMainMenu];
}

- (void)setupMainMenu { //this menu can be accessed from the load screen, pause menu, game over menu, how to menu, and the high score list
    if (userFromLoad) {
        for (int i=0; i<4; i++) {
            [self addChild:universalArray[i]];
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
        //remove score and other labels that remain visible during both gameover and pause screens
        [gameArray[5] removeFromParent];
        //if else statement for removing labels that exist seperately on the game over and pause screens
        if (!userGameOver) {
            [universalArray[7] removeFromParent];
        } else {
            //remove game over message
        }
        userInGame = false;
    }
    for (int i=0; i<mainArray.count; i++) {
        [self addChild:mainArray[i]];
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
        [universalArray[0] setPosition:CGPointMake(midX, self.size.height-midX*4)];
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
//    [self enumerateChildNodesWithName:@"ball_fast" usingBlock:^(SKNode *node, BOOL *stop) {
//        [node removeFromParent];
//    }];
//    [self enumerateChildNodesWithName:@"ball_warp" usingBlock:^(SKNode *node, BOOL *stop) {
//        [node removeFromParent];
//    }];
//    [self enumerateChildNodesWithName:@"ball_turn" usingBlock:^(SKNode *node, BOOL *stop) {
//        [node removeFromParent];
//    }];
//    [self enumerateChildNodesWithName:@"ball_shrink" usingBlock:^(SKNode *node, BOOL *stop) {
//        [node removeFromParent];
//    }];
    for (int i=0; i<numPaddles; i++) {
        [paddleArray[i] removeFromParent];
    }
    [energyBar removeFromParent];
    userPlaying = userInGame = userGotItem = false;
}

- (void)startGame {
    self.backgroundColor = [SKColor colorWithWhite:0.05 alpha:1];
    numBalls = angle = playTime = item0Amount = item1Amount = item2Amount = item3Amount = 0;
    numPaddles = 8;
    numItems = 4;
    ballTime = 2;
    itemActive = itemTime = -1;
    ballSpeedFactor = 1100;
    energy = energy0;
    energyBar = [SKShapeNode shapeNodeWithRect:CGRectMake(0, eBarY, midX*2, eBarHeight)];
    energyBar.fillColor = [UIColor whiteColor];
    [self addChild:energyBar];
    [self addBall];
    [self addBall];
    padRadius = padRadius0;
    padPath = CGPathCreateMutable();
    CGPathAddArc(padPath, NULL, 0,0, padRadius, GLKMathDegreesToRadians(348), GLKMathDegreesToRadians(208), YES);
    CGPathAddArc(padPath, NULL, 0,0, padRadius-padRadius/8, GLKMathDegreesToRadians(555), GLKMathDegreesToRadians(0), YES);
    for (int i=0; i<numPaddles; i++) {
        paddleArray[i] = [Paddle newPaddleWithPath:padPath withRadius:padRadius];
        [self changePad:i toColor:0.4];
        [self addChild:paddleArray[i]];
    }
    padRadiusChange = padRadius0;
    changePadRadius = userGameOver = false;
    userInGame = userPlaying = padRevolve = true;
}

-(void)timePassed {
    if (userPlaying) {
        playTime++;
        //NSLog(@"%d, %d", playTime, itemTime);
        if (itemTime == playTime) {
            [self deactivateItem:itemActive];
        }
        if (playTime == ballTime) {
            [self addBall];
            ballTime = playTime+40+(numContain*5);
        }
//        [self enumerateChildNodesWithName:@"ball_blink" usingBlock:^(SKNode *node, BOOL *stop) {
//            if (node.alpha == 1.0) {
//                [node setAlpha:0.4];
//            } else {
//                [node setAlpha:1.0];
//            }
//        }];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        //NSLog(@"%f, %f", location.x, location.y);
        if (!userInGame) {
            if (userMainMenu) {
                if (CGRectContainsPoint([universalArray[1] frame], location)) {
                    userMainMenu = false;
                    [self setupSelectMenu];
                }
//                else if (CGRectContainsPoint([universalArray[2] frame], location)) {
//                    [self viewHighScores];
//                } else if (CGRectContainsPoint([universalArray[3] frame], location)) {
//                    [self setupHowTo];
//                }
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
                            [self activateItem:0];
                        } else if (CGRectContainsPoint([universalArray[4] frame], location)) {
                            [self activateItem:2];
                        }
                    } else if (location.x < midX*7/4) {
                        padRevolve = !padRevolve;
                        for (int i=0; i<numPaddles; i++) {
                            [paddleArray[i] setFillColor:(__bridge CGColorRef)([UIColor whiteColor])];
                        }
                        [self addChild:gameArray[0]];
                    } else {
                        if (CGRectContainsPoint([universalArray[3] frame], location)) {
                            [self activateItem:1];
                        } else if (CGRectContainsPoint([universalArray[5] frame], location)) {
                            [self activateItem:3];
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
            [self changePad:i toColor:0.4];
        }
        [gameArray[0] removeFromParent];
    }
}

- (void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    if (userInGame && userPlaying) {
        if (padRevolve) {
            if (changePadRadius) {
                [self changePadsToSize:padRadiusChange];
            }
            angle+=1.5;
            if (angle >= 360) {
                angle = 0;
            }
            for (int i=0; i<numPaddles; i++) {
                [paddleArray[i] setPosition:CGPointMake((sin(GLKMathDegreesToRadians(angle+i*45))*midX)+midX, (cos(GLKMathDegreesToRadians(angle+i*45))*midX)+(self.size.height-midX))];
                [paddleArray[i] setZRotation:-GLKMathDegreesToRadians(angle+8+i*45)];
            }
            if (fmod(angle, 20) == 0) {
                [self changePad:arc4random_uniform(numPaddles) toColor:0.4];
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

-(void)changePad:(int)padNum toColor:(double)colorNum {
//    [paddleArray[padNum] setFillColor:(__bridge CGColorRef)([UIColor colorWithWhite:((double) arc4random_uniform(50)+60)/100 alpha:1])];
    [paddleArray[padNum] setFillColor:(__bridge CGColorRef)([UIColor colorWithWhite:colorNum alpha:1])];
}

-(void)changePadsToSize:(double)desiredRadius {
    if ((padRadius < desiredRadius && padRadius > desiredRadius-5) || (padRadius > desiredRadius && padRadius < desiredRadius+5)) {
        changePadRadius = false;
    }
    if (padRadius < desiredRadius+5) {
        padRadius++;
    } else {
        padRadius--;
    }
    padPath = CGPathCreateMutable();
    CGPathAddArc(padPath, NULL, 0,0, padRadius, GLKMathDegreesToRadians(348), GLKMathDegreesToRadians(208), YES);
    CGPathAddArc(padPath, NULL, 0,0, padRadius-padRadius/8, GLKMathDegreesToRadians(555), GLKMathDegreesToRadians(0), YES);
    for (int i=0; i<numPaddles; i++) {
        [paddleArray[i] removeFromParent];
        paddleArray[i] = [Paddle newPaddleWithPath:padPath withRadius:padRadius];
        [self changePad:i toColor:0.4];
        [self addChild:paddleArray[i]];
    }
}

-(void)activateItem:(int)itemNum {
    if (itemActive == -1) {
        if (itemNum == 0 && item0Amount > 0 && !changePadRadius) {
            padRadiusChange = padRadius0*2;
            changePadRadius = true;
            itemActive = 0;
            itemTime = playTime+10;
            item0Amount--;
        } else if (itemNum == 1 && item1Amount > 0) {
            energy = energy0;
            item1Amount--;
        }
    }
}

-(void)deactivateItem:(int)itemNum {
    if (itemNum == 0) {
        padRadiusChange = padRadius0;
        changePadRadius = true;
        itemActive = -1;
    }
}

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
            ballSpeedFactor++;
            double vectorTotal = abs(firstBody.node.position.x - secondBody.node.position.x) + abs(firstBody.node.position.y - secondBody.node.position.y);
            double multi = (midX*(ballSpeedFactor/10000))/vectorTotal;
            firstBody.velocity = CGVectorMake((firstBody.node.position.x - secondBody.node.position.x)*multi, (firstBody.node.position.y - secondBody.node.position.y)*multi);
            energy = energy+26-numContain-25*numContain+25*numBalls;
            if (energy > energy0) {
                energy = energy0;
            }
//            if ([[firstBody.node name] isEqualToString:@"ball_blink"]) {
//                firstBody.node.name = @"ball_fast";
//            } else {
//                firstBody.node.name = @"ball_blink";
//            }
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
