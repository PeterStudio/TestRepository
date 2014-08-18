//
//  PTWelcomeViewController.m
//  Nothing
//
//  Created by dw on 14-8-8.
//  Copyright (c) 2014年 dw. All rights reserved.
//

#import "PTWelcomeViewController.h"

@interface PTWelcomeViewController ()

@end

@implementation PTWelcomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    [lab setBackgroundColor:[UIColor clearColor]];
    [lab setText:@"云中央"];
    [lab setTextAlignment:NSTextAlignmentCenter];
    [lab setFont:[UIFont systemFontOfSize:30]];
    [lab setTextColor:[UIColor greenColor]];
    lab.alpha = 0;
    [lab setCenter:CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2)];
    [self.view addSubview:lab];
    
    
    [UIView animateWithDuration:3.75 delay:0.1 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        [lab setAlpha:1];
    } completion:^(BOOL finished){
        // remove lab
//        [lab removeFromSuperview];
        
        
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
