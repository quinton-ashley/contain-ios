//
//  GameScene.h
//  CONTAIN
//

//  Copyright (c) 2014 Quinton Ashley. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <GameKit/GameKit.h>

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
    
    NSNotification *didBecomeActiveNotification;
    NSNotification *willResignActiveNotification;
}
//method that pauses the game
+ (instancetype)sharedGameFunctions;

@end
