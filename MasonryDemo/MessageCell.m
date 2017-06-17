//
//  MessageCell.m
//  MasonryDemo
//
//  Created by luckyCoderCai on 2017/6/17.
//  Copyright © 2017年 luckyCoderCai. All rights reserved.
//

#import "MessageCell.h"
#import "Masonry.h"
#import "MessageModel.h"

@interface MessageCell ()

@property (nonatomic, strong) UIImageView *headImgView;
@property (nonatomic, strong) UIView *redDotView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *informationLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation MessageCell

#pragma mark -懒加载
- (UIImageView *)headImgView
{
    if (!_headImgView) {
        _headImgView = [[UIImageView alloc] init];
        _headImgView.layer.cornerRadius = 22;
        _headImgView.layer.masksToBounds = YES;
    }
    return _headImgView;
}

- (UIView *)redDotView
{
    if (!_redDotView) {
        _redDotView = [[UIView alloc] init];
        _redDotView.backgroundColor = [UIColor redColor];
        _redDotView.layer.cornerRadius = 4;
    }
    return _redDotView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor greenColor];
        _nameLabel.font = [UIFont systemFontOfSize:12];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.numberOfLines = 0;
    }
    return _nameLabel;
}

- (UILabel *)informationLabel
{
    if (!_informationLabel) {
        _informationLabel = [UILabel new];
        _informationLabel.textColor = [UIColor purpleColor];
        _informationLabel.font = [UIFont systemFontOfSize:15];
        _informationLabel.numberOfLines = 0;
    }
    return _informationLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.textColor = [UIColor orangeColor];
        _timeLabel.font = [UIFont systemFontOfSize:11];
    }
    return _timeLabel;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

#pragma mark -初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    [self.contentView addSubview:self.headImgView];
    [self.contentView addSubview:self.redDotView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.informationLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.lineView];
    
    [self updateConstraintsForView];
}

#pragma mark -布局
- (void)updateConstraintsForView
{
    [_headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.top.equalTo(@15);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    [_redDotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@11);
        make.top.equalTo(_headImgView);
        make.size.mas_equalTo(CGSizeMake(8, 8));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_headImgView);
        make.top.equalTo(_headImgView.mas_bottom).mas_offset(10);
        make.width.equalTo(@50);
    }];
    
    [_informationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_headImgView.mas_trailing).mas_offset(15);
        make.top.equalTo(_headImgView);
        make.trailing.equalTo(@-15);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_informationLabel);
        make.top.equalTo(_informationLabel.mas_bottom).mas_offset(10);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(@0);
        make.top.greaterThanOrEqualTo(_nameLabel.mas_bottom).mas_offset(10);
        make.top.greaterThanOrEqualTo(_timeLabel.mas_bottom).mas_offset(20);
        make.height.equalTo(@0.5);
        make.bottom.equalTo(@0);
    }];
}

#pragma mark -set
- (void)setModel:(MessageModel *)model
{
    _model = model;
    _headImgView.image = [UIImage imageNamed:model.headImageName];
    
    if (model.isRead) {
        _redDotView.hidden = YES;
    }else {
        _redDotView.hidden = NO;
    }
    
    _nameLabel.text = model.name;
    
    _informationLabel.text = model.information;
    
    _timeLabel.text = model.time;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
