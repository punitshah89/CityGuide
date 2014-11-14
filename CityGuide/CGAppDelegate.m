//
//  CGAppDelegate.m
//  CityGuide
//
//  Created by Alasdair Allan on 16/10/2012.
//  Copyright (c) 2012 Babilim Light Industries. All rights reserved.
//
#include <sqlite3.h>
#import "CGAppDelegate.h"
#import "CGViewController.h"
#import "City.h"

@implementation CGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.cities = [[NSMutableArray alloc] init];
    NSString *filePath = [self copyDatabaseToDocuments];
    [self readCitiesFromDatabaseWithPath:filePath];
    
    
    self.viewController = [[CGViewController alloc] initWithNibName:@"CGViewController" bundle:nil];
    self.navController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];
    return YES;
}
- (NSString *)copyDatabaseToDocuments {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths =
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                        NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *filePath = [documentsPath
                          stringByAppendingPathComponent:@"cities.sqlite"];
    if ( ![fileManager fileExistsAtPath:filePath] ) {
        NSString *bundlePath = [[[NSBundle mainBundle] resourcePath]
                                stringByAppendingPathComponent:@"cities.sqlite"];
        [fileManager copyItemAtPath:bundlePath toPath:filePath error:nil];
    }
    return filePath;
}
-(void) readCitiesFromDatabaseWithPath:(NSString *)filePath {
    sqlite3 *database;
    if(sqlite3_open([filePath UTF8String], &database) == SQLITE_OK) {
        const char *sqlStatement = "select * from cities";
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(database, sqlStatement,
                              -1, &compiledStatement, NULL) == SQLITE_OK) {
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                NSString *cityName =
                [NSString stringWithUTF8String:(char *)
                 sqlite3_column_text(compiledStatement, 1)];
                NSString *cityDescription =
                [NSString stringWithUTF8String:(char *)
                 sqlite3_column_text(compiledStatement, 2)];
                NSData *cityData = [[NSData alloc]
                                    initWithBytes:sqlite3_column_blob(compiledStatement, 3)
                                    length: sqlite3_column_bytes(compiledStatement, 3)];
                UIImage *cityImage = [UIImage imageWithData:cityData];
                City *newCity = [[City alloc] init];
                newCity.cityName = cityName;
                newCity.cityDescription = cityDescription;
                newCity.cityPicture = (UIImage *)cityImage;
                [self.cities addObject:newCity];
            } }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
}
- (void)applicationWillResignActive:(UIApplication *)applicationm{

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {

}

@end
