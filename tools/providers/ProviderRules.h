// Hand reconstruction of the iOS 17.4 Split provider's scale-to-size mapping.
// These exact floating-point comparisons are version-specific implementation details.
#import <Foundation/Foundation.h>
static NSInteger PRIconSize(double iconScale, double screenScale) {
    if(screenScale > 2.5) {
        if(iconScale==1.08)return 6;
        if(iconScale==1.06)return 4;
        if(iconScale==1.12)return 7;
        if(iconScale==1.26)return 8;
        if(iconScale==1.16)return 10;
        if(iconScale==1.2412)return 12;
        if(iconScale==1.2992000000000001)return 13;
        return 2;
    }
    if(iconScale==1.07)return 5;
    if(iconScale==1.16)return 9;
    if(iconScale==1.2412)return 11;
    return 1;
}
static NSString *PRDynamicProvider(double referenceWidth,double nativeScale,double screenScale) {
    return referenceWidth*nativeScale/screenScale<=393.0 ? @"STUIStatusBarVisualProvider_DynamicSplitMedium" : @"STUIStatusBarVisualProvider_DynamicSplit";
}
typedef struct {const char *name;double width,notchWidth,notchHeight,referenceScale;} PRNotch;
// Order recovered from +[..._Split visualProviderSubclassForScreen:visualProviderInfo:].
static const PRNotch PRNotches[]={
    {"Split1125",1125,209,30,0}, {"Split1080",1080,226,103/3.0,2.88},
    {"Split1080_Wide",1080,174,112/3.0,2.88}, {"Split1170",1170,210,32,0},
    {"Split1170_Wide",1170,484/3.0,101/3.0,0}, {"Split1242",1242,628/3.0,30,0},
    {"Split828",828,227,32,0}, {"Split1284",1284,628/3.0,32,0},
    {"Split1284_Wide",1284,484/3.0,101/3.0,0}
};
static NSString *PRNotchProvider(double nativeWidth,double notchWidth,double notchHeight,double nativeScale,double screenScale){
    for(unsigned i=0;i<sizeof(PRNotches)/sizeof(PRNotch);i++){
        PRNotch c=PRNotches[i];double ratio=nativeScale/(c.referenceScale?:screenScale);
        if(fabs(c.width-nativeWidth)<=0.0001 && fabs(c.notchWidth-notchWidth*ratio)<=0.0001 && fabs(c.notchHeight-notchHeight*ratio)<=0.0001)
            return [@"STUIStatusBarVisualProvider_" stringByAppendingString:@(c.name)];
    }
    return @"nil";
}
