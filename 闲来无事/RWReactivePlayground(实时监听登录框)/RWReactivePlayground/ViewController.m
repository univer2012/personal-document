//
//  ViewController.m
//  RWReactivePlayground
//
//  Created by huangaengoln on 15/9/27.
//  Copyright (c) 2015年 huangaengoln. All rights reserved.
//

#import "ViewController.h"
#import "RWDummySignInService.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UILabel *signInFailureText;

@property (nonatomic) BOOL passwordIsValid; //密码输入 是否 有效
@property (nonatomic) BOOL usernameIsValid; //用户输入 是否 有效

//@property (strong, nonatomic) RWDummySignInService *signInService;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateUIState];//更新 UI状态
    
//    self.signInService = [RWDummySignInService new];
    
    // handle text changes for both text fields
    [self.usernameTextField addTarget:self action:@selector(usernameTextFieldChanged) forControlEvents:UIControlEventEditingChanged];
    [self.passwordTextField addTarget:self action:@selector(passwordTextFieldChanged) forControlEvents:UIControlEventEditingChanged];
    
    // initially hide the failure message
    self.signInFailureText.hidden = YES;
    // Do any additional setup after loading the view, typically from a nib.
}

// sign In 按钮 点击 响应
- (IBAction)signInButtonTouched:(id)sender {
    
    self.signInButton.enabled = NO;
    self.signInFailureText.hidden = YES;
    
    // sign in
//    [self.signInService signInWithUsername:self.usernameTextField.text password:self.passwordTextField.text complete:^(BOOL success) {
//        self.signInButton.enabled = YES;
//        self.signInFailureText.hidden = success;
//        if (success) {
//            [self performSegueWithIdentifier:@"signInSuccess" sender:self];
//        }
//    }];
}
//更新 UI状态
- (void)updateUIState {
    self.usernameTextField.backgroundColor = self.usernameIsValid ? [UIColor clearColor] : [UIColor yellowColor];
    
    self.passwordTextField.backgroundColor = self.passwordIsValid ? [UIColor clearColor] : [UIColor yellowColor];
    
    self.signInButton.enabled = self.usernameIsValid && self.passwordIsValid;
}
//用户输入框 的 响应
- (void)usernameTextFieldChanged {
    //是否 有效 用户
    self.usernameIsValid = [self isValidUsername:self.usernameTextField.text];
    [self updateUIState];
}
//密码输入框 的 响应
- (void)passwordTextFieldChanged {
    //是否 有效 密码
    self.passwordIsValid = [self isValidPassword:self.passwordTextField.text];
    [self updateUIState];
}

//是否 有效 用户
- (BOOL)isValidUsername:(NSString *)username {
    return username.length > 3;
}
//是否 有效 密码
- (BOOL)isValidPassword:(NSString *)password {
    return password.length > 3;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
