//
//  AlbumCellTableViewCell.h
//  IOSMedaiPicker

//

#import <UIKit/UIKit.h>

@interface AlbumCellTableViewCell : UITableViewCell

/**
 相册封面图
 */
@property (nonatomic ,weak)UIImageView * picImageView;


@property (nonatomic ,weak)UILabel * albumLabel;

@end
