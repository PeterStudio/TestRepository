//
//  PTFuncTableView.m
//  Nothing
//
//  Created by dw on 14-8-8.
//  Copyright (c) 2014年 dw. All rights reserved.
//

#import "PTFuncTableView.h"

@implementation PTFuncTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.delegate   = self;
        self.dataSource = self;
        [self setBackgroundColor:[UIColor clearColor]];
        [self steup];
    }
    return self;
}

- (void)steup{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier = @"CellIndentifer";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    [cell.textLabel setText:[NSString stringWithFormat:@"index:%d",indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.funcDelegate respondsToSelector:@selector(tableCellSelectedWithIndex:)]) {
        [self.funcDelegate tableCellSelectedWithIndex:indexPath];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
