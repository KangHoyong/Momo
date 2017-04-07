//
//  MainViewController.m
//  Momo
//
//  Created by Jeheon Choi on 2017. 3. 27..
//  Copyright © 2017년 JeheonChoi. All rights reserved.
//

#import "MainViewController.h"
#import "MainTabBarController.h"

@interface MainViewController ()

@end


@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"Main View"];
    
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [GoogleAnalyticsModule startGoogleAnalyticsTrackingWithScreenName:@"MainViewController"];
    
    NSLog(@"MainViewController : viewWillAppear");

}

- (IBAction)logoutTempBtnAction:(id)sender {
    
    [NetworkModule logOutRequestWithCompletionBlock:^(BOOL isSuccess, NSDictionary *result) {
        if (isSuccess) {
            UIStoryboard *loginStoryboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
            UIViewController *loginController = [loginStoryboard instantiateInitialViewController];
            
            [[UIApplication sharedApplication].keyWindow setRootViewController:loginController];
            [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
        }
    }];
}




@end


