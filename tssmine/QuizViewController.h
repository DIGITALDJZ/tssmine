//
//  QuizViewController.h
//  TheSMUShop
//
//  Created by Bob Cao on 27/1/14.
//  Copyright (c) 2014 Bob Cao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuizViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong,nonatomic) PFFile *upper;
@property (strong,nonatomic) PFFile *under;
@property (strong,nonatomic) PFFile *bottom;

@end
