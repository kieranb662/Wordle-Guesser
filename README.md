#  How To Generate Screenshots 

This app uses fastlane and frameit for generating appstore screenshots of all sizes 

**Instructions** 
- Open Terminal
- Navigate to the root project folder 
- run `bundle exec fastlane snapshot --verbose`
- optionally run `bundle exec fastlane frameit download_frames` to download the needed frames
- run `bundle exec fastlane frameit `
- check the `screenshots/en_us` folder for the framed screeshots

