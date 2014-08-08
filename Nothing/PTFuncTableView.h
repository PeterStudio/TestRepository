//
//  PTFuncTableView.h
//  Nothing
//
//  Created by dw on 14-8-8.
//  Copyright (c) 2014年 dw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PTFuncTableViewDelegate <NSObject>

@required
- (void)tableCellSelectedWithIndex:(NSIndexPath *)indexPath;

@end

@interface PTFuncTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign)id<PTFuncTableViewDelegate> funcDelegate;
@end
