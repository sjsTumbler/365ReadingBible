//
//  SJSSettingViewController.m
//  365_readingBible
//
//  Created by SunJishuai on 16/1/23.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import "SJSSettingViewController.h"

@interface SJSSettingViewController ()
{
    NSString *text;
}
@end

@implementation SJSSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.SNavigationBar setTitle:@"设置"];
    text = @"路或行使贿赂。如果有些同业付给他的是一些很有信用但期限较远的票据，他就叫他们到他的公证人那里去贴现，这对于他仍然是一举两得的事，因此在圣德尼街的商人间流传着一句话：“老天爷保佑你不要遇见纪尧姆先生的公证人!”由此可见那种贴现是不上算的。老仆人刚走开，纪尧姆先生就象奇迹一般出现，站在猫打球商店的台阶上。他看看圣德尼街，看看四邻的商店，看看天气，好象长途旅行的归客，在勒阿弗尔港下船时重新看见法兰西一样。待他看明白在他睡眠时一切都没有变动之后，才发现了站在那里的陌生青年。这青年也在那里聚精会神地观察他，好象生物学家韩堡在美洲仔细观察他所看见的第一条电鳗⋯。纪尧姆先生穿着宽大的黑天鹅绒裤子，杂色袜子和方头银扣的鞋。裹着他那微驼的身躯的暗绿色方领绒上装，下摆和垂尾也都呈方形，钮于是白色的金属制品，用旧以后变成了红色。他的灰头发梳得那么服帖、整齐，使他的黄脑盖看起来好象犁过的田。两只仿佛用钻子钻得凹进去的绿色小眼睛，在没有眉毛而略呈红色的眉弓下面闪闪发光。忧患在他的前额留下无数皱纹，象他衣服上的皱褶一多。他苍睑表现出他有耐心，有商业智慧和生意人所特有的狡猾的贪婪。那时候，还有不少这类老式家庭，虽然生活在新时代，却象保持优秀传统一样，保留着过去的习俗和那些具有行业特征的衣饰，活象是居维埃⋯考古时发掘出来的一些①韩堡(1769 1 859)，普鲁士著名生物学家，旅行家。电鳗是北美洲的一种  河鱼。②居维埃，见本卷《(人司喜剧)前言》第1页注①。人间喜剧第一卷太古时代的老古董。纪尧姆家族的这位家长就是著名的守旧派之一：人们时常见他怀念过去由商人领袖兼任的巴黎市长，而且总是用几十年前的旧名称来称呼商务法庭的判决书。早起也是这类老传统之一。他是全家第一个早起的人，他毫不含糊地站在那里等待着他的三个徒弟，如果他们迟到，就责骂他们一顿。三个年轻学徒最害怕的是星期一早晨，老商人一声不响地盯着他们，要从他们的面孔和一举一动中找出他们星期日胡作非为的证据和痕迹来。此刻老呢绒商人却丝毫不注意他的学徒，他正在捉摸那个穿着丝袜、披着大衣的年轻人，为什么要很关心地时而注视他的招牌，时而注视他的店堂内部。天色更亮了，可以看见店里用铁丝网围着的办公桌，四周挂有古旧的绿色丝质帷幕，桌上放着巨大的帐朋，那是本店前途的不出声的权威发言人。那个好奇的陌生青年似乎对这个地方非常爱慕，好象想要描下侧面饭厅的图样。饭厅从开在天花板上的一个玻璃天窗取光。一家人集合在饭厅吃饭的时候，可以很方便地望见店门口发生的每一件最细小的事。一个曾经在“限价时代”⋯生活过的商人，认为一个陌生人这么爱慕他的住宅是很可疑的。纪尧姆先生因此很自然地想到，这个愁容满面的年轻人必定在猫打球商店的银柜上转念头。最年";

    [self matchesCharacters:@"可疑"];
    
//    NSString *PD = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
//    NSPredicate *regextesttel = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PD];
//    return  [regextesttel evaluateWithObject:password];
//    
    }

- (void)matchesCharacters:(NSString *)appointedStr{
    
    NSMutableArray *strArr = [NSMutableArray array];
    for (int i = 0; i<appointedStr.length; i++) {
    
        NSString *unitStr = [NSString stringWithFormat:@"%c",[appointedStr characterAtIndex:i]];
        
        [strArr addObject:unitStr];
       
    }
    NSLog(@"strarr=%@",strArr);
    for (int j = 0; j<strArr.count; j++) {

    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
