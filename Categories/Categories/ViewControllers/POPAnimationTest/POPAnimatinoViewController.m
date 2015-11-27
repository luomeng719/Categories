//
//  POPAnimatinoViewController.m
//  Categories
//
//  Created by luomeng on 15/11/26.
//  Copyright © 2015年 luomeng. All rights reserved.
//

#import "POPAnimatinoViewController.h"
#import "POP.h"

@interface POPAnimatinoViewController ()
@property (weak, nonatomic) IBOutlet UIButton *basicBtn;
@property (weak, nonatomic) IBOutlet UIButton *decayBtn;
@property (weak, nonatomic) IBOutlet UIButton *springBtn;
@property (weak, nonatomic) IBOutlet UIButton *rotationBtn;

@end

@implementation POPAnimatinoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.title = NSLocalizedString(@"Animation", nil);
    
    [self configBtns];
}

- (void)configBtns {
    self.basicBtn.backgroundColor = [UIColor cyanColor];
    CGRect basicBounce = self.basicBtn.bounds;
    self.basicBtn.layer.cornerRadius = basicBounce.size.width / 2;
    self.basicBtn.clipsToBounds = YES;
    
    self.decayBtn.backgroundColor = [UIColor lightGrayColor];
    CGRect decayBounce = self.decayBtn.bounds;
    self.decayBtn.layer.cornerRadius = decayBounce.size.width / 2;
    self.decayBtn.clipsToBounds = YES;
    
    self.springBtn.backgroundColor = [UIColor greenColor];
    CGRect springBounce = self.springBtn.bounds;
    self.springBtn.layer.cornerRadius = springBounce.size.width / 2;
    self.springBtn.clipsToBounds = YES;
    
    self.rotationBtn.layer.anchorPoint = CGPointMake(0.5, 0);
}

- (IBAction)basicAnimationAction:(id)sender {
    CGPoint prePoint = self.basicBtn.center;
    POPBasicAnimation *basicAnimation = [POPBasicAnimation easeInEaseOutAnimation];
    basicAnimation.property = [POPAnimatableProperty propertyWithName:kPOPLayerPosition];
    basicAnimation.duration = 1.0f;
    basicAnimation.fromValue = [NSValue valueWithCGPoint:prePoint];
    basicAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMaxX(self.view.frame), CGRectGetMaxY(self.view.frame))];
    
    __weak POPAnimatinoViewController *weakSelf = self;
    [basicAnimation setCompletionBlock:^(POPAnimation *anim, BOOL flag) {
        POPBasicAnimation *backAnimation = [POPBasicAnimation linearAnimation];
        backAnimation.property = [POPAnimatableProperty propertyWithName:kPOPLayerPosition];
        backAnimation.duration = 1.0f;
        backAnimation.fromValue = [NSValue valueWithCGPoint:weakSelf.basicBtn.center];
        backAnimation.toValue = [NSValue valueWithCGPoint:prePoint];
        [weakSelf.basicBtn pop_addAnimation:backAnimation forKey:@"backAnimation"];
    }];
    
    [self.basicBtn pop_addAnimation:basicAnimation forKey:@"basicBtnBasicAnimation"];
}

- (IBAction)decayAnimationAction:(id)sender {
    POPDecayAnimation *decayAnimation = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPosition];
    decayAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(0, 600)];
    
    [decayAnimation setCompletionBlock:^(POPAnimation *anima, BOOL flag) {
        POPDecayAnimation *backAnimation = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPosition];
        backAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(0, -600)];
        [self.decayBtn.layer pop_addAnimation:backAnimation forKey:@"decayBackAnimation"];
    }];
    
    [self.decayBtn.layer pop_addAnimation:decayAnimation forKey:@"decayAnimation"];
}

- (IBAction)springAnimationAction:(id)sender {
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    springAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(2.0f, 2.0f)];
    springAnimation.springSpeed = 20;
    springAnimation.springBounciness = 20.0f;
    
    [springAnimation setCompletionBlock:^(POPAnimation *anima, BOOL flag) {
        NSLog(@"endTime:%@", [NSDate new]);
        POPSpringAnimation *backAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        backAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.0f, 1.0f)];
        backAnimation.springSpeed = 20.0f;
        backAnimation.springBounciness = 20.0f;
        [self.springBtn.layer pop_addAnimation:backAnimation forKey:@"springBackAnimation"];
    }];
    [self.springBtn.layer pop_addAnimation:springAnimation forKey:@"springBigAnimation"];
    NSLog(@"startTime:%@", [NSDate new]);

}

- (IBAction)rotationAnimationAction:(id)sender {
    
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    springAnimation.toValue = @(2.8);
    springAnimation.springBounciness = 20.0f;
    springAnimation.springSpeed = 20.0f;
    
    [springAnimation setCompletionBlock:^(POPAnimation *anima, BOOL flag) {
        POPSpringAnimation *backAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
        backAnimation.toValue = @(-0.3);
        backAnimation.springSpeed = 20.0f;
        backAnimation.springBounciness = 20.0f;
        [self.rotationBtn.layer pop_addAnimation:backAnimation forKey:@"backAnimation"];
    }];
    [self.rotationBtn.layer pop_addAnimation:springAnimation forKey:@"rotationAnimation"];
    
    
//    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"transform"];
//    CATransform3D transform = self.rotationBtn.layer.transform;
//    transform = CATransform3DRotate(transform, 2.6, 0.0, 0.0, 1.0);
//    animation.toValue = [NSValue valueWithCATransform3D:transform];
//    animation.damping = 300;
//    animation.duration = 3;
//    animation.stiffness = 30;
////    self.rotationBtn.layer.transform = transform;
//    [self.rotationBtn.layer addAnimation:animation forKey:@"transform"];
    
}

@end
