//
//  MapMakeViewController.m
//  Momo
//
//  Created by Hanson Jung on 2017. 4. 6..
//  Copyright © 2017년 JeheonChoi. All rights reserved.
//

#import "MapMakeViewController.h"
#import "MapViewController.h"

@interface MapMakeViewController ()
<UITextFieldDelegate, UIGestureRecognizerDelegate>

@property (nonatomic) BOOL isEditMode;

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *mapNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *mapContentTextField;

@property (nonatomic) BOOL checkName;
@property (nonatomic) BOOL checkContent;
@property (weak, nonatomic) IBOutlet UIButton *makeBtn1;
@property (weak, nonatomic) IBOutlet UIButton *makeBtn2;
@property (weak, nonatomic) IBOutlet UIButton *makeBtn3;
@property (weak, nonatomic) IBOutlet UISwitch *secretSwitch;
@property (nonatomic) UIButton *deleteBtn;

@end

@implementation MapMakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    // Navi Pop Gesture 활성화
    [self.navigationController.interactivePopGestureRecognizer setDelegate:self];

    
    [self.mapNameTextField addTarget:self action:@selector(mapNameTextFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.mapContentTextField addTarget:self action:@selector(mapContentTextFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    
    
//////////////// 만들기 상태. 밖에서 수정하기로 들어오기 전까지 ///////////////
//    self.isEditMode = YES;
//
//    self.checkName = YES;
//    self.checkContent = YES;
//    [self checkMakeBtnState];
//    
//    self.mapNameTextField.text = @"2017년 여름 휴가";
//    self.mapContentTextField.text = @"모모랑 함께한 도쿄여행";
///////////////////////////////////////////////////////////////////
    
    if (self.isEditMode) {
        [self.makeBtn2 setTitle:@"수정하기" forState:UIControlStateNormal];
        [self.view layoutIfNeeded];
        self.deleteBtn = [[UIButton alloc] init];
        [self.deleteBtn setFrame:CGRectMake(self.makeBtn3.frame.origin.x+3, self.makeBtn3.frame.origin.y+70, 34, 44)];
        [self.deleteBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.deleteBtn];
        [self.deleteBtn addTarget:self action:@selector(selectedDeleteMapBtn:) forControlEvents:UIControlEventTouchUpInside];

    }
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // NavigationBar 숨긴거 되살리기
    [self.navigationController setNavigationBarHidden:NO];
    
}

- (IBAction)selectedPopViewBtn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField.tag == 1) {
        [self.mapContentTextField becomeFirstResponder];
        [self.scrollView setContentOffset:CGPointMake(0,200) animated:YES];
        
    } else {
        [self.mapContentTextField resignFirstResponder];
        [self.scrollView setContentOffset:CGPointMake(0,0) animated:YES];

    }
    return YES;
}

- (IBAction)textFieldResignTapGesture:(id)sender {
    [self.mapNameTextField resignFirstResponder];
    [self.mapContentTextField resignFirstResponder];
}


// 핀이름 textfield에 space 입력했을때를 걸러내려고 --------------//
- (void)mapNameTextFieldEditingChanged:(UITextField *)sender {
    
    if ([sender.text isEqualToString:@""]) {
        self.checkName = NO;
    } else {
        self.checkName = (BOOL)sender.text;
    }
    
    [self checkMakeBtnState];
}

- (void)mapContentTextFieldEditingChanged:(UITextField *)sender {
    
    if ([sender.text isEqualToString:@""]) {
        self.checkContent = NO;
    } else {
        self.checkContent = (BOOL)sender.text;
    }
    
    [self checkMakeBtnState];
}

// 만들기버튼 활성화 메서드 -----------//
- (void)checkMakeBtnState {
    //모든 조건이 yes이면 makeBtn이 활성화되게
    if (self.checkName && self.checkContent) {
        [self.makeBtn1 setEnabled:YES];
        [self.makeBtn2 setEnabled:YES];
        [self.makeBtn3 setEnabled:YES];
    } else {
        [self.makeBtn1 setEnabled:NO];
        [self.makeBtn2 setEnabled:NO];
        [self.makeBtn3 setEnabled:NO];
    }
}

- (IBAction)selectedMakeBtn:(id)sender {
    
    NSLog(@"새맵 만들어!");
    
    MomoMapDataSet *mapData = [MomoMapDataSet makeMapWithName:self.mapNameTextField.text
                                           withMapDescription:self.mapContentTextField.text
                                                  withPrivate:self.secretSwitch.on];
    
    UIStoryboard *makeStoryBoard = [UIStoryboard storyboardWithName:@"Map" bundle:nil];
    MapViewController *mapVC = [makeStoryBoard instantiateViewControllerWithIdentifier:@"MapViewController"];
    [mapVC showSelectedMapAndSetMapData:mapData];
    
    [self.navigationController pushViewController:mapVC animated:YES];
    
}
 


- (IBAction)flickedSecretSwitch:(id)sender {
    NSLog(@"비밀지도 switch");
    
}

// 아마 데이터 센터에 추가 될 메서드 (일단 예시로 여기다 만들어놓음)
- (void)makeMapWithName:(NSString *)name
           withMapContent:(NSString *)content
            withPrivate:(BOOL)private {
    // 알아서 안에서 데이터 처리~~~
    
    
}

- (void)selectedDeleteMapBtn:(id)sender {
    
    NSLog(@"맵 지워");
    [self.navigationController popViewControllerAnimated:YES];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
