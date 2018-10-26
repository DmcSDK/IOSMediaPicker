
#import "ViewController.h"
#import "DmcPickerViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self view]setBackgroundColor:[UIColor whiteColor]] ;
    UIButton * redButton=[[UIButton alloc]initWithFrame:CGRectMake(15, 15, 45, 45)];
    [redButton setBackgroundColor:[UIColor redColor]];
    [redButton setTitle:@"1" forState:UIControlStateNormal];
    [[self view]addSubview:redButton];
    [redButton addTarget:self action:@selector(go) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * blueButton=[[UIButton alloc]initWithFrame:CGRectMake(100, 350, 51, 44)];
    [blueButton setBackgroundColor:[UIColor blueColor]];
    [blueButton setTitle:@"2" forState:UIControlStateNormal];
    [[self view]addSubview:blueButton];
    [blueButton addTarget:self action:@selector(toNavTable) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void) go{
    DmcPickerViewController * dmc=[[DmcPickerViewController alloc] init];
    dmc._delegate=self;
    
    [self presentViewController:[[UINavigationController alloc]initWithRootViewController:dmc] animated:YES completion:nil];
}

-(void) resultPicker:(NSMutableArray*) selectArray
{
    NSLog(@"select%d",[selectArray count]);
}

-(void)toNavTable{
    // 实例化UIImagePickerController控制器
    UIImagePickerController * imagePickerVC = [[UIImagePickerController alloc] init];
    // 设置资源来源（相册、相机、图库之一）
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // 设置可用的媒体类型、默认只包含kUTTypeImage，如果想选择视频，请添加kUTTypeMovie
    // 如果选择的是视屏，允许的视屏时长为20秒
    imagePickerVC.videoMaximumDuration = 20;
    // 允许的视屏质量（如果质量选取的质量过高，会自动降低质量）
    imagePickerVC.videoQuality = UIImagePickerControllerQualityTypeHigh;
    
    // 设置代理，遵守UINavigationControllerDelegate, UIImagePickerControllerDelegate 协议
    // imagePickerVC.delegate = self;
    // 是否允许编辑（YES：图片选择完成进入编辑模式）
    imagePickerVC.allowsEditing = YES;
    // model出控制器
    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
