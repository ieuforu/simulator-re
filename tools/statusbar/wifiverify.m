#import "../signals/SignalDump.h"
#import "WifiIcon27.h"
#import <dlfcn.h>
static UIImage *Raster(UIImage *image){
    UIGraphicsImageRendererFormat *f=[UIGraphicsImageRendererFormat preferredFormat];f.scale=3;f.opaque=NO;f.preferredRange=UIGraphicsImageRendererFormatRangeStandard;
    return [[[UIGraphicsImageRenderer alloc]initWithSize:image.size format:f]imageWithActions:^(UIGraphicsImageRendererContext *c){[image drawAtPoint:CGPointZero];}];
}
static NSUInteger Delta(UIImage *a,UIImage *b){
    CGImageRef x=a.CGImage,y=b.CGImage;size_t width=CGImageGetWidth(x),height=CGImageGetHeight(x);
    if(width!=CGImageGetWidth(y)||height!=CGImageGetHeight(y))return NSUIntegerMax;
    size_t count=width*height*4;uint8_t *p=calloc(count,1),*q=calloc(count,1);CGColorSpaceRef space=CGColorSpaceCreateDeviceRGB();
    CGContextRef ca=CGBitmapContextCreate(p,width,height,8,width*4,space,kCGImageAlphaPremultipliedLast|kCGBitmapByteOrder32Big);
    CGContextRef cb=CGBitmapContextCreate(q,width,height,8,width*4,space,kCGImageAlphaPremultipliedLast|kCGBitmapByteOrder32Big);
    CGContextDrawImage(ca,CGRectMake(0,0,width,height),x);CGContextDrawImage(cb,CGRectMake(0,0,width,height),y);
    NSUInteger delta=0;for(size_t i=0;i<count;i++)delta=MAX(delta,abs(p[i]-q[i]));
    CGContextRelease(ca);CGContextRelease(cb);CGColorSpaceRelease(space);free(p);free(q);return delta;
}
int main(int argc,char **argv){@autoreleasepool{
    if(argc!=2)return 2;dlopen("/System/Library/PrivateFrameworks/SystemStatusUI.framework/SystemStatusUI",RTLD_NOW);
    Class cls=NSClassFromString(@"STUIStatusBarWifiSignalIconView");if(!cls)return 2;
    NSString *dir=@(argv[1]);[[NSFileManager defaultManager]createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
    NSMutableArray *cases=[NSMutableArray array];NSUInteger worst=0;
    for(NSInteger size=1;size<=19;size++)for(int rounded=0;rounded<2;rounded++)for(int state=0;state<5;state++){
        NSInteger mode=state==4?0:2,active=state==4?3:state;UIView *v=[[cls alloc]initWithFrame:CGRectZero];
        [v setValue:@(size) forKey:@"iconSize"];[v setValue:@(rounded) forKey:@"rounded"];
        [v setValue:@3 forKey:@"numberOfBars"];[v setValue:@(active) forKey:@"numberOfActiveBars"];
        [v setValue:UIColor.blackColor forKey:@"activeColor"];[v setValue:[UIColor.blackColor colorWithAlphaComponent:0.2] forKey:@"inactiveColor"];
        [v setValue:@(mode) forKey:@"signalMode"];((void(*)(id,SEL))objc_msgSend)(v,sel_getUid("_updateImage"));
        UIImageView *content=nil;for(UIView *child in v.subviews)if([child isKindOfClass:UIImageView.class]){content=(id)child;break;}
        UIImage *native=content.image,*rebuilt=Wifi27Image(size,mode,active,3,UIColor.blackColor,[UIColor.blackColor colorWithAlphaComponent:0.2]);
        if(!native||!rebuilt){fprintf(stderr,"missing image at size %ld\n",size);return 1;}
        UIImage *a=Raster(native),*b=Raster(rebuilt);NSUInteger delta=Delta(a,b);worst=MAX(worst,delta);
        NSString *name=[NSString stringWithFormat:@"size%ld-rounded%d-mode%ld-active%ld",size,rounded,mode,active];
        [cases addObject:@{@"name":name,@"size":SRSize(native.size),@"maxRGBAByteDelta":@(delta)}];
        if(size==8||size==12){[UIImagePNGRepresentation(a)writeToFile:[dir stringByAppendingFormat:@"/%@-native.png",name]atomically:YES];[UIImagePNGRepresentation(b)writeToFile:[dir stringByAppendingFormat:@"/%@-rebuilt.png",name]atomically:YES];}
    }
    NSDictionary *out=@{@"version":UIDevice.currentDevice.systemVersion,@"scale":@3,@"cases":cases,@"worstRGBAByteDelta":@(worst),@"scope":@"native content image vs public SF Symbols reconstruction; excludes whole-view layout and search animation"};
    [[NSJSONSerialization dataWithJSONObject:out options:NSJSONWritingPrettyPrinted|NSJSONWritingSortedKeys error:nil]writeToFile:[dir stringByAppendingPathComponent:@"validation.json"]atomically:YES];
    printf("%lu Wi-Fi symbol images: max RGBA byte difference %lu\n",(unsigned long)cases.count,(unsigned long)worst);return worst?1:0;
}}
