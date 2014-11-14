//
//  CGViewController.h
//  CityGuide
//
//  Created by Alasdair Allan on 16/10/2012.
//  Copyright (c) 2012 Babilim Light Industries. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSMutableArray *cities;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
