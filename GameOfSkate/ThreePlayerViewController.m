//
//  SecondViewController.m
//  GameOfSkate
//
//  Created by Woudini on 11/14/14.
//  Copyright (c) 2014 Hi Range. All rights reserved.
//

#import "ThreePlayerViewController.h"
#import "ThreePlayerGame.h"
@interface ThreePlayerViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *viewToInsertBackgroundImage;


// Temporary stores needed to adjust view and keyboard when changing device orientation
@property BOOL getFrameSize;
@property CGRect frameSizeRect;
@property CGRect playerOneTextFieldSizeRect;

// Game
@property (nonatomic, strong) ThreePlayerGame *game;

// Player Names
@property (strong, nonatomic) IBOutlet UITextField *playerOneName;
@property (strong, nonatomic) IBOutlet UITextField *playerTwoName;
@property (strong, nonatomic) IBOutlet UITextField *playerThreeName;

//Player One Letters
@property (strong, nonatomic) IBOutlet UILabel *playerOneS;
@property (strong, nonatomic) IBOutlet UILabel *playerOneK;
@property (strong, nonatomic) IBOutlet UILabel *playerOneA;
@property (strong, nonatomic) IBOutlet UILabel *playerOneT;
@property (strong, nonatomic) IBOutlet UILabel *playerOneE;

//Player Two Letters
@property (weak, nonatomic) IBOutlet UILabel *playerTwoS;
@property (weak, nonatomic) IBOutlet UILabel *playerTwoK;
@property (weak, nonatomic) IBOutlet UILabel *playerTwoA;
@property (weak, nonatomic) IBOutlet UILabel *playerTwoT;
@property (weak, nonatomic) IBOutlet UILabel *playerTwoE;

//Player Three Letters
@property (weak, nonatomic) IBOutlet UILabel *playerThreeS;
@property (weak, nonatomic) IBOutlet UILabel *playerThreeK;
@property (weak, nonatomic) IBOutlet UILabel *playerThreeA;
@property (weak, nonatomic) IBOutlet UILabel *playerThreeT;
@property (weak, nonatomic) IBOutlet UILabel *playerThreeE;
@end


@implementation ThreePlayerViewController

// Initialize game
-(ThreePlayerGame *)game
{
    if (!_game) _game = [[ThreePlayerGame alloc] init];
    return _game;
}

-(NSArray *)scoreLabelsPlayerOne
{
    return @[self.playerOneS, self.playerOneK, self.playerOneA, self.playerOneT, self.playerOneE];
}

-(NSArray *)scoreLabelsPlayerTwo
{
    return @[self.playerTwoS, self.playerTwoK, self.playerTwoA, self.playerTwoT, self.playerTwoE];
}

-(NSArray *)scoreLabelsPlayerThree
{
    return @[self.playerThreeS, self.playerThreeK, self.playerThreeA, self.playerThreeT, self.playerThreeE];
}

// Player one loses
- (void)playerOneLoses
{
    if ([self.game playerOneLoses:self.playerTwoName.text theGame:self.playerThreeName.text]) {
        UIAlertView *winner= [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                        message:[self.game playerOneLoses:self.playerTwoName.text theGame:self.playerThreeName.text]
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [winner show];
    }
    
}

// Player two loses
- (void)playerTwoLoses
{
    if ([self.game playerTwoLoses:self.playerOneName.text theGame:self.playerThreeName.text]) {
        UIAlertView *winner= [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                        message:[self.game playerTwoLoses:self.playerOneName.text theGame:self.playerThreeName.text]
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [winner show];
    }
    
}


// Player three loses
- (void)playerThreeLoses
{
    if ([self.game playerThreeLoses:self.playerOneName.text theGame:self.playerTwoName.text]) {
        UIAlertView *winner= [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                        message:[self.game playerThreeLoses:self.playerOneName.text theGame:self.playerTwoName.text]
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [winner show];
    }
    
}

// Let OK trigger resetting the game
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"OK"])
    {
        [self resetGame];
    }
}


// Set all scores to zero
- (void)resetGame
{
    [self.game resetGame];
    for (int i = 0; i < [[self scoreLabelsPlayerOne] count]; i++)
        [[self scoreLabelsPlayerOne][i] setAlpha:0.15];
    for (int i = 0; i < [[self scoreLabelsPlayerTwo] count]; i++)
        [[self scoreLabelsPlayerTwo][i] setAlpha:0.15];
    for (int i = 0; i < [[self scoreLabelsPlayerThree] count]; i++)
        [[self scoreLabelsPlayerThree][i] setAlpha:0.15];
}

// Update the score on player one
- (void)updatePlayerOne
{
    for (int i = 0; i < self.game.playerOneScore; i++)
        [[self scoreLabelsPlayerOne][i] setAlpha:1];
    [self playerOneLoses];
}

// Update the score on player two
- (void)updatePlayerTwo
{
    for (int i = 0; i < self.game.playerTwoScore; i++)
        [[self scoreLabelsPlayerTwo][i] setAlpha:1];
    [self playerTwoLoses];
}

// Update the score on player three
- (void)updatePlayerThree
{
    for (int i = 0; i < self.game.playerThreeScore; i++)
        [[self scoreLabelsPlayerThree][i] setAlpha:1];
    [self playerThreeLoses];
}

// Give player one a letter
- (IBAction)givePlayerOneLetterButton:(UIButton *)sender {
    [self.game givePlayerOneALetter];
    [self updatePlayerOne];
    
}

// Give player two a letter
- (IBAction)givePlayerTwoLetterButton:(UIButton *)sender {
    [self.game givePlayerTwoALetter];
    [self updatePlayerTwo];
}

