//
//  MainTabBarController.m
//  Momo
//
//  Created by Jeheon Choi on 2017. 3. 27..
//  Copyright © 2017년 JeheonChoi. All rights reserved.
//

#import "MainTabBarController.h"
#import "MakeViewController.h"

#define TAB_BAR_HEIGHT 49   // UITabBar 49pt, border 0.5pt

@interface MainTabBarController ()

@property (nonatomic, weak) UIView *customTabBar;
@property (nonatomic, weak) UIButton *lastSelectedBtn;

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setViewControllers];      // TabBarController Setting
    [self setCustomTabBar];         // Custom TabBar Setting
}




// TabBarController Setting -----------------------------------//

- (void)setViewControllers {
    
    // Set ViewControllers
    
    // 메인 뷰
    UINavigationController *mainNaviVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MainNaviViewController"];
    
    // 지도 뷰
    UIStoryboard *mapStoryBoard = [UIStoryboard storyboardWithName:@"MapView" bundle:nil];
    UINavigationController *mapNaviVC = [mapStoryBoard instantiateViewControllerWithIdentifier:@"MapNaviViewController"];
    
    // 지도, 새핀 만들기 뷰
    MakeViewController *makeVC = [[MakeViewController alloc] initWithNibName:@"" bundle:nil];
    
    // set ViewControllers
    [self setViewControllers:@[mainNaviVC, mapNaviVC]];
    
}



// Custom TabBarController Setting ----------------------------//

- (void)setCustomTabBar {
    
    // CustomTabBar View & TopBorder Setting
    UIView *customTabBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-TAB_BAR_HEIGHT, self.view.bounds.size.width, TAB_BAR_HEIGHT)];
    customTabBar.backgroundColor = [UIColor whiteColor];
    self.customTabBar = customTabBar;

    UIView *customTabBarBorderLine = [[UIView alloc] initWithFrame:CGRectMake(0, customTabBar.bounds.origin.y-0.25f, self.view.bounds.size.width, 0.25f)];
    customTabBarBorderLine.backgroundColor = [UIColor lightGrayColor];

    [customTabBar addSubview:customTabBarBorderLine];
    [self.view addSubview:customTabBar];
    
    
    // @[<Label>, <Btn Img Name>, <Btn Selected Img Name>];
    NSArray *tabBarItemInfoArr = @[@[@"메인", @"tabMain", @"tabMainS"],
                                   @[@"지도", @"tabMap" , @"tabMapS" ]];
    
    [self addTabBarBtnWithImgNameArr:tabBarItemInfoArr];
}

- (void)addTabBarBtnWithImgNameArr:(NSArray *)arr {
    
    // arr.count 만큼 TabBarItem 세팅
    for (NSInteger i=0 ; i < arr.count ; i++) {
    
        // 버튼 객체 생성, 태그 및 Selector 설정
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        [btn addTarget:self action:@selector(selectedBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {       // 초기 첫번째 버튼이 선택되어 있음
            btn.selected = YES;
            self.lastSelectedBtn = btn;
        }
        
        // Btn ImageView & Label 세팅 -----------------------------//
        // Label setting
        [btn setTitle:arr[i][0] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor mm_warmGreyTwoColor] forState:UIControlStateNormal];
        [btn setTitle:arr[i][0] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor mm_brightSkyBlueColor] forState:UIControlStateSelected];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:11]];
        
        // Image setting
        [btn setImage:[UIImage imageNamed:arr[i][1]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:arr[i][2]] forState:UIControlStateSelected];
        [btn setContentMode:UIViewContentModeScaleAspectFit];
        
        // Btn ImageView & Label 재배치 ----------------------------//
        // ImageView와 Label간의 height space
        CGFloat spacing = 3.0;
        
        // lower the text and push it left so it appears centered
        // below the image
        CGSize imageSize = btn.imageView.image.size;
        btn.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
        
        // raise the image and push it right so it appears centered
        // above the text
        CGSize titleSize = [btn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: btn.titleLabel.font}];
        btn.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), 0.0, 0.0, - titleSize.width);
        
        // increase the content height to avoid clipping
        CGFloat edgeOffset = fabs(titleSize.height - imageSize.height) / 2.0;
        btn.contentEdgeInsets = UIEdgeInsetsMake(edgeOffset, 0.0, edgeOffset, 0.0);
        
        // Btn Frame 세팅 -----------------------------------------//
        CGFloat centerX = (self.customTabBar.bounds.size.width / (CGFloat)(arr.count * 2)) * (1 + (2 * i));

        [self.customTabBar addSubview:btn];
        
        btn.frame = CGRectMake(0, 0, self.customTabBar.bounds.size.width / (CGFloat)arr.count, 40);
        btn.center = CGPointMake(centerX, self.customTabBar.bounds.size.height/2);
        
    }
}



- (void)selectedBtn:(UIButton *)sender {
    
    if (sender.tag != self.lastSelectedBtn.tag) {
        self.lastSelectedBtn.selected = NO;     // 이전 선택된 버튼 set deselect
        sender.selected = YES;                  // 선택된 버튼 set select
        self.lastSelectedBtn = sender;          // 마지막으로 선택된 버튼으로 기억
        
        self.selectedIndex = sender.tag;        // 선택된 버튼에 맞춰 View appear

    } else {    // 이미 선택된 버튼 다시 한번 더 탭했을 때
        NSLog(@"이미 선택된 버튼 다시 한번 더 탭했을 때");
        [self.selectedViewController popToRootViewControllerAnimated:YES];
    }
}




@end
