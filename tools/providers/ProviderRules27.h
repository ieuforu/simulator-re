// Reconstructed from iOS 27.0 (24A434), not a cross-version API contract.
#import <Foundation/Foundation.h>
static NSString *PR27DynamicProvider(double referenceWidth,double nativeScale,double scale,double exclusionWidth){
    BOOL medium=referenceWidth*nativeScale/scale<=402.0;
    BOOL smallIsland=exclusionWidth<=285.0; // raw exclusion-rect width, not assumed pt
    if(medium)return smallIsland?@"STUIStatusBarVisualProvider_DynamicSplitMediumSmallIsland":@"STUIStatusBarVisualProvider_DynamicSplitMedium";
    return smallIsland?@"STUIStatusBarVisualProvider_DynamicSplitSmallIsland":@"STUIStatusBarVisualProvider_DynamicSplit";
}
static NSInteger PR27IconSize(double iconScale,double screenScale){
    if(screenScale>2.5){
        if(iconScale==1.08)return 6;
        if(iconScale==1.06)return 4;
        if(iconScale==1.12)return 7;
        if(iconScale==1.18)return 8;
        if(iconScale==1.26)return 9;
        if(iconScale==1.32)return 10;
        if(iconScale==1.16)return 12;
        if(iconScale==1.2412)return 14;
        if(iconScale==1.2992000000000001)return 15;
        return 2;
    }
    if(iconScale==1.07)return 5;
    if(iconScale==1.16)return 11;
    if(iconScale==1.2412)return 13;
    return 1;
}
