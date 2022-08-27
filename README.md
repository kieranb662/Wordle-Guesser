# Wordle Guesser 

This app is a little project/example of how to create composable views in SwiftUI. The idea was to make a tool to see all of the possible remaining words after your first few Wordle guesses. Since this is a primarily English game I decided against moving text into a localizable string file.

**What The App Does** 

<table>
<tr>
<td> <img src="https://user-images.githubusercontent.com/38142562/187044630-c87ac812-1de1-4a60-902a-680226fccd8d.png"> </td>
<td> <img src="https://user-images.githubusercontent.com/38142562/187044640-11381ebc-e2a2-4471-a57c-0f71c48c1df2.png"> </td>
<td> <img src="https://user-images.githubusercontent.com/38142562/187044643-2b9b6f3b-0d71-44a1-9752-948db42f4f7f.png"> </td>
</tr>
<tr>
<td> <img src="https://user-images.githubusercontent.com/38142562/187044647-a517bee6-49c4-4ed4-a69b-e660010046c6.png"> </td>
<td> <img src="https://user-images.githubusercontent.com/38142562/187044650-1eaae7a8-6d98-45df-ae5b-7b4bc421692d.png"> </td>
<td> <img src="https://user-images.githubusercontent.com/38142562/187044652-19173174-d257-410d-a6ca-50df0ed71d2f.png"> </td>
<tr>
</table>


**Technical Stuff** 

- [x] light/dark mode support
- [x] Automated screen shotting
- [x] Haptics 
- [x] Animations 
- [x] Transitions 
- [x] Heavy use of Regex and string parsing  
- [x] iPhone supported
- [x] iPad supported


# How To Generate Screenshots 

This app uses fastlane and frameit for generating appstore screenshots of all sizes 

**Instructions** 
- Open Terminal
- Navigate to the root project folder 
- run `bundle exec fastlane snapshot --verbose`
- optionally run `bundle exec fastlane frameit download_frames` to download the needed frames
- run `bundle exec fastlane frameit `
- check the `screenshots/en_us` folder for the framed screeshots

**Note** 

Transitions need to be disabled for screenshots to work properly, otherwise the views will not be in the hierarchy for the UI automation

# Enhancement Ideas/Practice Problems

This App is ready for anyone to use as a base for learning from. A few fun practice ideas are

- [Create an App Clip](https://developer.apple.com/app-clips/)
- [Make some Widgets](https://developer.apple.com/documentation/widgetkit/)
- Add a transition for when a letter is selected
- Try to find some bugs (maybe some inputs don't give the correct remaining guesses?)
- Redesign the UI for a macCatalyst app

