//
//  SnapTakePhotoViewController.h
//  tssmine
//
//  Created by Bob Cao on 6/1/14.
//  Copyright (c) 2014 Bob Cao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SnapTakePhotoViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UINavigationBar *postSnapNavBar;

- (void)setSnapImage:(UIImage *)aImage;
@end
