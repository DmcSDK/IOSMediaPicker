//
//  PreviewCell.m
//  IOSMedaiPicker
//
//

#import "PreviewCell.h"
#import "FLAnimatedImage.h"
@implementation PreviewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width=CGRectGetWidth(self.frame);
        CGFloat height=CGRectGetHeight(self.frame);
        self.artScrollView = [[UIScrollView alloc] init];
        self.artScrollView.frame = CGRectMake(0, 0, width, height);
        self.artScrollView.minimumZoomScale = 1;
        self.artScrollView.maximumZoomScale = 5.0;
        self.artScrollView.showsVerticalScrollIndicator = NO;
        self.artScrollView.showsHorizontalScrollIndicator = NO;
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        [self.artScrollView addGestureRecognizer:tap1];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        tap2.numberOfTapsRequired = 2;
        [tap1 requireGestureRecognizerToFail:tap2];
        [self.artScrollView addGestureRecognizer:tap2];
        self.artScrollView.delegate = self;
        [self.contentView addSubview:self.artScrollView];

        
        self.playimgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
        self.playimgView.contentMode =  UIViewContentModeCenter;
        [self.playimgView setImage:[UIImage imageNamed:@"dmcPicker.bundle/video_play.png"]];
        [self addSubview:self.playimgView];
    }
    return self;
}


- (void)singleTap:(UITapGestureRecognizer *)tap {
    if (self.cellTapClick) {
        self.cellTapClick();
    }
}


- (void)doubleTap:(UITapGestureRecognizer *)tap {
    if (self.artScrollView.zoomScale > 1.0) {
        [self.artScrollView setZoomScale:1.0 animated:YES];
    } else {
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        CGPoint touchPoint;

        touchPoint = [tap locationInView:self.imgView];
       
        CGFloat newZoomScale = self.artScrollView.maximumZoomScale;
        CGFloat xsize = width / newZoomScale;
        CGFloat ysize = height / newZoomScale;
        [self.artScrollView zoomToRect:CGRectMake(touchPoint.x - xsize/2, touchPoint.y - ysize/2, xsize, ysize) animated:YES];
    }
}

-(void)setImg:(UIImage *)image
{
    
    //移除上一个artimage
    [self.imgView removeFromSuperview];
    [self.artScrollView setZoomScale:1.0 animated:NO];
    self.imgView = [[UIImageView alloc] init];
    self.imgView.contentMode = UIViewContentModeScaleAspectFit;
    self.imgView.frame = CGRectMake(0, 0,CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));

   // UIImageView *textimage=[[UIImageView alloc] initWithImage:image];
   // self.imgView.frame = [self setImageCGRect:textimage SCREENWIDTH:CGRectGetWidth(self.frame) SCREENHEIGHT:CGRectGetHeight(self.frame)];
    self.imgView.image = image;
    self.artScrollView.frame=self.imgView.frame;
    [self.artScrollView addSubview:self.imgView];
    
    //设置scroll的contentsize的frame
    self.artScrollView.contentSize = self.imgView.frame.size;
}

-(void)setGifImg:(NSData *)image
{

    [self.gifView removeFromSuperview];
    self.gifView = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    self.gifView.contentMode = UIViewContentModeScaleAspectFit;
    self.gifView.clipsToBounds = YES;
    [self addSubview:self.gifView];
    FLAnimatedImage *animatedImagegif = [FLAnimatedImage animatedImageWithGIFData: image];
    self.gifView.animatedImage = animatedImagegif;
}

//这个方法的返回值决定了要缩放的内容(只能是UISCrollView的子控件)
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imgView;
}


//控制缩放是在中心
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    
    self.imgView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                       
                                       scrollView.contentSize.height * 0.5 + offsetY);
}

//根据不同的比例设置尺寸
-(CGRect) setImageCGRect:(UIImageView *)imageView SCREENWIDTH:(CGFloat)SCREENWIDTH SCREENHEIGHT:(CGFloat)SCREENHEIGHT
{
    
    CGFloat imageX = imageView.frame.size.width;
    
    CGFloat imageY = imageView.frame.size.height;
    
    CGRect imgfram;
    
    CGFloat CGscale;
    
    BOOL flx =  (SCREENWIDTH / SCREENHEIGHT) > (imageX / imageY);
    
    if(flx)
    {
        CGscale = SCREENHEIGHT / imageY;
        
        imageX = imageX * CGscale;
        
        imgfram = CGRectMake((SCREENWIDTH - imageX) / 2, 0, imageX, SCREENHEIGHT);
        
        return imgfram;
    }
    else
    {
        CGscale = SCREENWIDTH / imageX;
        
        imageY = imageY * CGscale;
        
        imgfram = CGRectMake(0, (SCREENHEIGHT - imageY) / 2, SCREENWIDTH, imageY);
        
        return imgfram;
    }
    
}


@end
