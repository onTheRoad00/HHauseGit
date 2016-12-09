//
//  RCInfoViewController.m
//  HHause
//
//  Created by HHause on 16/5/12.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCInfoViewController.h"
#import "RCInfo1TableViewCell.h"
#import "RCInfo2TableViewCell.h"
#import "ZLPhoto.h"
#import "RCNameViewController.h"
#import "RCPassWordViewController.h"
@interface RCInfoViewController ()<UITableViewDataSource,UITableViewDelegate,ZLPhotoPickerBrowserViewControllerDataSource,ZLPhotoPickerBrowserViewControllerDelegate,UIActionSheetDelegate,ZLPhotoPickerBrowserPhotoViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RCInfoViewController
{
    UIImage * _headimage;
    NSString * _name;
    NSString * _phoneNum;
    NSArray * _infoTypeTry;
    NSUserDefaults * ud;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"个人信息";

    UIBarButtonItem * rightButton =[[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(selectRightAction:)];
     self.navigationItem.rightBarButtonItem = rightButton;
    _infoTypeTry =@[@"头像",@"昵称",@"手机号",@"修改密码"];
    _tableView.delegate=self;
    _tableView.dataSource=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
//保存
-(void)selectRightAction:(id)sender
{
    //-------------------
    ud =[NSUserDefaults standardUserDefaults];
     UIImageView * imageview=(UIImageView *)[self.view viewWithTag:3];
    NSData * imageData = UIImageJPEGRepresentation(imageview.image, 0.5);
    [ud setObject:imageData forKey:@"headImage"];
}
#pragma mark-----------tableview--------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        _tableView.rowHeight=77;
        UINib * PerInfoNib1=[UINib nibWithNibName:@"RCInfo1TableViewCell" bundle:nil];
        [_tableView registerNib:PerInfoNib1 forCellReuseIdentifier:@"RCInfo1TableViewCell"];
        RCInfo1TableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"RCInfo1TableViewCell" forIndexPath:indexPath];
//        [cell.headImage sd_setImageWithURL:[NSURL URLWithString:] placeholderImage:[UIImage imageNamed:@"icon29@2x"]];
        return cell;
    }
    _tableView.rowHeight=55;
    UINib * PerInfoNib2=[UINib nibWithNibName:@"RCInfo2TableViewCell" bundle:nil];
    [_tableView registerNib:PerInfoNib2 forCellReuseIdentifier:@"RCInfo2TableViewCell"];
    RCInfo2TableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"RCInfo2TableViewCell" forIndexPath:indexPath];
    
    cell.tishiLab.text=_infoTypeTry[indexPath.row];
    if (indexPath.row==1) {
         cell.contentLab.text=_name;
    }
    else if(indexPath.row==2){
        cell.contentLab.text=_phoneNum;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
       //头像
        [self photograph];
    }
    else if(indexPath.row==1)
    {  //昵称
        RCNameViewController * name =[[RCNameViewController alloc]init];
        name.title=@"昵称";
        [self.navigationController pushViewController:name animated:YES];
    }
    else if(indexPath.row==2)
    { //手机号
        
    }
    else{
        //修改密码
        RCPassWordViewController * password = [[RCPassWordViewController alloc]init];
        password.title=@"修改密码";
        [self.navigationController pushViewController:password animated:YES];
    }
}
#pragma mark----------头像--------
-(void)photograph{
    UIAlertController * myActionSheet =[UIAlertController alertControllerWithTitle:@"头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * okAction =[UIAlertAction actionWithTitle:@"取消" style:1 handler:^(UIAlertAction *action) {
        
    }];
    [myActionSheet addAction:okAction];
    
    UIAlertAction * openCamera =[UIAlertAction actionWithTitle:@"打开相机" style:0 handler:^(UIAlertAction *action) {
        [self openCamera];
    }];
    [myActionSheet addAction:openCamera];
    
    UIAlertAction * openLocalPhoto =[UIAlertAction actionWithTitle:@"从相册获取照片" style:0 handler:^(UIAlertAction *action) {
        [self openLocal:@"photo"];
    }];
    [myActionSheet addAction:openLocalPhoto];
    
    //以模态方式推出警告框
    [self presentViewController:myActionSheet animated:YES completion:nil];

}
- (void)openCamera{
    ZLCameraViewController *cameraVc = [[ZLCameraViewController alloc] init];
    // 拍照最多个数
    // 最多能选1张图片
    cameraVc.maxCount = 1;
    
//    __weak typeof(self) weakSelf = self;
//    取消，无照片
    cameraVc.cancelback=^(NSArray *cameras)
    {
    };
#warning 有问题
    //有照片
    cameraVc.callback = ^(NSArray *cameras){
//        NSLog(@"%@",cameras);
        [self photoClass:cameras];
    };
    [cameraVc showPickerVc:self];
}

- (void)openLocal:(NSString  * )style
{
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    
    ZLPhotoPickerGroupViewController * group=[[ZLPhotoPickerGroupViewController alloc]init];
    // 最多能选1张图片
    
    pickerVc.maxCount = 1;
    //    PickerViewShowStatusGroup = 0, // default groups .
    //    PickerViewShowStatusCameraRoll ,
    //    PickerViewShowStatusSavePhotos ,
    //    PickerViewShowStatusPhotoStream ,
    //    PickerViewShowStatusVideo,
    pickerVc.status=PickerViewShowStatusCameraRoll;
    
    [pickerVc showPickerVc:self];
    group.cancelBack=^(NSArray *b)
    {
//        NSLog(@"b");
    };
    //取消，为选择照片
    pickerVc.cancelBack=^(NSArray *assets)
    {
        
    };
    pickerVc.callBack = ^(NSArray *assets){
        [self photoClass:assets];
    };
}
-(void)photoClass:(NSArray *)assets
{
    UIImageView * imageview=(UIImageView *)[self.view viewWithTag:3];
    // 判断类型来获取Image
    ZLPhotoAssets *asset =assets[0];
    if ([asset isKindOfClass:[ZLPhotoAssets class]]) {
        imageview.image = [asset aspectRatioImage];
    }
    //        else if ([asset isKindOfClass:[NSString class]]){
    //            [imageview sd_setImageWithURL:[NSURL URLWithString:(NSString *)asset] placeholderImage:[UIImage imageNamed:@"pc_circle_placeholder"]];
    //        }
    else if([asset isKindOfClass:[UIImage class]]){
        imageview.image = (UIImage *)asset;
    }else if ([asset isKindOfClass:[ZLCamera class]]){
        imageview.image = [asset thumbImage];
    }
   
//    //上传图片到七牛
//    NSString * urlString=[NSString stringWithFormat:KUptoken];
//    [RCGETRequest requestWithUrl:urlString Complete:^(NSData *data) {
//        //返回数据
//        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:NULL];
//        _UpToken=dict[@"uptoken"];
//        QNUploadManager *upManager = [[QNUploadManager alloc] init];
//        NSData *imageData = UIImageJPEGRepresentation(imageview.image, 0.5);
//        [upManager putData:imageData key:nil token:_UpToken
//                  complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//                      NSLog(@"%@", info);
//                      NSLog(@"七牛返回信息%@", resp);
//                      //NSLog(@"七牛key:%@",key);
//                      
//                      _iconImg = [NSString stringWithFormat:@"http://7xpfjj.com2.z0.glb.qiniucdn.com/%@",resp[@"key"]];
//                      NSLog(@"%@",_iconImg);
//                      
//                  } option:nil];
//    } faile:^(NSError *error) {
//        
//    }];
    
}

@end
