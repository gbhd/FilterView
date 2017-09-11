//
//  STListFilterView.h
//  my
//
//  Created by soso-mac on 2016/11/21.
//  Copyright © 2016年 soso-mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol STListFilterViewDelegate <NSObject>

@optional
-(void)g_setSelecetFilter:(id)result;
@required
@end

@interface STListFilterView : UIView
@property(assign,nonatomic)id<STListFilterViewDelegate>delegate;
@end
