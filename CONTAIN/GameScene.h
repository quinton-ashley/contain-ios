//
//  GameScene.h
//  CONTAIN
//

//  Copyright (c) 2014 Quinton Ashley. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene <SKPhysicsContactDelegate> {
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
    int numItems;
    int numBalls;
    int numContain;
    
    //physics groups
    uint32_t ballCategory;
    uint32_t paddleCategory;
    uint32_t boundCategory;
    
    //radius of the ball
    CGFloat ballRadius;
    
    //the speed at which the paddles move
    double ballSpeedFactor;
    
    //standard radius value
    CGFloat padRadius0;
    
    //actual radius value of paddle
    CGFloat padRadius;
    
    //the desired radius size to change the paddle to
    CGFloat padRadiusChange;
    
    //the paddle's shape
    CGMutablePathRef padPath;
    
    //the angle of rotation of the circle of paddles
    double angle;
    
    //number of which item is active
    int itemActive;
    
    int item0Amount;
    int item1Amount;
    int item2Amount;
    int item3Amount;
    
    //time values
    int itemTime;
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
    bool userGotItem;
    
    bool userGameOver;
    
    //boolean for if the paddles radi must be changed
    bool changePadRadius;
    
    double transitionTime;
    
    int energy0;
    int energy;
    int eBarY;
    int eBarHeight;
    
    SKShapeNode *energyBar;
    
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
}
//method that pauses the game
- (void)setupPauseMenu;
@end
