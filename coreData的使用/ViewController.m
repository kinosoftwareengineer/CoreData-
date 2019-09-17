//
//  ViewController.m
//  coreData的使用
//
//  Created by kino on 2019/9/11.
//  Copyright © 2019 kino. All rights reserved.
//

#import "ViewController.h"
#import "MyTableViewCell.h"
#import <CoreData/CoreData.h>
#import "Drink+CoreDataClass.h"
#import "AppDelegate.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mytable;
@property (strong,nonatomic)NSMutableArray * dataSourse;
@property (strong,nonatomic)NSManagedObjectContext * context;
@property (copy,nonatomic)NSString * inputText;

@end

@implementation ViewController
-(NSManagedObjectContext *)context{
    if(!_context){
        AppDelegate * delegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
        _context=delegate.persistentContainer.viewContext;
    }
    return _context;
}
-(NSMutableArray *)dataSourse{
    if(!_dataSourse){
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Drink"];
        NSError * error=nil;
        NSArray *resArray = [self.context executeFetchRequest:request error:&error];
        _dataSourse=[NSMutableArray arrayWithArray:resArray];
    }
    return _dataSourse;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    tableView.rowHeight=109;
    tableView.separatorStyle=UITableViewCellSelectionStyleNone;
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourse.count;
}
-(MyTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"kinoCell"];
    if(cell==nil){
        NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"MyTableViewCell" owner:self options:nil];
        cell=array[0];
    }
    Drink * drink=self.dataSourse[indexPath.row];
    cell.name.text=drink.name;
    cell.price.text=drink.price;
    cell.count.text=drink.count;
    return cell;
    
}
- (IBAction)add:(UIButton *)sender {
    UIAlertController * inputTextField=[UIAlertController alertControllerWithTitle:@"输入框" message:@"请输入相关信息" preferredStyle:UIAlertControllerStyleAlert];
    
    [inputTextField addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder=@"请输入插入的饮料名字，价格，数量，中间用“逗号”隔开。";
        textField.delegate=self;
    }];
    
    UIAlertAction * post=[UIAlertAction actionWithTitle:@"提交" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self insertData];
    }];
    [inputTextField addAction:post];
    [self presentViewController:inputTextField animated:YES completion:^{
     
    }];
    
   
    
   
    
}
-(void)insertData{
     Drink * drink=[NSEntityDescription insertNewObjectForEntityForName:@"Drink" inManagedObjectContext:self.context];
    
    NSArray * array=[self.inputText componentsSeparatedByString:@","];
    drink.name=array[0];
    drink.price=array[1];
    drink.count=array[2];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Drink"];
    NSError * error=nil;
    NSArray *resArray = [self.context executeFetchRequest:request error:&error];
    if(error){
        NSLog(@"插入失败");
    }else{
        NSLog(@"插入成功");
    }
    
    self.dataSourse=[resArray mutableCopy];
    [self.mytable reloadData];
    if ([self.context save:&error]) {
        
    }else{
        NSLog(@"插入数据失败, %@", error);
    }
}

- (IBAction)dele:(UIButton *)sender {
    UIAlertController * inputTextField=[UIAlertController alertControllerWithTitle:@"输入框" message:@"请输入相关信息" preferredStyle:UIAlertControllerStyleAlert];
    
    [inputTextField addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder=@"请输入要删除的行号";
        textField.delegate=self;
    }];
    
    UIAlertAction * post=[UIAlertAction actionWithTitle:@"提交" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self deleData];
    }];
    [inputTextField addAction:post];
    [self presentViewController:inputTextField animated:YES completion:^{
        
    }];
}
-(void)deleData{
    
    NSFetchRequest * request=[NSFetchRequest fetchRequestWithEntityName:@"Drink"];
    
    NSError * error=nil;
    NSArray * array= [self.context executeFetchRequest:request error:&error];
    [self.context deleteObject:array[[self.inputText integerValue]]];
    
    NSFetchRequest *request1 = [NSFetchRequest fetchRequestWithEntityName:@"Drink"];
    NSArray *resArray = [self.context executeFetchRequest:request1 error:nil];
    self.dataSourse = [resArray mutableCopy];
    [self.mytable reloadData];
    
    NSError *error1 = nil;
    //保存--记住保存
    if ([self.context save:&error1]) {
      
    }else{
        NSLog(@"删除数据失败, %@", error1);
    }
    
}
- (IBAction)order:(UIButton *)sender {
    //yes代表升序
    NSSortDescriptor * sort=[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Drink"];
    NSArray *resArray = [self.context executeFetchRequest:request error:nil];
    request.sortDescriptors=@[sort];
    self.dataSourse = [resArray mutableCopy];
    [self.mytable reloadData];
    
}


- (IBAction)find:(UIButton *)sender {
}

- (IBAction)update:(UIButton *)sender {
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.inputText=[textField.text copy];
   
}



@end
