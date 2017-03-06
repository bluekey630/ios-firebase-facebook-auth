//
//  ViewController.m
//  firebaseTest
//
//  Created by Admin on 2/23/17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "ViewController.h"
@import Firebase;
#import "UtilManager.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginFBButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in, do work such as go to next view controller.
    }
    
    //self.loginFBButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    //self.loginFBButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)tappedLogin:(id)sender {
    
    NSString* email = self.txtEmail.text;
    if (!email || [email stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length < 1)
    {
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Error"
                                      message:@"Email address should not be empty."
                                      preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [self.txtEmail becomeFirstResponder];
                             }];
        [alert addAction:ok];

//        [[AlertManager sharedManager] showAlertWithTitle:@"Error" message:@"Email address should not be empty." parentVC:self okHandler:^{
//            [self.emailField becomeFirstResponder];
//        }];
        return;
    }
    
    if (![UtilManager validateEmail:email]) {
        [self.txtEmail becomeFirstResponder];
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Error"
                                      message:@"Email address is not valid."
                                      preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [self.txtEmail becomeFirstResponder];
                             }];
        [alert addAction:ok];
        
//        [[AlertManager sharedManager] showAlertWithTitle:@"Error" message:@"Email address is not valid." parentVC:self okHandler:^{
//            [self.emailField becomeFirstResponder];
//        }];
        return;
    }
    
    NSString* password = self.txtPassword.text;
    if (!password || [password stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length < 1) {
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Error"
                                      message:@"Password should not be empty."
                                      preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [self.txtPassword becomeFirstResponder];
                             }];
        [alert addAction:ok];
//        [[AlertManager sharedManager] showAlertWithTitle:@"Error" message:@"Password should not be empty." parentVC:self okHandler:^{
//            [self.passwordField becomeFirstResponder];
//        }];
        return;
    }
    
    [[FIRAuth auth] signInWithEmail:self.txtEmail.text
     password:self.txtPassword.text
     completion:^(FIRUser *_Nullable user,
                  NSError *_Nullable error) {
         if (error == nil) {
             
         } else {
             NSDictionary *detailError = error.userInfo;
             UIAlertController * alert=   [UIAlertController
                                           alertControllerWithTitle:@"Error"
                                           message:detailError[@"NSLocalizedDescription"]
                                           preferredStyle:UIAlertControllerStyleAlert];
             [self presentViewController:alert animated:YES completion:nil];
             
             UIAlertAction* ok = [UIAlertAction
                                  actionWithTitle:@"OK"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action)
                                  {
                                      [self.txtEmail becomeFirstResponder];
                                  }];
             [alert addAction:ok];
             //error.description;
         }
         
     }];
}



- (IBAction)tappedSignup:(id)sender {
    
    NSString* email = self.txtEmail.text;
    if (!email || [email stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length < 1)
    {
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Error"
                                      message:@"Email address should not be empty."
                                      preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [self.txtEmail becomeFirstResponder];
                             }];
        [alert addAction:ok];
        
        //        [[AlertManager sharedManager] showAlertWithTitle:@"Error" message:@"Email address should not be empty." parentVC:self okHandler:^{
        //            [self.emailField becomeFirstResponder];
        //        }];
        return;
    }
    
    if (![UtilManager validateEmail:email]) {
        [self.txtEmail becomeFirstResponder];
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Error"
                                      message:@"Email address is not valid."
                                      preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [self.txtEmail becomeFirstResponder];
                             }];
        [alert addAction:ok];
        
        //        [[AlertManager sharedManager] showAlertWithTitle:@"Error" message:@"Email address is not valid." parentVC:self okHandler:^{
        //            [self.emailField becomeFirstResponder];
        //        }];
        return;
    }
    
    NSString* password = self.txtPassword.text;
    if (!password || [password stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length < 1) {
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Error"
                                      message:@"Password should not be empty."
                                      preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [self.txtPassword becomeFirstResponder];
                             }];
        [alert addAction:ok];
        //        [[AlertManager sharedManager] showAlertWithTitle:@"Error" message:@"Password should not be empty." parentVC:self okHandler:^{
        //            [self.passwordField becomeFirstResponder];
        //        }];
        return;
    }
    
    [[FIRAuth auth] createUserWithEmail:self.txtEmail.text
                               password:self.txtPassword.text
                             completion:^(FIRUser *_Nullable user,
                                          NSError *_Nullable error) {
                                 if (error == nil) {
                                     
                                 } else {
                                     NSDictionary *detailError = error.userInfo;
                                     UIAlertController * alert=   [UIAlertController
                                                                   alertControllerWithTitle:@"Error"
                                                                   message:detailError[@"NSLocalizedDescription"]
                                                                   preferredStyle:UIAlertControllerStyleAlert];
                                     [self presentViewController:alert animated:YES completion:nil];
                                     
                                     UIAlertAction* ok = [UIAlertAction
                                                          actionWithTitle:@"OK"
                                                          style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action)
                                                          {
                                                              [self.txtEmail becomeFirstResponder];
                                                          }];
                                     [alert addAction:ok];
                                     //error.description;
                                 }
                                 
                             }];

}


- (IBAction)tappedFacebookLogin:(FBSDKLoginButton *)sender {
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    
    [login logInWithReadPermissions: @[@"public_profile",@"",@"user_likes",@"user_birthday"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in:%@", result);
             if ([FBSDKAccessToken currentAccessToken]) {
                 
                 
                 [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"picture,email,birthday,gender,name"}] startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id res, NSError *error)
                  {
                      if (!error) {
                          
                          
                          NSString* user_id = res[@"id"];
                          NSString* email = res[@"email"];
                          NSString* gender = res[@"gender"];
                          NSString* user_name = res[@"name"];
                          NSString* birthday = res[@"birthday"];
                          
                      }
                      else
                      {
                          NSLog(@"%@", [error localizedDescription]);
                      }}];
             }
             
         }
     }];
    
}

@end
