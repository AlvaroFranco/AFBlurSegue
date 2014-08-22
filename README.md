AFBlurSegue
===========

![alt text](https://raw.github.com/AlvaroFranco/AFBlurSegue/master/img/new.gif "New") **Now supports iOS 8 *real time* blur and *rotation***

AFBlurSegue is a UIStoryboardSegue custom implementation that will blur the background of your modal view controller automatically.

![alt text](https://raw.github.com/AlvaroFranco/AFBlurSegue/master/img/preview.gif "Preview")

##Installation

![alt text](https://raw.github.com/AlvaroFranco/AFBlurSegue/master/img/download.gif "Download")

If you're using CocoaPods, just add this line to your Podfile:

	pod 'AFBlurSegue', '~> 1.2'
	
If you're not, import these files to your project:

	AFBlurSegue.h
	AFBlurSegue.m
	UIImage+ImageEffects.h
	UIImage+ImageEffects.h

##Usage
	
Since it's a Storyboard Segue custom implementation, you can start using it right from Storyboard. If you have your segue already created, just change it to Custom and the set AFBlurSegue as segue class.

![alt text](https://raw.github.com/AlvaroFranco/AFBlurSegue/master/img/usage2.png "Usage")

If you have to create your segue, create a new one by holding right click from the inital view controller to the destination view controller. It will appear a box like on the image below. Select "blur" and it will automatically will asign AFBlurSegue as segue class. Then set an identifier to the segue.

![alt text](https://raw.github.com/AlvaroFranco/AFBlurSegue/master/img/usage1.png "Usage")

For presenting the view controller, call ```-performSegueWithIdentifier:sender:```:

	[self performSegueWithIdentifier:@"blurSegue" sender:self];
	
##Customization

You can customize a few things such as the blur radius, tint color, saturation delta factor and modal transition style. To do this, import the class into your class:

	#import "AFBlurSegue.h"

For customizing it, let's use ```-prepareForSegue:sender:```

	-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        
    	UIViewController *destination = segue.destinationViewController;
    	destination.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

		AFBlurSegue *blurSegue = (AFBlurSegue *)segue;
		blurSegue.blurRadius = 20;
    	blurSegue.tintColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.1];
		blurSegue.saturationDeltaFactor = 0.5;
	}
	
**I highly recommend using *UIModalTransitionStyleCrossDissolve* or *UIModalTransitionCoverVertical* for better results. These animations looks really great with the blur effect.**
	
	
##Blur method

Since there's no public API already for blur effect, we have to find some workarounds. A lot of blurring classes are currently using the famous UIToolbar hack. Since UIToolbar have native blur, you can change its size and use it as a blur container. AFBlurSegue uses the UIImage+ImageEffects class provided by Apple. 

##License
AFBlurSegue is under MIT license so feel free to use it!

##Author
Made by Alvaro Franco. If you have any question, feel free to drop me a line at [alvarofrancoayala@gmail.com](mailto:alvarofrancoayala@gmail.com)
