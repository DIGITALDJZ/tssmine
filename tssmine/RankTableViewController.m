//
//  RankTableViewController.m
//  mySMUShop
//
//  Created by Bob Cao on 17/3/14.
//  Copyright (c) 2014 Bob Cao. All rights reserved.
//

#import "RankTableViewController.h"
#import "FilterCenter.h"

@interface RankTableViewController ()

@property (strong, nonatomic) FilterCenter *sharedCenter;

@end

@implementation RankTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.sharedCenter = [FilterCenter sharedCenter];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.title = @"Ranking";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rankCell" forIndexPath:indexPath];
    
    // Configure the cell...
    switch (indexPath.row)
    {
        case 0:
            [cell.textLabel setText:@"Trending Now"];
            break;
        case 1:
            [cell.textLabel setText:@"Most Recent"];
            break;
    }
    if (indexPath.row == self.sharedCenter.buzzFilter) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    if (selectedCell.accessoryType == UITableViewCellAccessoryNone){
        selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.sharedCenter.buzzFilter = indexPath.row;
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"changeRanking" object:nil]];
    }
    //Do something
   
    [self.navigationController popViewControllerAnimated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
