//
//  PhotoScrollView.h
//  MyPhotoShow
//
//

#import <UIKit/UIKit.h>

@interface PhotoScrollView : UIScrollView<UIGestureRecognizerDelegate>


@property (nonatomic,strong) UIView *childView;


@property (nonatomic,copy) void (^stopScrollView) (void);

@property (nonatomic,copy) void (^startScrollView) (void);


- (id)initWithChildView:(UIView *)aChildView;

- (id)initWithFrame:(CGRect)aFrame andChildView:(UIView *)aChildView;




@end
