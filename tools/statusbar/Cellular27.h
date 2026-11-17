// Selected iOS 27.0 table entries and reconstructed layout. The continuous
// corner renderer remains Core Animation's implementation, not our own curve.
#import <UIKit/UIKit.h>
typedef struct {CGFloat width,gap,radius,offset,heights[4];} Cell27Spec;
static Cell27Spec Cell27Specification(NSInteger n){
    switch(n){
        case 4:return (Cell27Spec){3,5/3.0,1.4,0,{4,6,26/3.0,34/3.0}};
        case 7:return (Cell27Spec){10/3.0,2,49/30.0,0,{19/3.0,25/3.0,32/3.0,13}};
        case 8:return (Cell27Spec){3.5,13/6.0,1.715,1,{6.5,26/3.0,67/6.0,41/3.0}};
        case 9:return (Cell27Spec){11/3.0,7/3.0,1.68,0,{7,9,35/3.0,43/3.0}};
        case 10:return (Cell27Spec){23/6.0,7/3.0,1.7563333333333333,4/3.0,{7,28/3.0,73/6.0,15}};
        case 12:return (Cell27Spec){11/3.0,2,1.68,0,{5,7,10,13}};
        default:return (Cell27Spec){0};
    }
}
static CGRect Cell27Frame(Cell27Spec s,CGSize bounds,NSInteger index,BOOL reverse){
    CGFloat x=index*(s.width+s.gap);
    if(reverse)x=bounds.width-s.width-x;
    return CGRectMake(x,bounds.height-s.heights[index]+s.offset,s.width,s.heights[index]);
}
static CGFloat Cell27Radius(Cell27Spec s,BOOL rounded){return rounded?s.width/2:s.radius;}
