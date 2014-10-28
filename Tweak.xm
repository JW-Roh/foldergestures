
@interface SBIconListView : UIView
- (id)iconAtPoint:(CGPoint)fp8 index:(NSUInteger *)fp16;
@end
@interface SBFolderIconListView : SBIconListView @end

@interface SBFolderView : UIView
- (SBFolderIconListView *)currentIconListView;
@end
@interface SBFloatyFolderView : SBFolderView @end


%hook SBFloatyFolderView

// part of "7Folder Relayout" ($0.99)
- (BOOL)_tapToCloseGestureRecognizer:(UITapGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
	BOOL rtn = %orig;
	
	if (!rtn) {
		SBFolderIconListView *listView = [self currentIconListView];
		CGPoint p = [touch locationInView:listView];
		NSUInteger index = 0;
		id icon = [listView iconAtPoint:p index:&index];
		
		if (icon == nil) rtn = YES;
	}
	
	return rtn;
}

%end


%hook SBFolderSettings

- (BOOL)allowNestedFolders {
	return YES;
}
- (BOOL)pinchToClose {
	return YES;
}

%end
