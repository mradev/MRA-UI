MRA-UI
==============



A Collection of Core Graphics based UI Classes.


MRAViewSlider - Slider Class with a UIView based Cursor

MRALayerSlider - Slider Class with a CALayer based Cursor

MRAFillButton - Button Class crossed with a progress indicator

MRAIndicator - Progress Indicator

MRAResetButton - Reset style button

Includes iphone and ipad examples on the iphone and ipad storyboards


Build Instructions:
---------------------

git clone https://github.com/mradev/MRA-UI.git

Drag the MRA-UI.xcodeproj file from the Finder into your project (drop it in the Project Navigator pane on the left)

Go to project settings by clicking on your project's blue icon, then select the main target of your app under "Targets"

Under "Build Phases", then "Target Dependencies", click the plus icon and add MRAUI

Under "Build Phases", then "Link Binary With Libraries", click the plus icon to choose the frameworks/libraries we need to add. 
Add libMRAUI.a.


Under "Build Settings", find the entry "User Header Search Paths". Add a recursive entry for your base MRA-UI Directory