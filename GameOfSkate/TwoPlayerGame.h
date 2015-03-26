//
//  TwoPlayerGame.h
//  GameOfSkate
//
//  Created by Woudini on 12/18/14.
//  Copyright (c) 2014 Hi Range. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwoPlayerGame : NSObject

-(instancetype)init;

@property (nonatomic) int playerOneScore;
@property (nonatomic) int playerTwoScore;

- (void)givePlayerOneALetter;
- (void)givePlayerTwoALetter;
- (void)undoPlayerOneLetter;
- (void)undoPlayerTwoLetter;
- (void)resetGame;
- (NSString *)playerOneLoses:(NSString *)playerTwoName;
- (NSString *)playerTwoLoses:(NSString *)playerOneName;

@end
