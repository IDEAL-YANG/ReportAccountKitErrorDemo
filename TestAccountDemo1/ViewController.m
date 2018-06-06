//
//  ViewController.m
//  TestAccountDemo1
//
//  Created by IDEAL YANG on 2018/5/28.
//  Copyright © 2018年 IDEAL YANG. All rights reserved.
//

#import "ViewController.h"
#import "MyUIManager.h"
#import "AdvancedUIManager.h"

#import <AccountKit/AccountKit.h>

@interface ViewController () <AKFViewControllerDelegate>{
    AKFAccountKit *_accountKit;
    UIViewController<AKFViewController> *_pendingLoginViewController;
    NSString *_authorizationCode;
}
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountIDLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *advanceBtn;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // initialize Account Kit
    if (_accountKit == nil) {
        // may also specify AKFResponseTypeAccessToken
        _accountKit = [[AKFAccountKit alloc] initWithResponseType:AKFResponseTypeAccessToken];
    }
    
    // view controller for resuming login
    _pendingLoginViewController = [_accountKit viewControllerForLoginResume];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([_accountKit currentAccessToken]) {
        // if the user is already logged in, go to the main screen
        [self proceedToMainScreen];
    } else if (_pendingLoginViewController != nil) {
        [self _prepareLoginViewController:_pendingLoginViewController custom:false];
        [self presentViewController:_pendingLoginViewController animated:animated completion:NULL];
        _pendingLoginViewController = nil;
    } else {
        // Show the login screen
        [self showLoginControls];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)proceedToMainScreen{
    self.advanceBtn.hidden = self.loginBtn.hidden = true;
    
    [_accountKit requestAccount:^(id<AKFAccount> account, NSError *error) {
        // account ID
        self.accountIDLabel.text = account.accountID;
        if ([account.emailAddress length] > 0) {
            self.titleLabel.text = @"Email Address";
            self.valueLabel.text = account.emailAddress;
        }
        else if ([account phoneNumber] != nil) {
            self.titleLabel.text = @"Phone Number";
            self.valueLabel.text = [[account phoneNumber] stringRepresentation];
        }
    }];
}

- (void)showLoginControls{
    self.advanceBtn.hidden = self.loginBtn.hidden = false;
}
- (IBAction)clickLoginSMS:(id)sender {
    [self loginWithPhone:sender];
}
- (IBAction)clickAdvancedUI:(id)sender {
    [self loginWithPhone:sender];
}

#pragma mark -

- (void)_prepareLoginViewController:(UIViewController<AKFViewController> *)loginViewController custom:(BOOL)custom
{
    loginViewController.delegate = self;
    // Optionally, you may set up backup verification methods.
    loginViewController.enableSendToFacebook = YES;
    loginViewController.enableGetACall = YES;
//        loginViewController.uiManager = [[AKFSkinManager alloc] initWithSkinType:AKFSkinTypeClassic];
    if (custom) {
        loginViewController.uiManager = [[MyUIManager alloc] init];
    }else {
        loginViewController.uiManager = [[AdvancedUIManager alloc] initWithConfirmButtonType:AKFButtonTypeOK entryButtonType:AKFButtonTypeNext loginType:AKFLoginTypePhone textPosition:AKFTextPositionBelowBody];
    }
}

- (void)loginWithPhone:(id)sender
{
    NSString *preFillPhoneNumber = @"18238833039";
    NSString *inputState = [[NSUUID UUID] UUIDString];
    AKFPhoneNumber *number = [[AKFPhoneNumber alloc] initWithCountryCode:@"+86" phoneNumber:preFillPhoneNumber];
    UIViewController<AKFViewController> *viewController =
    [_accountKit viewControllerForPhoneLoginWithPhoneNumber:number state:inputState];
    [self _prepareLoginViewController:viewController custom:[(UIButton*)sender tag]]; // see above
    [self presentViewController:viewController animated:YES completion:NULL];
}

#pragma mark -


// handle callback on successful login to show authorization code
- (void)viewController:(UIViewController<AKFViewController> *)viewController
didCompleteLoginWithAuthorizationCode:(NSString *)code
                 state:(NSString *)state
{
    // Pass the code to your own server and have your server exchange it for a user access token.
    // You should wait until you receive a response from your server before proceeding to the main screen.
    //    [self sendAuthorizationCodeToServer:code];
    [self proceedToMainScreen];
}


- (void)viewController:(UIViewController<AKFViewController> *)viewController
      didFailWithError:(NSError *)error
{
    // ... implement appropriate error handling ...
    NSLog(@"%@ did fail with error: %@", viewController, error);
}


- (void)viewControllerDidCancel:(UIViewController<AKFViewController> *)viewController
{
    // ... handle user cancellation of the login process ...
}

@end
