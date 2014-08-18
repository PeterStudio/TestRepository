//
//  PTMapViewController.h
//  Nothing
//
//  Created by dw on 14-8-8.
//  Copyright (c) 2014年 dw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTFuncTableView.h"

@interface PTMapViewController : UIViewController<PTFuncTableViewDelegate,QuadCurveMenuDelegate>{
    BOOL isRightBtnSelected;
    BOOL isFirstLocation;
    
}

@end
