//
//  ProductListViewController.m
//  mySMU
//
//  Created by Bob Cao on 9/3/14.
//  Copyright (c) 2014 Bob Cao. All rights reserved.
//

#import "ProductListViewController.h"
#import "MYSMUConstants.h"
#import "TSSProduct.h"
#import "TSSProductCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ProductViewController.h"

@interface ProductListViewController ()

@property (strong, nonatomic) IBOutlet UITableView *prListTableView;
@property NSMutableArray *products;


@end

@implementation ProductListViewController

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
    [self getProducts];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(shoppingCart:)];
    self.navigationItem.title = @"The SMU Shop";
}

- (void)getProducts{
    NSLog(@"get all products");
    
    self.products = [[NSMutableArray alloc] init];
    
    //implement this if the json is huge
    //[NSThread detachNewThreadSelector:@selector(loadData) toTarget:self withObject:nil];
    
    NSString *urlString = [NSString stringWithFormat:@"%@index.php?route=%@&key=%@&category=%@",ShopDomain,@"feed/web_api/products",RESTfulKey,self.category.categoryID,nil];
    NSLog(urlString);
    //NSLog(@"and the calling url is .. %@",urlString);
    NSURL *productsURL = [NSURL URLWithString:urlString];
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:productsURL] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            NSLog(@"fetching products data failed");
        } else {
            NSLog(@"start fetching products data");
            NSError *localError = nil;
            id parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
            
            if([parsedObject isKindOfClass:[NSDictionary class]])
            {
                NSDictionary *results = parsedObject;
                //construct objects and pass to array
                NSLog(@"products is dict");
                for (NSObject *ob in [results valueForKey:@"products"]){
                    TSSProduct *pr = [[TSSProduct alloc] init];
                    pr.productID = [ob valueForKey:@"id"];
                    NSLog(@"product ID is %@", [ob valueForKey:@"id"]);
                    
                    pr.name = [ob valueForKey:@"name"];
                    NSLog(@"product Name is %@", [ob valueForKey:@"name"]);
                    
                    pr.thumbURL = [NSURL URLWithString:[ob valueForKey:@"thumb"]];
                    [self.products addObject:pr];
                    
                    pr.price = [ob valueForKey:@"pirce"];
                    
                    NSLog(@"and the products count is %lu",self.products.count);
                }
                NSLog(@"there are %lu number of item in %@ category",self.products.count,self.category.name);
            } else {
                NSLog(@"what we get is not a kind of clss nsdictionary class");
            }
        }
        NSLog(@"reload products data");
        [self.prListTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }];
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
    NSLog(@"products list view number of rows in section called");
    NSLog(@"%lu",self.products.count);
    return self.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"products list view cell for index called");
    
    static NSString *CellIdentifier = @"pProductCell";
    TSSProductCell *cell = (TSSProductCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSLog(@"there are %lu numbers of items wehen cellforindex is called", self.products.count);
    TSSProduct *pr = self.products[indexPath.row];
    
    [cell.pThumb setImageWithURL:pr.thumbURL];
    cell.pTitle.text =pr.name;
    cell.pPrice.text = [NSString stringWithFormat:@"SGD %@", pr.price];
    
    NSLog(@"and the name is %@",pr.name);
    NSLog(@"and the name is %@",pr.price);
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TSSProduct *product = self.products[indexPath.row];
    
    ProductViewController *pVC = [self.storyboard instantiateViewControllerWithIdentifier:@"productDetailView"];
    
    pVC.product = product;
    
    [self.navigationController pushViewController:pVC animated:YES];
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
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end