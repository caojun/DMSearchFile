//
//  ViewController.m
//  DMSearchFileDemo
//
//  Created by Dream on 15/6/21.
//  Copyright (c) 2015年 GoSing. All rights reserved.
//

#import "ViewController.h"
#import "DMSearchFile.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, DMSearchFileDelegate>
@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (nonatomic, strong) NSString *filePath;

@property (nonatomic, strong) NSArray *m_dataArray;

@end

@implementation ViewController

- (void)createTempFile
{
    for (int i=0; i<30; i++)
    {
        NSString *name = [@(arc4random()) description];
        NSString *file = [self.filePath stringByAppendingPathComponent:name];
        
        [[NSFileManager defaultManager] createFileAtPath:file contents:nil attributes:nil];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self createTempFile];
}

- (void)searchFile
{
    NSArray *fileArray = [DMSearchFile searchFile:self.filePath ext:nil delegate:self];
    
    self.m_dataArray = fileArray;
    
    [self.m_tableView reloadData];
}

#pragma mark - DMSearchFileDelegate
/**
 *  过滤方法
 *
 *  @param path 文件路径
 *
 *  @return YES - 过滤, NO - 不过滤
 */
- (BOOL)filterFile:(NSString *)path
{
    if ([path hasPrefix:@"1"])
    {
        return YES;
    }
    
    return NO;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.m_dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    cell.textLabel.text = self.m_dataArray[indexPath.row];
    
    return cell;
}

#pragma mark - Event
- (IBAction)btnSearchClick:(UIBarButtonItem *)sender
{
    [self searchFile];
}


#pragma mark - setter / getter

- (NSString *)filePath
{
    if (nil == _filePath)
    {
        _filePath = NSTemporaryDirectory();
    }
    
    return _filePath;
}

@end
