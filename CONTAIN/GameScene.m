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
    //set game constants
    self.backgroundColor = [SKColor colorWithWhite:0 alpha:1];
    self.physicsWorld.gravity = CGVectorMake(0.0f, 0.0f);
    self.physicsWorld.contactDelegate = self;
    ballCategory     =  0x1 << 0;
    paddleCategory   =  0x1 << 1;
    boundCategory    =  0x1 << 2;
    midX = CGRectGetMidX(self.frame);
    midY = CGRectGetMidY(self.frame);
    center = CGPointMake(midX, midX);
    ballRadius = midX/256;
    padRadius = midX/20;
    //the border probably doesn't need to be dynamic
//    boundPath = CGPathCreateMutable();
//    CGPathAddRect(boundPath, NULL, CGRectMake(midX, self.size.height, -midX*1.5, -10));
//    CGPathAddRect(boundPath, NULL, CGRectMake(midX/2, self.size.height, 10, -midX));
//    CGPathAddRect(boundPath, NULL, CGRectMake(midX*1.5, self.size.height, -10, -midX));
//    CGPathAddRect(boundPath, NULL, CGRectMake(midX, midX/2, -midX*1.5, 10));
    
    SKShapeNode *border1 = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(midX, 10)];
    border1.fillColor = [UIColor colorWithWhite:1 alpha:0.1];
    border1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(midX, 10)];
    border1.position = CGPointMake(midX, self.size.height-5);
    border1.physicsBody.categoryBitMask = boundCategory;
    border1.physicsBody.collisionBitMask = 0x1 << 3;
    border1.physicsBody.contactTestBitMask = ballCategory;
    
    SKShapeNode *border2 = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(10, midX)];
    border2.fillColor = [UIColor colorWithWhite:1 alpha:0.1];
    border2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(10, midX)];
    border2.position = CGPointMake(0, midX);
    border2.physicsBody.categoryBitMask = boundCategory;
    border2.physicsBody.collisionBitMask = 0x1 << 3;
    border2.physicsBody.contactTestBitMask = ballCategory;

    SKShapeNode *border3 = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(10, midX)];
    border3.fillColor = [UIColor colorWithWhite:1 alpha:0.1];
    border3.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(10, midX)];
    border3.position = CGPointMake(self.size.width, midX);
    border3.physicsBody.categoryBitMask = boundCategory;
    border3.physicsBody.collisionBitMask = 0x1 << 3;
    border3.physicsBody.contactTestBitMask = ballCategory;
    
    SKShapeNode *border4 = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(midX, 10)];
    border4.fillColor = [UIColor colorWithWhite:1 alpha:0.1];
    border4.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(midX, 10)];
    border4.position = CGPointMake(midX, midX/2+5);
    border4.physicsBody.categoryBitMask = boundCategory;
    border4.physicsBody.collisionBitMask = 0x1 << 3;
    border4.physicsBody.contactTestBitMask = ballCategory;
    
    
    [self addChild:border1];
    [self addChild:border2];
    [self addChild:border3];
    [self addChild:border4];
    //setup menu
    
    //setup the game
    [self setupGame];
}

- (void)setupGame {
    //    borderSize = midX/2;
    //    setup =  [[NSMutableArray alloc] initWithObjects: nil];
    //    setup[0] = [SKShapeNode shapeNodeWithRect:CGRectMake(midX, -midY, borderSize, borderSize)];
    //    [setup[0] setFillColor:(__bridge CGColorRef)([UIColor grayColor])];
    //    //[setup[0] setPosition:CGPointMake(0, 0)];
    ////
    ////    setup[1] = [SKShapeNode shapeNodeWithRect:CGRectMake(0, 0, borderSize, borderSize)];
    ////    [setup[1] setFillColor:(__bridge CGColorRef)([UIColor grayColor])];
    ////    [paddleArray[1] setPosition:CGPointMake(0, 0)];
    //
    //    for (int i=0; i<1; i++) {
    //        [self addChild:setup[i]];
    //    }
    numBalls = 1;
    numPaddles = 8;
    angle = 0;
    speedFactor = 70;
    
    padRevolve = true;
    padPath = CGPathCreateMutable();
    CGPathAddArc(padPath, NULL, 0,0, padRadius, GLKMathDegreesToRadians(348), GLKMathDegreesToRadians(208), YES);
    paddleArray =  [[NSMutableArray alloc] initWithObjects: nil];
    for (int i=0; i<numPaddles; i++) {
        paddleArray[i] = [Paddle newPaddleWithPath:padPath withRadius:padRadius];
        [self changePadColor1:i];
        [self addChild:paddleArray[i]];
    }
    [self addBall];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        NSLog(@"%f, %f", location.x, location.y);
        if (location.y < midY) {
            padRevolve = !padRevolve;
            for (int i=0; i<numPaddles; i++) {
                [paddleArray[i] setFillColor:(__bridge CGColorRef)([UIColor whiteColor])];
            }
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!padRevolve) {
        padRevolve = !padRevolve;
        for (int i=0; i<numPaddles; i++) {
            [self changePadColor1:i];
        }
    } else {
        [self addBall];
    }
}

- (void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    if (padRevolve) {
        //increase energy
        angle+=1.5;
        if (angle >= 360) {
            angle = 0;
        }
        for (int i=0; i<numPaddles; i++) {
            [paddleArray[i] setPosition:CGPointMake((sin(GLKMathDegreesToRadians(angle+i*45))*midX/2.3)+midX, (cos(GLKMathDegreesToRadians(angle+i*45))*midX/2.3)+midX)];
            [paddleArray[i] setZRotation:-GLKMathDegreesToRadians(angle+8+i*45)];
        }
        if (fmod(angle, 20) == 0) {
            [self changePadColor1:arc4random_uniform(numPaddles)];
        }
    } else {
        //decrease energy
        //NSLog(@"%d", speedFactor);
    }
}

- (void)addBall {
    Ball *newBall = [Ball newBallWithRadiusOf:ballRadius atPoint:center];
    [self addChild:newBall];
}

-(void)changePadColor1:(int)padNum {
//    [paddleArray[padNum] setFillColor:(__bridge CGColorRef)([UIColor colorWithWhite:((double) arc4random_uniform(50)+60)/100 alpha:1])];
    [paddleArray[padNum] setFillColor:(__bridge CGColorRef)([UIColor colorWithWhite:0.4 alpha:1])];
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
        if ((secondBody.categoryBitMask & paddleCategory) != 0) {
            if (!padRevolve) {
                speedFactor++;
                double vectorTotal = abs(firstBody.node.position.x - secondBody.node.position.x) + abs(firstBody.node.position.y - secondBody.node.position.y);
                double multi = (midX*(speedFactor/1000))/vectorTotal;
                NSLog(@"%f", (midX*(speedFactor/1000)));
                firstBody.velocity = CGVectorMake((firstBody.node.position.x - secondBody.node.position.x)*multi, (firstBody.node.position.y - secondBody.node.position.y)*multi);
            }
        } else if ((secondBody.categoryBitMask & boundCategory) != 0) {
            NSLog(@"out");
            [firstBody.node removeFromParent];
        }
    }
}

@end

