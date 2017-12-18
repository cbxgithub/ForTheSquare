//
//  GameViewController.m
//  ForTheSquare
//
//  Created by cbx on 2017/12/15.
//  Copyright © 2017年 cbx. All rights reserved.
//

#import "GameViewController.h"
#import <Masonry/Masonry.h>
#import "Box.h"
#import "GameCalue.h"
#import "BoxColor.h"
#import "CustomButton.h"
#import "RuleViewController.h"

static const CGFloat kMargin = 15.f;
static const CGFloat kLineSpacing = 1.0;
static NSString *const kBoxCell = @"boxcell";
#define kLineColor RGB(122, 122, 122)

@interface GameViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSUInteger boxDegree;   // 阶
    NSInteger stepCount;
}

@property (nonatomic, strong) UICollectionView *boxCollectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *boxLayout;

//@property (nonatomic, strong) UISegmentedControl *boxSegcontrol;

@property (nonatomic, strong) NSArray *boxDegreeArray;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSArray *boxColors;

@property (nonatomic, strong) UILabel *levelLabel;
@property (nonatomic, strong) UILabel *stepLabel;

@property (nonatomic, strong) CustomButton *backBtn;
@property (nonatomic, strong) CustomButton *ruleBtn;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self setupBtns];
    [self setupSeg];
    [self setupBox];
}

- (void)setupBtns {
    
    @weakify(self);
    [self.view addSubview:self.levelLabel];
    [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kMargin));
        make.top.equalTo(@50);
    }];
    
    [self.view addSubview:self.stepLabel];
    [self.stepLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-kMargin));
        make.top.equalTo(@50);
    }];
    
    [self.view addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(@(kMargin));
        make.bottom.equalTo(self.view).offset(-30);
        make.width.equalTo(@101);
        make.height.equalTo(@42);
    }];
    
    [self.view addSubview:self.ruleBtn];
    [self.ruleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(@(-kMargin));
        make.bottom.equalTo(self.view).offset(-30);
        make.width.equalTo(@101);
        make.height.equalTo(@42);
    }];
}

- (void)setupSeg {
    
    // 目前支持3-6阶数
//    _boxDegreeArray = @[@"3",@"4",@"5",@"6",@"7"];
//    _boxSegcontrol = [[UISegmentedControl alloc] initWithItems:_boxDegreeArray];
//    [self.view addSubview:_boxSegcontrol];
//    [_boxSegcontrol mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.mas_equalTo(85.f);
//        make.left.mas_equalTo(35.f);
//        make.right.mas_equalTo(-35.f);
//        make.height.mas_equalTo(40.f);
//    }];
//    _boxSegcontrol.tintColor = occupiedColor();
//    _boxSegcontrol.selectedSegmentIndex = 0;
//    [_boxSegcontrol addTarget:self action:@selector(degreeChange:) forControlEvents:UIControlEventValueChanged];
    [self setupDegree:self.level];
}

- (void)degreeChange:(UISegmentedControl *)segment {
    
    [self setupDegree:[_boxDegreeArray[segment.selectedSegmentIndex] integerValue]];
}

- (void)setupDegree:(NSUInteger )degree {
    
    // 初始化阶数
    boxDegree = degree;
    [self.dataSource removeAllObjects];
    for(int i = 0; i < pow(boxDegree, 2); i ++) {
        [self.dataSource addObject:@(NO)];
    }
    if(self.boxCollectionView) {
        [_boxCollectionView reloadData];
    }
}

- (void)setupBox {
    
    self.view.backgroundColor = RGB(249, 249, 249);
    _boxLayout = [[UICollectionViewFlowLayout alloc] init];
    _boxLayout.minimumLineSpacing = kLineSpacing;
    _boxLayout.minimumInteritemSpacing = kLineSpacing;
    _boxCollectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:self.boxLayout];
    _boxCollectionView.dataSource = self;
    _boxCollectionView.delegate = self;
    _boxCollectionView.backgroundColor = kLineColor;
    _boxCollectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_boxCollectionView];
    
    @weakify(self);
    [_boxCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.levelLabel.mas_bottom).offset(30);
        make.left.mas_equalTo(kMargin);
        make.right.mas_equalTo(-kMargin);
        make.height.equalTo(_boxCollectionView.mas_width);
    }];
    [_boxCollectionView registerClass:[Box class] forCellWithReuseIdentifier:kBoxCell];
    
    UIView *line_top = frameline();
    [self.view addSubview:line_top];
    UIView *line_left = frameline();
    [self.view addSubview:line_left];
    UIView *line_bottom = frameline();
    [self.view addSubview:line_bottom];
    UIView *line_right = frameline();
    [self.view addSubview:line_right];
    [line_top mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_boxCollectionView.mas_left);
        make.height.mas_equalTo(kLineSpacing);
        make.width.equalTo(_boxCollectionView.mas_width);
        make.bottom.equalTo(_boxCollectionView.mas_top);
    }];
    [line_left mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(line_top.mas_top);
        make.right.equalTo(_boxCollectionView.mas_left);
        make.width.mas_equalTo(kLineSpacing);
        make.bottom.equalTo(line_bottom.mas_top);
    }];
    [line_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_boxCollectionView.mas_bottom);
        make.left.equalTo(line_left.mas_left);
        make.right.equalTo(line_right.mas_left);
        make.height.mas_equalTo(kLineSpacing);
    }];
    [line_right mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_boxCollectionView.mas_right);
        make.top.equalTo(line_top.mas_top);
        make.width.mas_equalTo(kLineSpacing);
        make.bottom.equalTo(line_bottom.mas_bottom);
    }];
    
    // 多颜色选择
    //_boxColors = @[RGB(244, 89, 27),RGB(220, 82, 74),RGB(23, 145, 205),RGB(58, 219, 255),RGB(35, 160, 96),RGB(254, 205, 81),RGB(149, 156, 157)];
    _boxColors = @[@"244,89,27",@"220,82,74",@"23,145,205",@"58,219,255",@"35,160,96",@"254,205,81",@"149,156,157"];
    [self setupColorsView:_boxColors];
}

