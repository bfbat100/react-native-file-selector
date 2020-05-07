//
//  FileSelectorCell.m
//  BVLinearGradient
//
//  Created by SK on 2020/5/7.
//

#import "FileSelectorCell.h"

@implementation FileSelectorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        UIImageView *imageView = [[UIImageView alloc]init];
        [self addSubview:imageView];
        self.imgView = imageView;
        
        UILabel *nameLab = [[UILabel alloc]init];
        nameLab.font = [UIFont systemFontOfSize:14];
        nameLab.textColor = [UIColor blackColor];
        [self addSubview:nameLab];
        self.nameLab = nameLab;
        
        UILabel *dateLab = [[UILabel alloc]init];
        dateLab.font = [UIFont systemFontOfSize:14];
        dateLab.textColor = [UIColor blackColor];
        [self addSubview:dateLab];
        self.dateLab = dateLab;
        
        UILabel *sizeLab = [[UILabel alloc]init];
        sizeLab.font = [UIFont systemFontOfSize:14];
        sizeLab.textColor = [UIColor blackColor];
        [self addSubview:sizeLab];
        self.sizeLab = sizeLab;

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat marginLeft = 15;
    CGFloat marginTop = 15;
    CGFloat WIDTH = [[UIScreen mainScreen] bounds].size.width;
    
    self.imgView.frame = CGRectMake(marginLeft, marginTop, 20, 20);
    
    self.nameLab.frame = CGRectMake(marginLeft+20+10, marginTop, WIDTH - 45, 20);
    
    self.sizeLab.frame = CGRectMake(marginLeft+20+10, marginTop+20+12, 80, 20);
    
    self.dateLab.frame = CGRectMake(WIDTH-15 - 120, marginTop+20+12, 150, 20);
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
