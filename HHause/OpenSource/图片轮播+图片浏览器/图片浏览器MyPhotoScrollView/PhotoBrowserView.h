//
//  PhotoBrowserView.h
//  SPH0
//
//

/**
 *类文件说明：用于显示一组网络图片，有放大功能,和拖动功能
 */

#import <UIKit/UIKit.h>

@interface PhotoBrowserView : UIView

/**
 * array 图片url 数组
 */


/**
* index 要显示的第几张图片
*/


- (instancetype)initWithFrame:(CGRect)frame WithArray:(NSArray *)array andCurrentIndex:(int)index;

@end