- (void)setupColorsView:(NSArray *)colors {
    
    CGFloat margin = 10.f;
    CGFloat colorWidthHeight = (kScreenWidth - margin * (colors.count + 1)) / colors.count;
    __block UIView *lastView = nil;
    [colors enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = idx;
        button.backgroundColor = transformColor(obj);
        [button addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        if(lastView) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(lastView.mas_right).with.offset(margin);
                make.top.equalTo(lastView);
                make.width.height.equalTo(lastView);
            }];
        }
        else {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo(margin);
                make.top.equalTo(_boxCollectionView.mas_bottom).with.offset(15.f);
                make.width.height.mas_equalTo(colorWidthHeight);
            }];
        }
        lastView = button;
    }];
}

- (void)changeColor:(UIButton *)sender {
    
    NSString *colorString = _boxColors[sender.tag];
    changeColor(colorString);
//    _boxSegcontrol.tintColor = occupiedColor();
    [_boxCollectionView reloadData];
}

UIView *frameline() {
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = kLineColor;
    return line;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return pow(boxDegree, 2);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = (CGRectGetWidth(collectionView.bounds) - kLineSpacing * (boxDegree - 1)) / boxDegree;
    CGFloat height = width;
    return CGSizeMake(width, height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Box *cell = (Box *)[collectionView dequeueReusableCellWithReuseIdentifier:kBoxCell forIndexPath:indexPath];
    BOOL isOccupyed = [self.dataSource[indexPath.row] boolValue];
    cell.backgroundColor = isOccupyed?occupiedColor():[UIColor whiteColor];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    stepCount++;
    self.stepLabel.text = [NSString stringWithFormat:@"步数：%ld",stepCount];

    NSArray *array = [NSArray arrayWithArray:self.dataSource];
    [self.dataSource removeAllObjects];
    [newBoxs(indexPath.row, array) enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self.dataSource addObject:obj];
    }];
    [_boxCollectionView reloadData];
    
    BOOL isSuccess = YES;
    for (id isOccupyed  in self.dataSource) {
        isSuccess = [isOccupyed boolValue];
        if (!isSuccess) {
            break;
        }
    }
    if (isSuccess) {
        //先判断是否破纪录
        //如果破纪录就存到数据库
        //如果没有什么也不做

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"恭喜你！过关了" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction: [UIAlertAction actionWithTitle:@"再玩一次" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self setupDegree:self.level];
            stepCount = 0;
            self.stepLabel.text = [NSString stringWithFormat:@"步数：%ld",stepCount];
        }]];
        [alert addAction: [UIAlertAction actionWithTitle:@"下一关" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.level+=1;
            [self setupDegree:self.level];
            stepCount = 0;
            self.stepLabel.text = [NSString stringWithFormat:@"步数：%ld",stepCount];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (NSMutableArray *)dataSource {
    
    if(!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}

- (NSInteger)level{
    if (_level < 3) {
        _level = 3;
    }
    return _level;
}

- (CustomButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [[CustomButton alloc] init];
        [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [_backBtn setTitleColor:RGB(74, 74, 74) forState:UIControlStateHighlighted];
        [_backBtn setTitleColor:RGB(155, 155, 155) forState:UIControlStateNormal];
        [[_backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    return _backBtn;
}

- (CustomButton *)ruleBtn {
    if (!_ruleBtn) {
        _ruleBtn = [[CustomButton alloc] init];
        [_ruleBtn setTitle:@"规则说明" forState:UIControlStateNormal];
        [_ruleBtn setTitleColor:RGB(74, 74, 74) forState:UIControlStateHighlighted];
        [_ruleBtn setTitleColor:RGB(155, 155, 155) forState:UIControlStateNormal];
        [[_ruleBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            RuleViewController *vc = [[RuleViewController alloc] init];
            vc.isFromGame = YES;
            [self presentViewController:vc animated:YES completion:nil];
        }];
    }
    return _ruleBtn;
}

- (UILabel *)levelLabel {
    if (!_levelLabel) {
        _levelLabel = [[UILabel alloc] init];
        _levelLabel.font = [UIFont systemFontOfSize:20];
        _levelLabel.textColor = RGB(97, 97, 97);
        _levelLabel.text = [NSString stringWithFormat:@"1-%ld",self.level];
    }
    return _levelLabel;
}

- (UILabel *)stepLabel {
    if (!_stepLabel) {
        _stepLabel = [[UILabel alloc] init];
        _stepLabel.font = [UIFont systemFontOfSize:20];
        _stepLabel.textColor = RGB(97, 97, 97);
        _stepLabel.text = [NSString stringWithFormat:@"步数：%ld",stepCount];
    }
    return _stepLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
