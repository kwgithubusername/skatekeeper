//
//  TwoPlayerGame.m
//  GameOfSkate
//
//  Created by Woudini on 12/18/14.
//  Copyright (c) 2014 Hi Range. All rights reserved.
//

#import "TwoPlayerGame.h"

@implementation TwoPlayerGame

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self resetGame];
    }
    return self;
}

// Player one loses

- (NSArray *)lettersArray
{
    return @[@"",@"S", @"SK", @"SKA", @"SKAT", @"SKATE"];

}

-(NSString *)letterScore:(int)score
{
    return [[self lettersArray] objectAtIndex:score];
}

// Player one loses

- (NSString *)playerOneLoses:(NSString *)playerTwoName
{
    NSString *alertMessage = nil;
    if (self.playerOneScore > 4)
    {
        alertMessage = [[NSString alloc] initWithFormat:@"Winner: %@\rScore: %@", playerTwoName, [self letterScore:self.playerTwoScore]];
    }
    return alertMessage;
}

// Player two loses

- (NSString *)playerTwoLoses:(NSString *)playerOneName
{
    NSString *alertMessage = nil;
    if (self.playerTwoScore > 4)
    {
        alertMessage = [[NSString alloc] initWithFormat:@"Winner: %@\rScore: %@", playerOneName, [self letterScore:self.playerOneScore]];
    }
    return alertMessage;
}

// Prevent player one from crashing the array
- (void)setPlayerOneScore:(int)playerOneScore
{
    if (playerOneScore < 6 && playerOneScore >= 0) {
        _playerOneScore = playerOneScore;
    }
}
// Prevent player two from crashing the array
- (void)setPlayerTwoScore:(int)playerTwoScore
{
    if (playerTwoScore < 6 &&  playerTwoScore >= 0) {
        _playerTwoScore = playerTwoScore;
    }
}

// Give player one a letter
- (void)givePlayerOneALetter
{
    self.playerOneScore++;
}

// Give player two a letter
- (void)givePlayerTwoALetter
{
    self.playerTwoScore++;
}

// Remove a letter from player one
- (void)undoPlayerOneLetter
{
    self.playerOneScore--;
}

// Remove a letter from player two
- (void)undoPlayerTwoLetter
{
    self.playerTwoScore--;
}

// Reset game
- (void)resetGame
{
    self.playerOneScore = 0;
    self.playerTwoScore = 0;
    
}

@end
