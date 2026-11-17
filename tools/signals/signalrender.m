// signalrender <输出目录>，独立重绘已核对的三档、两种 rounded 分支。
#import "SignalGeometry.h"
int main(int argc,char **argv){@autoreleasepool {
    if(argc!=2)return 2;NSString *dir=@(argv[1]);NSError *e=nil;
    if(![[NSFileManager defaultManager]createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:&e])return 1;
    for(NSNumber *n in @[@4,@7,@8])for(int rounded=0;rounded<2;rounded++) {
        SRSpec s=SRSpecification(n.integerValue);
        for(int i=0;i<3;i++) {
            NSString *name=[NSString stringWithFormat:@"Wifi-%@-rounded%d-layer%02d.png",n,rounded,i+1];
            if(![UIImagePNGRepresentation(SRWifiBandImage(s,i,rounded,3)) writeToFile:[dir stringByAppendingPathComponent:name] atomically:YES])return 1;
        }
        for(int active=0;active<=4;active++) {
            NSString *name=[NSString stringWithFormat:@"Cellular-%@-rounded%d-active%d.png",n,rounded,active];
            if(![UIImagePNGRepresentation(SRRenderLayer(SRCellularLayer(s,rounded,active),3))writeToFile:[dir stringByAppendingPathComponent:name] atomically:YES])return 1;
        }
    }
    puts("exported 18 Wi-Fi band images and 30 cellular images");return 0;
}}
