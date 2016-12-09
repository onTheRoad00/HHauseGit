//
//  PhotoBrowserScrollView.h
//  MyPhotoShow
//

//

#import <UIKit/UIKit.h>


@interface PhotoBrowserScrollView : UIScrollView


@property (nonatomic,strong) NSArray *arrayUrl;

@property (nonatomic,assign) int currenIndex;

@property (nonatomic,copy) void (^imageClickBlock) (void);

@property (nonatomic,copy) void (^zoomChange) (CGFloat currentZoom);

@end