// Give player three a letter
- (IBAction)givePlayerThreeLetterButton:(UIButton *)sender
{
    [self.game givePlayerThreeALetter];
    [self updatePlayerThree];
}

// Remove one letter from player one
- (IBAction)UndoPlayerOneLetter:(UIButton *)sender {
    [self.game undoPlayerOneLetter];
    [[self scoreLabelsPlayerOne][self.game.playerOneScore] setAlpha:0.15];
}
// Remove one letter from player two
- (IBAction)UndoPlayerTwoLetter:(UIButton *)sender {
    [self.game undoPlayerTwoLetter];
    [[self scoreLabelsPlayerTwo][self.game.playerTwoScore] setAlpha:0.15];
}

// Remove one letter from player three
- (IBAction)UndoPlayerThreeLetter:(UIButton *)sender {
    [self.game undoPlayerThreeLetter];
    [[self scoreLabelsPlayerThree][self.game.playerThreeScore] setAlpha:0.15];
}

-(CGRect)getLargestSize
{
    int tabBarHeight = self.tabBarController.tabBar.frame.size.height*3.5;
    CGRect largestSize = CGRectMake(0, 0-tabBarHeight, (self.view.frame.size.height > self.view.frame.size.width) ? self.view.frame.size.height+tabBarHeight : self.view.frame.size.width+tabBarHeight, (self.view.frame.size.height > self.view.frame.size.width) ? self.view.frame.size.height+tabBarHeight : self.view.frame.size.width+tabBarHeight);
    return largestSize;
}

-(void)loadBackground
{
    UIImage *backgroundImage = [UIImage imageNamed:@"Concrete.jpg"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:[self getLargestSize]];
    backgroundImageView.image=backgroundImage;
    [self.viewToInsertBackgroundImage insertSubview:backgroundImageView atIndex:0];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBackground];
    [self disableScrollView];
    [self registerForKeyboardNotifications];
    // Tap to make keyboard disappear
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapReceived:)];
    [tapGestureRecognizer setDelegate:self];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetFrameAndCheckOrientationForScrolling) name:UIDeviceOrientationDidChangeNotification object:nil];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self checkOrientationForScrolling];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

#pragma mark keyboard/scrollview

-(void)resetFrameAndCheckOrientationForScrolling
{
    self.getFrameSize = NO;
    [self checkOrientationForScrolling];
}

-(void)checkOrientationForScrolling
{
    if (!self.getFrameSize)
    {
        self.frameSizeRect = self.view.frame;
        self.playerOneTextFieldSizeRect = self.playerOneName.frame;
    }
    if (!CGRectContainsPoint(self.frameSizeRect, self.playerOneTextFieldSizeRect.origin) && [self isInLandscapeOrientation])
    {
        NSLog(@"Enabling scrollview because out of bounds");
        [self enableScrollView];
        self.view.frame = CGRectMake(0,0,self.frameSizeRect.size.width,self.frameSizeRect.size.height+self.tabBarController.tabBar.frame.size.height*2.5);
        [self.scrollView setContentInset:UIEdgeInsetsMake(0, 0, self.tabBarController.tabBar.frame.size.height*2.5, 0)];
        self.getFrameSize = YES;
    }
    else
    {   NSLog(@"Disabling scrollview because in bounds");
        [self.scrollView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        [self disableScrollView];
    }
}

- (BOOL)isInLandscapeOrientation
{
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft || [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

-(void)tapReceived:(UITapGestureRecognizer *)tapGestureRecognizer
{
    NSLog(@"TAP RECEIVED");
    if ([self.playerTwoName isFirstResponder])
    {
        [self.playerTwoName resignFirstResponder];
    }
    else if ([self.playerOneName isFirstResponder])
    {
        [self.playerOneName resignFirstResponder];
    }
    else
    {
        [self.playerThreeName resignFirstResponder];
    }
    
}

-(void)scrollToShowTextField:(UITextField *)textField withNotification:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    CGRect aRect = self.view.frame;
    NSLog(@"self.view.frame is %@", NSStringFromCGRect(aRect));
    aRect.size.height -= kbSize.height;
    
    CGRect movedPlayerName = [self getSizeOfTextField:textField];
    NSLog(@"Movedplayername is %@", NSStringFromCGRect(movedPlayerName));
    if (!CGRectContainsPoint(aRect, movedPlayerName.origin) ) {
        NSLog(@"scrolling to visible");
        [self.scrollView scrollRectToVisible:movedPlayerName animated:YES];
    }
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    // Enable scrolling
    [self enableScrollView];
    
    NSLog(@"calling keyboardwasshown");
    
    if ([self.playerThreeName isFirstResponder])
    {
        [self scrollToShowTextField:self.playerThreeName withNotification:aNotification];
    }
    else if ([self.playerTwoName isFirstResponder])
    {
        [self scrollToShowTextField:self.playerTwoName withNotification:aNotification];
    }
    else
    {
        [self scrollToShowTextField:self.playerOneName withNotification:aNotification];
    }
}

-(CGRect)getSizeOfTextField:(UITextField *)textField
{
    return CGRectMake(textField.frame.origin.x, textField.frame.origin.y+self.tabBarController.tabBar.frame.size.height*2.5, textField.frame.size.width, textField.frame.size.height);
}

// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}


// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [self checkOrientationForScrolling];
}

-(void)enableScrollView
{
    self.scrollView.scrollEnabled = YES;
}

-(void)disableScrollView
{
    self.scrollView.scrollEnabled = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
