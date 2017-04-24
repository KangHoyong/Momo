//
//  UserProfileHeaderView.m
//  Momo
//
//  Created by Jeheon Choi on 2017. 4. 6..
//  Copyright © 2017년 JeheonChoi. All rights reserved.
//

#import "UserProfileHeaderView.h"

@implementation UserProfileHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"awakeFromNib");

}

- (void)layoutSubviews {
    [super layoutSubviews];
//    NSLog(@"layoutSubviews");
    
    
    // 프로필 BackView 세팅
//    [self.backView.layer setCornerRadius:20];
    
    // 프로필 사진 동그랗게
    [self.userImgView.layer setCornerRadius:self.userImgView.frame.size.height/2];
//    NSLog(@"%f", self.userImgView.frame.size.height/2);

    // 수정하기 버튼
//    [self.userEditBtn.layer setCornerRadius:5];
//    [self.userEditBtn.layer setBorderColor:[UIColor mm_warmGreyColor].CGColor];
//    [self.userEditBtn.layer setBorderWidth:1];
    
    self.userCommentLabel.text = @"자 이제 시작이야 내 꿈을!\n내 꿈을 위한 여행 피카츄! 피카피카!\n걱정따윈 없어 없어 내 친구와 함께니깐~";
    
}


- (IBAction)followerBtnAction:(id)sender {
    [self.delegate selectedFollowerBtn];
}

- (IBAction)followingBtnAction:(id)sender {
    [self.delegate selectedFollowingBtn];
}

- (IBAction)editBtnAction:(id)sender {
    [self.delegate selectedUserEditBtn];
}


- (IBAction)mapPinBtnAction:(UIButton *)sender {
    
    sender.selected = YES;
    
    if (sender.tag == 0) {
        self.pinBtn.selected = NO;
        
        self.selectedMapTabViewConstraint.priority = 999.0f; // 1000은 필수 최대값이라 코드로 설정하면 에러
        
        [UIView animateWithDuration:0.2 animations:^{
            [self layoutIfNeeded];
        }];

        [self.delegate selectedMapPinBtnWithNum:0];
    } else {
        self.mapBtn.selected = NO;

        self.selectedMapTabViewConstraint.priority = 780.0f; // pin선택 priority는 800

        [UIView animateWithDuration:0.2 animations:^{
            [self layoutIfNeeded];
        }];

        [self.delegate selectedMapPinBtnWithNum:1];
    }
}

@end
