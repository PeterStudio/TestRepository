//
//  PTMapViewController.m
//  Nothing
//
//  Created by dw on 14-8-8.
//  Copyright (c) 2014年 dw. All rights reserved.
//

#import "PTMapViewController.h"
#import <MAMapKit/MAMapKit.h>



@interface PTMapViewController ()<MAMapViewDelegate>

@property(nonatomic,strong) MAMapView *mapView;
@end

@implementation PTMapViewController
@synthesize mapView = _mapView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.mapView.showsUserLocation = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.distanceFilter = 0.1;
    self.mapView.desiredAccuracy = kCLLocationAccuracyBest;
    self.mapView.delegate = self;
    self.mapView.userInteractionEnabled = YES;
    [self.mapView sizeToFit];
    [self.mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES];
    [self.view addSubview:self.mapView];
    
}


- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    NSLog(@"location:%f",userLocation.coordinate.latitude);
    [self.mapView setCenterCoordinate:userLocation.coordinate];
    userLocation.title = @"这是我的位置";
    
}


- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    
}


#pragma mark - MAMapViewDelegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAUserLocation class]]) {
        // 当前用户定位展示
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        
        annotationView.canShowCallout               = YES;
        annotationView.animatesDrop                 = YES;
        annotationView.draggable                    = YES;
        annotationView.rightCalloutAccessoryView    = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        //        annotationView.pinColor                     = [self.annotations indexOfObject:annotation];
        
        return annotationView;
    }
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        //        static NSString *customReuseIndetifier = @"customReuseIndetifier";
        //
        //        CustomAnnotationView *annotationView = (CustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
        //
        //        if (annotationView == nil)
        //        {
        //            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:customReuseIndetifier];
        //            // must set to NO, so we can show the custom callout view.
        //            annotationView.canShowCallout = NO;
        //            annotationView.draggable = YES;
        //            annotationView.calloutOffset = CGPointMake(0, -5);
        //        }
        //
        //        annotationView.portrait = [UIImage imageNamed:@"hema.png"];
        //        annotationView.name     = @"河马";
        //
        //        return annotationView;
    }
    
    return nil;
}

#pragma mark - Action Handle

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    NSLog(@"view:%@",view);
    /* Adjust the map center in order to show the callout view completely. */
    //    if ([view isKindOfClass:[CustomAnnotationView class]]) {
    //        CustomAnnotationView *cusView = (CustomAnnotationView *)view;
    //        CGRect frame = [cusView convertRect:cusView.calloutView.frame toView:self.mapView];
    //
    //        frame = UIEdgeInsetsInsetRect(frame, UIEdgeInsetsMake(kCalloutViewMargin, kCalloutViewMargin, kCalloutViewMargin, kCalloutViewMargin));
    //
    //        if (!CGRectContainsRect(self.mapView.frame, frame))
    //        {
    //            /* Calculate the offset to make the callout view show up. */
    //            CGSize offset = [self offsetToContainRect:frame inRect:self.mapView.frame];
    //
    //            CGPoint theCenter = self.mapView.center;
    //            theCenter = CGPointMake(theCenter.x - offset.width, theCenter.y - offset.height);
    //
    //            CLLocationCoordinate2D coordinate = [self.mapView convertPoint:theCenter toCoordinateFromView:self.mapView];
    //            
    //            [self.mapView setCenterCoordinate:coordinate animated:YES];
    //        }
    //        
    //    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
