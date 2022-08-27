# Wordle Guesser 

This app is a little project/example of how to create composable views in SwiftUI. The idea was to make a tool to see all of the possible remaining words after your first few Wordle guesses. Since this is a primarily English game I decided against moving text into a localizable string file.

<img src="https://user-images.githubusercontent.com/38142562/187044630-c87ac812-1de1-4a60-902a-680226fccd8d.png" width="250px">
<img src="https://user-images.githubusercontent.com/38142562/187044640-11381ebc-e2a2-4471-a57c-0f71c48c1df2.png" width="250px">
<img src="https://user-images.githubusercontent.com/38142562/187044643-2b9b6f3b-0d71-44a1-9752-948db42f4f7f.png" width="250px">
<img src="https://user-images.githubusercontent.com/38142562/187044647-a517bee6-49c4-4ed4-a69b-e660010046c6.png" width="250px">
<img src="https://user-images.githubusercontent.com/38142562/187044650-1eaae7a8-6d98-45df-ae5b-7b4bc421692d.png" width="250px">
<img src="https://user-images.githubusercontent.com/38142562/187044652-19173174-d257-410d-a6ca-50df0ed71d2f.png" width="250px">

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

