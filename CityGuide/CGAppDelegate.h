//
//  CGAppDelegate.h
//  CityGuide
//
//  Created by Alasdair Allan on 16/10/2012.
//  Copyright (c) 2012 Babilim Light Industries. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CGViewController;

@interface CGAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CGViewController *viewController;
@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) NSMutableArray *cities;
-(NSString *)copyDatabaseToDocuments;
-(void) readCitiesFromDatabaseWithPath:(NSString *)filePath;

@end
