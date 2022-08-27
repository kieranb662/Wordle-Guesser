# Wordle Guesser 

This app is a little project/example of how to create composable views in SwiftUI. The idea was to make a tool to see all of the possible remaining words after your first few Wordle guesses. Since this is a primarily English game I decided against moving text into a localizable string file.

**Intended Use** 



**Technical Stuff** 




# How To Generate Screenshots 

This app uses fastlane and frameit for generating appstore screenshots of all sizes 

**Instructions** 
- Open Terminal
- Navigate to the root project folder 
- run `bundle exec fastlane snapshot --verbose`
- optionally run `bundle exec fastlane frameit download_frames` to download the needed frames
- run `bundle exec fastlane frameit `
- check the `screenshots/en_us` folder for the framed screeshots

