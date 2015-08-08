//
//  ViewController.m
//  RunningLED
//
//  Created by Do Minh Hai on 8/7/15.
//  Copyright (c) 2015 Do Minh Hai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    CGFloat _margin; //>ball radius
    int _numberOfBall;
    CGFloat _space; //>ballDiameter
    CGFloat _space2;
    CGFloat _ballDiameter;
    int _numberOfBall2;
    NSTimer *_timer;
    int lastOnLED;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _margin = 50 ;
    _ballDiameter =50 ;
    lastOnLED = -1;
    [self checkSizeOfApp];
    //[self placeGreenBallAtX:100 andY:100 withTag:1] ;
    [self numberOfBallvsSpace];
    [self drawRowOfBalls];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(runningLED) userInfo:nil repeats:true];
    
   }
-(void) runningLED {
    _numberOfBall=([self numberOfBallvsSpace]* [self numberOfBallvsSpace2]);
    if (lastOnLED!=-1) {
        [self turnOffLED:lastOnLED];
    }
    if (lastOnLED!=_numberOfBall-1) {
        lastOnLED++;
    }else{
        lastOnLED=0;
    }
    [self turnOnLED:lastOnLED];
}
-(void) turnOnLED: (int) index
{
    UIView* view = [self.view viewWithTag:index +100];
    if (view && [view isMemberOfClass:[UIImageView class]]) {
        UIImageView* ball = (UIImageView*) view;
        ball.image = [UIImage imageNamed:@"red"];
    }
    
}
-(void) turnOffLED: (int) index
{
    UIView* view = [self.view viewWithTag:index +100];
    if (view && [view isMemberOfClass:[UIImageView class]]) {
        UIImageView* ball = (UIImageView*) view;
        ball.image = [UIImage imageNamed:@"green"];
    }
}
-(void) placeGreenBallAtX: (CGFloat) x
                     andY: (CGFloat) y
                  withTag: (int)tag
{
    UIImageView* ball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"green"]];
    ball.center = CGPointMake(x, y);
    ball.tag = tag ;
    [self.view addSubview:ball];
    
    NSLog(@"w=%3.0f, h=%3.0f", ball.bounds.size.width, ball.bounds.size.height);
}
-(CGFloat) spaceBetweenBallCenterWhenNumberBallIsKnow: (int) n {
    return(self.view.bounds.size.width -2* _margin) / ( n - 1 );
}
-(CGFloat) spaceBetweenBallCenterWhenNumberBallIsKnow2: (int) n {
    return(self.view.bounds.size.height -2* _margin) / ( n - 1 );
}
-(int) numberOfBallvsSpace{
    bool stop = false;
    int n =3 ;
    while(!stop){
        CGFloat space = [self spaceBetweenBallCenterWhenNumberBallIsKnow: n];
        if (space< _ballDiameter) {
            stop = true;
        }else
        {
            NSLog(@"Number of ball %d, space between ball center %3.0f",n , space);
        }
        n++;
    }
    return n-1;

}

-(int) numberOfBallvsSpace2{
    bool stop = false;
    int n =3 ;
    while(!stop){
        CGFloat space2 = [self spaceBetweenBallCenterWhenNumberBallIsKnow2: n];
        if (space2< _ballDiameter) {
            stop = true;
        }else
        {
            NSLog(@"Number of ball %d, space between ball center %3.0f",n , space2);
        }
        n++;
    }
    return n-1;
    
}
-(void) drawRowOfBalls
{
    int m=0 ;
    int a=0 ;
    int b=[self numberOfBallvsSpace]-1;
    int c=[self numberOfBallvsSpace]+[self numberOfBallvsSpace2]-2;
    int d=[self numberOfBallvsSpace]*2 + [self numberOfBallvsSpace2] -3 ;
    int i1=0 ,i2=0 ,i3=0 ,i4=0;
    int k=[self numberOfBallvsSpace2];
    int sobong= [self numberOfBallvsSpace]*[self numberOfBallvsSpace2];
    int numberBalls = [self numberOfBallvsSpace];
    CGFloat space = [self spaceBetweenBallCenterWhenNumberBallIsKnow:numberBalls];
    int numberBalls2 = [self numberOfBallvsSpace2];
    CGFloat space2 = [self spaceBetweenBallCenterWhenNumberBallIsKnow2:numberBalls2];
    int tong= [self numberOfBallvsSpace2]+ [self numberOfBallvsSpace];
    for (m=0; m<sobong; m++) {
        
        if (m<b && m>=a) {
            [self placeGreenBallAtX:_margin + (m-a+i1)*space
                               andY:_margin+i1*space2
                            withTag:m+100];
        }
        if(m==b)
        {
            a=a+2*(tong-4*i1)-4;
            i1++;
        }
        if (m<c && m>=b){
            
            [self placeGreenBallAtX:_margin + (numberBalls-1-i2)*space
                               andY:_margin + (m-b+i2)*space2
                            withTag:m+100];}
        if(m==c)
        {
            b=b+2*(tong-4*i2)-6;
            i2++;
        }
        if (m<d && m>=c) {
            [self placeGreenBallAtX:_margin + (d-m+i3)*space
                               andY:_margin+(numberBalls2-i3-1)*space2
                            withTag:m+100];
        }
        if(m==d)
        {
            c=c+2*(tong-4*i3)-8;
            i3++;
        }
        if (m<a && m>=d){
            
            [self placeGreenBallAtX:_margin + i4*space
                               andY:_margin + (a-m+i4)*space2
                            withTag:m+100];}
        if(m==(a-1))
        {
            d=d+2*(tong-4*i4)-10;
            i4++;
        }
        
        
    
    
    }
}


-(void) checkSizeOfApp {
    CGSize size = self.view.bounds.size;
    NSLog(@"width= %3.0f, height = %3.0f", size.width , size.height);
}



@end
