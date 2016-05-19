//
//  DLTopicCell.m
//  DLBaiSiBuDeQiJie
//
//  Created by iMac 11 on 16/5/18.
//  Copyright © 2016年 weishine. All rights reserved.
//

#import "DLTopicCell.h"
#import "DLTopics.h"
#import "UIImageView+WebCache.h"


@interface DLTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 最热评论-整体 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;
@end
@implementation DLTopicCell

- (void)awakeFromNib {

    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setFrame:(CGRect)frame{
    
    frame.size.height -= DLMargin;
    frame.origin.y += DLMargin;
//    frame.origin.x += DLMargin;
//    frame.size.width -= 2*DLMargin;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTopic:(DLTopics *)topic
{
    _topic = topic;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    self.createdAtLabel.text = topic.created_at;
    self.text_label.text = topic.text;
    
    //    if (topic.ding >= 10000) {
    //        [self.dingButton setTitle:[NSString stringWithFormat:@"%.1f万", topic.ding / 10000.0] forState:UIControlStateNormal];
    //    } else if (topic.ding > 0) {
    //        [self.dingButton setTitle:[NSString stringWithFormat:@"%zd", topic.ding] forState:UIControlStateNormal];
    //    } else {
    //        [self.dingButton setTitle:@"顶" forState:UIControlStateNormal];
    //    }
    
    //    topic.ding = arc4random_uniform(8000) + arc4random_uniform(5000);
    //    topic.cai = arc4random_uniform(8000) + arc4random_uniform(5000);
    //    topic.repost = arc4random_uniform(8000) + arc4random_uniform(5000);
    //    topic.comment = 0;
    
    [self setupButton:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setupButton:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setupButton:self.repostButton number:topic.repost placeholder:@"分享"];
    [self setupButton:self.commentButton number:topic.comment placeholder:@"评论"];
    
    /*
     数量 >= 10000
     比如53454 -> 5.3万
     
     数量 < 10000
     比如5435 -> 5435
     比如546 -> 546
     
     数量 == 0
     比如0 -> 评论
     
     */
}

- (void)setupButton:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder
{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万", number / 10000.0] forState:UIControlStateNormal];
    } else if (number > 0) {
        [button setTitle:[NSString stringWithFormat:@"%zd", number] forState:UIControlStateNormal];
    } else {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}

- (IBAction)more {
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"我的标题" message:@"消息内容" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    //    [alert show];
    
    //    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"我的标题" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:@"其他按钮", nil];
    //    [sheet showInView:self];
    
    // UIAlertControllerStyleAlert  == UIAlertView
    // UIAlertControllerStyleActionSheet == UIActionSheet
    // UIAlertController == UIAlertView + UIActionSheet
    
    //    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"我的标题" message:@"消息内容" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了[收藏]按钮");
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了[举报]按钮");
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了[取消]按钮");
    }]];
    
    //    [controller addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    //        textField.textColor = [UIColor redColor];
    //    }];
    
    [self.window.rootViewController presentViewController:controller animated:YES completion:nil];
}

@end
