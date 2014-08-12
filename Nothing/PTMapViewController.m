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

@property (nonatomic)PTFuncTableView *listView;
@end

@implementation PTMapViewController
@synthesize mapView = _mapView;
@synthesize listView = _listView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)configData{
    isRightBtnSelected = NO;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.mapView.showsUserLocation = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configData];
    
    
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showPopView:)];
    self.navigationItem.rightBarButtonItem = addItem;
    
//    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor yellowColor] forKey:UITextAttributeTextColor];
//    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.distanceFilter = 0.1;
    self.mapView.desiredAccuracy = kCLLocationAccuracyBest;
    self.mapView.delegate = self;
    self.mapView.userInteractionEnabled = YES;
    [self.mapView sizeToFit];
    [self.mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES];
    [self.view addSubview:self.mapView];
    
    
    self.listView = [[PTFuncTableView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, 64, 100, 0)];
    self.listView.funcDelegate = self;
    [self.view addSubview:self.listView];
    [self.view bringSubviewToFront:self.listView];
    
    [self addQuardCurveMenu];
}

- (void)showPopView:(id)sender{
    isRightBtnSelected = !isRightBtnSelected;
    if (isRightBtnSelected) {
        [UIView animateWithDuration:0.5 delay:0.1 options:UIViewAnimationOptionTransitionCurlDown animations:^{
             [self.listView setFrame:CGRectMake(self.view.frame.size.width - 100, 64, 100, 220)];
        } completion:nil];
    }else{
        [UIView animateWithDuration:0.5 delay:0.1 options:UIViewAnimationOptionTransitionCurlUp animations:^{
            [self.listView setFrame:CGRectMake(self.view.frame.size.width - 100, 64, 100, 0)];
        } completion:nil];
    }
}

#pragma mark - PTFuncTableViewDelegate
- (void)tableCellSelectedWithIndex:(NSIndexPath *)indexPath{
    NSLog(@"you selected indexRow:%ld",(long)indexPath.row);
    isRightBtnSelected = NO;
    [UIView animateWithDuration:0.5 delay:0.1 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        [self.listView setFrame:CGRectMake(self.view.frame.size.width - 100, 64, 100, 0)];
    } completion:nil];
}


/**
 *  添加菜单栏
 */
- (void)addQuardCurveMenu{
    UIImage *storyMenuItemImage = [UIImage imageNamed:@"bg-menuitem.png"];
    UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"bg-menuitem-highlighted.png"];
    
    // Camera MenuItem.
    QuadCurveMenuItem *cameraMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                                highlightedImage:storyMenuItemImagePressed
                                                                    ContentImage:[UIImage imageNamed:@"icon-star.png"]
                                                         highlightedContentImage:nil];
    // People MenuItem.
    QuadCurveMenuItem *peopleMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                                highlightedImage:storyMenuItemImagePressed
                                                                    ContentImage:[UIImage imageNamed:@"icon-star.png"]
                                                         highlightedContentImage:nil];
    // Place MenuItem.
    QuadCurveMenuItem *placeMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed
                                                                   ContentImage:[UIImage imageNamed:@"icon-star.png"]
                                                        highlightedContentImage:nil];
    // Music MenuItem.
    QuadCurveMenuItem *musicMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed
                                                                   ContentImage:[UIImage imageNamed:@"icon-star.png"]
                                                        highlightedContentImage:nil];
    // Thought MenuItem.
    QuadCurveMenuItem *thoughtMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                                 highlightedImage:storyMenuItemImagePressed
                                                                     ContentImage:[UIImage imageNamed:@"icon-star.png"]
                                                          highlightedContentImage:nil];
    
    NSArray *menus = [NSArray arrayWithObjects:cameraMenuItem, peopleMenuItem, placeMenuItem, musicMenuItem, thoughtMenuItem, nil];
    QuadCurveMenu *menu = [[QuadCurveMenu alloc] initWithFrame:self.view.bounds menus:menus];
    menu.delegate = self;
    [self.view addSubview:menu];
    [self.view bringSubviewToFront:menu];
}

#pragma mark- QuadCurveMenuDelegate
- (void)quadCurveMenu:(QuadCurveMenu *)menu didSelectIndex:(NSInteger)idx
{
    NSLog(@"Select the index : %d",idx);
}


#pragma mark - MAMapViewDelegate
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
