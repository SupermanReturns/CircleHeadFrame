//
//  ViewController.m
//  CircleHeadFrame
//
//  Created by Superman on 2018/7/25.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import "ViewController.h"
#import "RSKImageCropper.h"


//#import "RSKImageCropper/RSKImageCropper.h"

static const CGFloat kPhotoDiameter = 130.0f;
static const CGFloat kPhotoFrameViewPadding = 2.0f;

@interface ViewController () <RSKImageCropViewControllerDelegate>

@property (strong, nonatomic) UIView *photoFrameView;
@property (strong, nonatomic) UIButton *addPhotoButton;
@property (assign, nonatomic) BOOL didSetupConstraints;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.photoFrameView = [[UIView alloc] init];
    self.photoFrameView.backgroundColor = [UIColor colorWithRed:182/255.0f green:182/255.0f blue:187/255.0f alpha:1.0f];
    self.photoFrameView.translatesAutoresizingMaskIntoConstraints = NO;
    self.photoFrameView.layer.masksToBounds = YES;
    self.photoFrameView.layer.cornerRadius = (kPhotoDiameter + kPhotoFrameViewPadding) / 2;
    [self.view addSubview:self.photoFrameView];
    
    // ---------------------------
    // Add the button "add photo".
    // ---------------------------
    
    self.addPhotoButton = [[UIButton alloc] init];
    self.addPhotoButton.backgroundColor = [UIColor whiteColor];
    self.addPhotoButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.addPhotoButton.layer.masksToBounds = YES;
    self.addPhotoButton.layer.cornerRadius = kPhotoDiameter / 2;
    self.addPhotoButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.addPhotoButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.addPhotoButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.addPhotoButton setTitle:@"add\nphoto" forState:UIControlStateNormal];
    [self.addPhotoButton setTitleColor:[UIColor colorWithRed:0/255.0f green:122/255.0f blue:255/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [self.addPhotoButton addTarget:self action:@selector(onAddPhotoButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addPhotoButton];
    
    // ----------------
    // Add constraints.
    // ----------------
    
    [self.view setNeedsUpdateConstraints];
}
- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    if (self.didSetupConstraints) {
        return;
    }
    
    // ---------------------------
    // The frame of the photo.
    // ---------------------------
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self.photoFrameView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual
                                                                     toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f
                                                                   constant:(kPhotoDiameter + kPhotoFrameViewPadding)];
    [self.photoFrameView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:self.photoFrameView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual
                                                 toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f
                                               constant:(kPhotoDiameter + kPhotoFrameViewPadding)];
    [self.photoFrameView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:self.photoFrameView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual
                                                 toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f
                                               constant:0.0f];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:self.photoFrameView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual
                                                 toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0f
                                               constant:0.0f];
    [self.view addConstraint:constraint];
    
    // ---------------------------
    // The button "add photo".
    // ---------------------------
    
    constraint = [NSLayoutConstraint constraintWithItem:self.addPhotoButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual
                                                 toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f
                                               constant:kPhotoDiameter];
    [self.addPhotoButton addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:self.addPhotoButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual
                                                 toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f
                                               constant:kPhotoDiameter];
    [self.addPhotoButton addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:self.addPhotoButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual
                                                 toItem:self.photoFrameView attribute:NSLayoutAttributeCenterX multiplier:1.0f
                                               constant:0.0f];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:self.addPhotoButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual
                                                 toItem:self.photoFrameView attribute:NSLayoutAttributeCenterY multiplier:1.0f
                                               constant:0.0f];
    [self.view addConstraint:constraint];
    
    self.didSetupConstraints = YES;
}

#pragma mark - Action handling

- (void)onAddPhotoButtonTouch:(UIButton *)sender
{
    UIImage *photo = [UIImage imageNamed:@"photo"];
    RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:photo cropMode:RSKImageCropModeCircle];
    imageCropVC.delegate = self;
    [self.navigationController pushViewController:imageCropVC animated:YES];
}

#pragma mark - RSKImageCropViewControllerDelegate

- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage usingCropRect:(CGRect)cropRect
{
    [self.addPhotoButton setImage:croppedImage forState:UIControlStateNormal];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
