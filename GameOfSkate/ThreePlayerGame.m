//
//  ThreePlayerGame.m
//  GameOfSkate
//
//  Created by Woudini on 12/18/14.
//  Copyright (c) 2014 Hi Range. All rights reserved.
//

#import "ThreePlayerGame.h"

@implementation ThreePlayerGame

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [self resetGame];
    }
    return self;
}

- (NSArray *)lettersArray
{
    return @[@"",@"S", @"SK", @"SKA", @"SKAT", @"SKATE"];
    
}

-(NSString *)letterScore:(int)score
{
    return [[self lettersArray] objectAtIndex:score];
}

-(NSString *)playerOneLoses:(NSString *)playerTwoName theGame:(NSString *)playerThreeName
{
    NSString *alertMessage = nil;
    if (self.playerOneScore > 4)
    {
        if (self.playerTwoScore > 4)
        {
            alertMessage = [[NSString alloc] initWithFormat:@"Winner: %@\rScore: %@", playerThreeName, [self letterScore:self.playerThreeScore]];
        } else if (self.playerThreeScore > 4)
        {
            alertMessage = [[NSString alloc] initWithFormat:@"Winner: %@\rScore: %@", playerTwoName, [self letterScore:self.playerTwoScore]];
        }

    }
    return alertMessage;
}

-(NSString *)playerTwoLoses:(NSString *)playerOneName theGame:(NSString *)playerThreeName
{
    NSString *alertMessage = nil;
    if (self.playerTwoScore > 4)
    {
        if (self.playerOneScore > 4)
        {
            alertMessage = [[NSString alloc] initWithFormat:@"Winner: %@\rScore: %@", playerThreeName, [self letterScore:self.playerThreeScore]];
        } else if (self.playerThreeScore > 4)
        {
            alertMessage = [[NSString alloc] initWithFormat:@"Winner: %@\rScore: %@", playerOneName, [self letterScore:self.playerOneScore]];
        }
        
    }
    return alertMessage;
}

-(NSString *)playerThreeLoses:(NSString *)playerOneName theGame:(NSString *)playerTwoName
{
    NSString *alertMessage = nil;
    if (self.playerThreeScore > 4)
    {
        if (self.playerOneScore > 4)
        {
            alertMessage = [[NSString alloc] initWithFormat:@"Winner: %@\rScore: %@", playerTwoName, [self letterScore:self.playerTwoScore]];
        } else if (self.playerTwoScore > 4)
        {
            alertMessage = [[NSString alloc] initWithFormat:@"Winner: %@\rScore: %@", playerOneName, [self letterScore:self.playerOneScore]];
        }
        
    }
    return alertMessage;
}

-(void)givePlayerOneALetter
{
    self.playerOneScore++;
}

-(void)givePlayerTwoALetter
{
    self.playerTwoScore++;
}

-(void)givePlayerThreeALetter
{
    self.playerThreeScore++;
}

-(void)undoPlayerOneLetter
{
    self.playerOneScore--;
}

-(void)undoPlayerTwoLetter
{
    self.playerTwoScore--;
}

-(void)undoPlayerThreeLetter
{
    self.playerThreeScore--;
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

// Prevent player three from crashing the array
- (void)setPlayerThreeScore:(int)playerThreeScore
{
    if (playerThreeScore < 6 &&  playerThreeScore >= 0) {
        _playerThreeScore = playerThreeScore;
    }
}

-(void)resetGame
{
    self.playerOneScore = 0;
    self.playerTwoScore = 0;
    self.playerThreeScore = 0;
}

@end


