// iOS 27.0 Wi-Fi reconstruction. Uses Apple's public SF Symbols renderer;
// this recovers symbol selection/configuration, not the private font outlines.
#import <UIKit/UIKit.h>
typedef struct {CGFloat width,height,pointSize,offset;UIImageSymbolWeight weight;} Wifi27Spec;
static Wifi27Spec Wifi27Specification(NSInteger n){
    static const CGFloat widths[]={15.5,46/3.0,46/3.0,50/3.0,16.5,49/3.0,17,17.5,59/3.0,20.5,17.5,53/3.0,18,19,19,18,17.5,15.5,46/3.0};
    static const CGFloat heights[]={10.75,11,11,71/6.0,11.75,71/6.0,37/3.0,38/3.0,83/6.0,77/6.0,12.75,12.5,13.25,13.5,13.5,16,12.75,10.75,11};
    static const CGFloat points[]={13.75,83/6.0,83/6.0,15,15.25,46/3.0,16.5,52/3.0,107/6.0,223/12.0,15,44/3.0,15,47/3.0,47/3.0,13.5,15,12.5,38/3.0};
    if(n<1||n>19)return (Wifi27Spec){0,0,0,0,UIImageSymbolWeightHeavy};
    return (Wifi27Spec){widths[n-1],heights[n-1],points[n-1],n==16?-0.5:0,(n<=10||n==16)?UIImageSymbolWeightMedium:UIImageSymbolWeightHeavy};
}
static UIImage *Wifi27Image(NSInteger iconSize,NSInteger mode,NSInteger active,NSInteger total,UIColor *activeColor,UIColor *inactiveColor){
    Wifi27Spec s=Wifi27Specification(iconSize);
    UIColor *color=mode==0?(inactiveColor?:UIColor.tertiaryLabelColor):(activeColor?:UIColor.labelColor);
    double value=mode==2?(double)active/total:1;
    UIImageSymbolConfiguration *config=[UIImageSymbolConfiguration configurationWithPointSize:s.pointSize];
    config=[config configurationByApplyingConfiguration:[UIImageSymbolConfiguration configurationWithWeight:s.weight]];
    config=[config configurationByApplyingConfiguration:[UIImageSymbolConfiguration configurationWithHierarchicalColor:color]];
    return [UIImage systemImageNamed:@"wifi" variableValue:value withConfiguration:config];
}
