//
//  AddCityController.m
//  CityGuide
//
//  Created by Alasdair Allan on 16/10/2012.
//  Copyright (c) 2012 Babilim Light Industries. All rights reserved.
//
#include <sqlite3.h>
#import "AddCityController.h"
#import "CGAppDelegate.h" 
#import "CGViewController.h" 
#import "City.h"

@interface AddCityController ()

@end

@implementation AddCityController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"New City";
    cityPicture = [UIImage imageNamed:@"QuestionMark.jpg"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveCity:)];

    pickerController = [[UIImagePickerController alloc] init];
    pickerController.allowsEditing = NO;
    pickerController.delegate = self;
    pickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)saveCity:(id)sender {
    CGAppDelegate *delegate = (CGAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableArray *cities = delegate.cities;
    UITextField *nameEntry = (UITextField *)[nameCell viewWithTag:777];
    UITextView *descriptionEntry = (UITextView *)[descriptionCell viewWithTag:777];
    if ( nameEntry.text.length > 0 ) {
        City *newCity = [[City alloc] init];
        newCity.cityName = nameEntry.text;
        newCity.cityDescription = descriptionEntry.text;
        newCity.cityPicture = nil;
        newCity.cityPicture = cityPicture;
        [cities addObject:newCity];
        [self addCityToDatabase:newCity];
        CGViewController *viewController = delegate.viewController;
        [viewController.tableView reloadData];
    }
    [delegate.navController popViewControllerAnimated:YES];
}

- (IBAction)addPicture:(id)sender {
    UITextField *nameEntry = (UITextField *)[nameCell viewWithTag:777];
    [nameEntry resignFirstResponder];
    
    [self presentViewController:pickerController animated:YES completion:nil];
}
-(void) addCityToDatabase:(City *)newCity {
    NSArray *paths =
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                        NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *filePath =
    [documentsPath stringByAppendingPathComponent:@"cities.sqlite"];
    sqlite3 *database;
    if(sqlite3_open([filePath UTF8String], &database) == SQLITE_OK) {
        const char *sqlStatement =
        "insert into cities (name, description, image) VALUES (?, ?, ?)";
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(database, sqlStatement,
                              -1, &compiledStatement, NULL) == SQLITE_OK)
        {
            sqlite3_bind_text(compiledStatement, 1,
                              [newCity.cityName UTF8String], -1,
                              SQLITE_TRANSIENT);
            sqlite3_bind_text(compiledStatement, 2,
                              [newCity.cityDescription UTF8String], -1,
                              SQLITE_TRANSIENT);
            NSData *dataForPicture =
            UIImagePNGRepresentation(newCity.cityPicture);
            sqlite3_bind_blob(compiledStatement, 3,
                              [dataForPicture bytes],
                              [dataForPicture length],
                              SQLITE_TRANSIENT);
        }
        if(sqlite3_step(compiledStatement) == SQLITE_DONE) {
            sqlite3_finalize(compiledStatement);
        }
    }
    sqlite3_close(database);
}
#pragma mark UITableViewDataSource Methods

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if( indexPath.row == 0 ) {
        cell = nameCell;
    } else if ( indexPath.row == 1 ) {
        UIImageView *pictureView = (UIImageView *)[pictureCell viewWithTag:777];
        pictureView.image = cityPicture;
        cell = pictureCell;
    } else {
        cell = descriptionCell;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
    return 3;
}

#pragma mark UITableViewDelegate Methods

- (CGFloat)tableView:(UITableView *)tv heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height;
    if( indexPath.row == 0 ) {
        height = 44;
    } else if( indexPath.row == 1 ) {
        height = 83;
    } else {
        height = 440;
    }
    return height;
}

#pragma mark UIImagePickerController Methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
    cityPicture = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    UIImageView *pictureView = (UIImageView *)[pictureCell viewWithTag:777]; pictureView.image = cityPicture;
    [tableView reloadData];
}

@end
