//
//  ThreePlayerGame.h
//  GameOfSkate
//
//  Created by Woudini on 12/18/14.
//  Copyright (c) 2014 Hi Range. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThreePlayerGame : NSObject

-(instancetype)init;

@property (nonatomic) int playerOneScore;
@property (nonatomic) int playerTwoScore;
@property (nonatomic) int playerThreeScore;

- (void)givePlayerOneALetter;
- (void)givePlayerTwoALetter;
- (void)givePlayerThreeALetter;
- (void)undoPlayerOneLetter;
- (void)undoPlayerTwoLetter;
- (void)undoPlayerThreeLetter;
- (void)resetGame;
- (NSString *)playerOneLoses:(NSString *)playerTwoName theGame:(NSString *)playerThreeName;
- (NSString *)playerTwoLoses:(NSString *)playerOneName theGame:(NSString *)playerThreeName;
- (NSString *)playerThreeLoses:(NSString *)playerOneName theGame:(NSString *)playerTwoName;

@end
