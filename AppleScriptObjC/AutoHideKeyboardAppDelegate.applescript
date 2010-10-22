--
--  AutoHideKeyboardAppDelegate.applescript
--  AutoHideKeyboard
--
--  Created by Eric Nitardy on 10/19/10.
--  Copyright 2010. 
--
global windowBounds, windowVisible, windowFrame, oldPanelFrame, autoHideTimer, appIsStarting, cancelPerformSelectorNotVisible

property windowAppName : "Axiotron Quickclicks"
property windowName : "Axiotron Quickclicks"
property hideTimerUnit : 0.5
property screenHeight : 800 -- get this and test it with a multimonitor setup

property autoHideDelay : 3
property hiddenPanelFrame : {origin:{x:131, y:318}, size:{|width|:240, height:110}}
property fadePanel : true

script AutoHideKeyboardAppDelegate
	property parent : class "NSObject"
	
	property CursorWhere : class "CursorWhere"
	
	---------- User interface code ---------------------------------------------	
	property NSColor : class "NSColor"
	
	property controlPanel : missing value
	property delaySlider : missing value
	property fadeRadioButton : missing value
	property quitButton : missing value
	-------------------------------------------------------------------------------
	
	---------- AppleScripting the window we want to AutoHide ----------	
	on makeWindowVisible()
		try
			--tell application windowAppName to show Keyboard
			tell application windowAppName to set visible of window windowName to true
			return true
		on error
			return false
		end try
	end makeWindowVisible
	
	on makeWindowNotVisible()
		try
			--tell application windowAppName to hide Keyboard
			tell application windowAppName to set visible of window windowName to false
			return true
		on error
			return false
		end try
	end makeWindowNotVisible
	
	on awakenWindow() -- Special handler for "Axiotron Quickclicks" (needed?)
		makeWindowNotVisible()
		makeWindowVisible()
	end awakenWindow
	
	on getWindowVisibility()
		tell application windowAppName
			return visible of window windowName
		end tell
	end getWindowVisibility
	
	on getWindowBounds()
		tell application windowAppName
			set rawBounds to bounds of window windowName
		end tell
		set point1 to {x:item 1 of rawBounds, y:item 2 of rawBounds}
		set point2 to {x:item 3 of rawBounds, y:item 4 of rawBounds}
		return {point1, point2}
	end getWindowBounds
	
	on noWindowPresent()
		tell application "System Events"
			activate
			display alert "No window " & "\"" & windowName & "\" of" & return & "application " & "\"" & windowAppName & "\"" & " present." message "The window this app is setup to AutoHide cannot be found." as warning
		end tell
		quit
	end noWindowPresent
	-------------------------------------------------------------------------------
	
	on convertBoundsToFrame(theBounds)
		set thePosition to {x:x of item 1 of theBounds, y:screenHeight - (y of item 2 of windowBounds)}
		set theSize to {|width|:(x of item 2 of theBounds) - (x of item 1 of theBounds), height:(y of item 2 of theBounds) - (y of item 1 of theBounds)}
		return {thePosition, theSize}
	end convertBoundsToFrame
	
	on makePanelNotVisible()
		current application's NSApp's hide_(me)
	end makePanelNotVisible
	
	on makePanelVisible()
		current application's NSApp's unhide_(me)
	end makePanelVisible
	
	on makePanelZoomToWindow()
		set windowBounds to getWindowBounds()
		set windowFrame to convertBoundsToFrame(windowBounds)
		set oldPanelFrame to controlPanel's frame
		
		log "zoom to vis"
		log oldPanelFrame
		controlPanel's setFrame_display_animate_(windowFrame, true, true)
		makeWindowVisible()
		performSelector_withObject_afterDelay_("makePanelNotVisible", missing value, 0.005)
	end makePanelZoomToWindow
	
	on makePanelUnZoomFromWindow()
		set windowBounds to getWindowBounds()
		set windowFrame to convertBoundsToFrame(windowBounds)
		controlPanel's setFrame_display_(windowFrame, false)
		makePanelVisible()
		makeWindowNotVisible()
		performSelector_withObject_afterDelay_("unZoomPanel", missing value, 0.005)
		--controlPanel's setFrame_display_animate_(oldPanelFrame, true, true)
	end makePanelUnZoomFromWindow
	
	on unZoomPanel()
		controlPanel's setFrame_display_animate_(oldPanelFrame, true, true)
	end unZoomPanel
	
	on loopForWindowVisible()
		if getWindowVisibility() is true then
			
			if appIsStarting is true or autoHideDelay is 14 then
				performSelector_withObject_afterDelay_("loopForWindowVisible", missing value, hideTimerUnit)
				return
			end if
			
			
			set windowBounds to getWindowBounds()
			if CursorWhere's isCursorOverBoundsFrom_To_(item 1 of windowBounds, item 2 of windowBounds) is 0 then
				--beep
				
				set autoHideTimer to autoHideTimer + hideTimerUnit
				if autoHideTimer ≥ autoHideDelay then
					log "timeout"
					log oldPanelFrame
					makePanelUnZoomFromWindow()
					my performSelector_withObject_afterDelay_("loopForWindowNotVisible", missing value, 6 * hideTimerUnit)
					return
				end if
			end if
			performSelector_withObject_afterDelay_("loopForWindowVisible", missing value, hideTimerUnit)
			return
		else -- Window Not Visible
			if appIsStarting is true then
				set appIsStarting to false
				set oldPanelFrame to controlPanel's frame
			end if
			log "not vis- unzoom"
			log oldPanelFrame
			makePanelUnZoomFromWindow()
			performSelector_withObject_afterDelay_("loopForWindowNotVisible", missing value, 6 * hideTimerUnit)
			return
		end if
	end loopForWindowVisible
	
	on loopForWindowNotVisible()
		if cancelPerformSelectorNotVisible is true then
			set cancelPerformSelectorNotVisible to false
			performSelector_withObject_afterDelay_("loopForWindowVisible", missing value, 0.005)
			return
		end if
		
		if getWindowVisibility() is true then
			set oldPanelFrame to controlPanel's frame
			log "Became vis vanish"
			log oldPanelFrame
			makePanelNotVisible()
			set autoHideTimer to 0.0
			performSelector_withObject_afterDelay_("loopForWindowVisible", missing value, hideTimerUnit)
			return
		end if
		--If  controlPanel's isOnActiveSpace() is 1 then 
		performSelector_withObject_afterDelay_("loopForWindowNotVisible", missing value, 5 * hideTimerUnit)
	end loopForWindowNotVisible
	
	on buttonPushed_(sender)
		set appIsStarting to false
		set cancelPerformSelectorNotVisible to true
		--my cancelPreviousPerformRequestsWithTarget_(me)
		makePanelZoomToWindow()
		set autoHideTimer to 0.0
	end buttonPushed_
	
	
	on applicationWillFinishLaunching_(aNotification)
		if CursorWhere's isCursorOverBoundsFrom_To_({x:100, y:100}, {x:500, y:500}) is 1 then beep
		if makeWindowVisible() is false then noWindowPresent() -- Put in awake nib ! and improve the quit in error !
		
		--set windowBounds to getWindowBounds()
		--set windowFrame to convertBoundsToFrame(windowBounds)
		set appIsStarting to true
		set cancelPerformSelectorNotVisible to false
		set autoHideTimer to 0.0
		set oldPanelFrame to controlPanel's frame
		--makePanelUnZoomFromWindow()
		--makePanelZoomToWindow()
		performSelector_withObject_afterDelay_("loopForWindowVisible", missing value, hideTimerUnit)
	end applicationWillFinishLaunching_
	
	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits 
		return current application's NSTerminateNow
	end applicationShouldTerminate_
	
	-------------------------------------------------------------------------------
	---------- User interface code from here down -------------------------
	-------------------------------------------------------------------------------	
	on awakeFromNib()
		controlPanel's setStyleMask_(72)
		controlPanel's setMovableByWindowBackground_(true)
		controlPanel's setLevel_(128)
		
		controlPanel's setBackgroundColor_(NSColor's colorWithDeviceHue_saturation_brightness_alpha_(0.15, 0.0, 0.85, 1.0))
		controlPanel's setCollectionBehavior_(1)
		
		log autoHideDelay
		set autoHideDelay to delaySlider's doubleValue()
		log autoHideDelay
		
		quitButton's highlight_(true)
	end awakeFromNib
	
	on changeDelaySlider_(sender)
		set autoHideDelay to sender's doubleValue()
		log autoHideDelay
	end changeDelaySlider_
	
	on applicationDidBecomeActive_(aNotification)
		controlPanel's setAlphaValue_(1.0)
		delaySlider's setHidden_(false)
	end applicationDidBecomeActive_
	
	on applicationDidResignActive_(aNotification)
		if fadeRadioButton's intValue() is 1 then
			controlPanel's setAlphaValue_(0.55)
		end if
		delaySlider's setHidden_(true)
	end applicationDidResignActive_
	
	on windowDidUpdate_(aNotification)
		set theFrame to (controlPanel's frame) as record
		--log fadeRadioButton's intValue()
		if (height of |size| of theFrame) < 100 or (width of |size| of theFrame) < 110 then
			delaySlider's setHidden_(true)
		else
			delaySlider's setHidden_(false)
		end if
	end windowDidUpdate_
	
	on quitApplication_(sender)
		quit
	end quitApplication_
	
	
end script
