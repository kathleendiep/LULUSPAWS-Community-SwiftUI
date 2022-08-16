# WoofCommunity - Project Pitch 🦴🐶🐱🏡
// demo presentation notes
// https://fellowship.hackbrightacademy.com/materials/ios/resources/ios-ind-requirements/

// https://fellowship.hackbrightacademy.com/materials/wmt3/lectures/ios-demo-prep/ 

## Presentation Notes 

### ABOUT ME
Hello everyone, my name is Kathleen and thanks for attending my app demo.

    My passion for Software Engineering started when I built an e-commerce website for my business. I really enjoy developing projects through code and previously worked as a freelance web developer and am a full stack bootcamp graduate. 
    
    software developer | entrepreneur  | full stack web development bootcamp 

### APP BACKGROUND

Today I'd like to share my app, LULUSPAWS Community. 

This app allows users to connect a community of Pet Lovers through creating personal profiles and posts of their furry friends. 

##  REVIEW: TECH STACK & FEATURES
With this app, I used 
- SwiftUI. 
      - 🎥: Showing Home > Profile >  Posts > 
I wanted to take the challenge of learning databases with ios apps so that users can create profile, posts, and search. 
      - 🎥: end at search > searching 
I decided on FireBase as the database, because it allows real sync of data, quicker builds, thorough documentation, and made the Authentication process easier. 

#### User Authentication
      - 🎥: Logout -> SignUp - sign up, and press enter 
    - First, Let's sign up. 
        - in order for this to happen, 
            - I created 2 view model files. 
                - 1. 1st - being StorageService to save data to the FirebaseStorage
                - 2. 2nd - being AuthViewModel - after reading the Firebase documentation, i learned that Firebase has built in Authorization functions like create user & signin, which would be included in this file

            - 2. SignInViewModel
            - 🎥: SignIn - Sign in 
                - now that the user is created, let's sign in. 
            Firebase requires a collection & document id in order to save user login data. The challenge was making sure to set up and organize the collection with the correct unique document id.
            
### User Profile 
- 🎥: Home Page > Show the profile > Edit >  then cut to the new profile with user info
- From there a user will be able to edit their profile based on the User model that I set up in the viewmodel.
                - I took on challenge to read through learn and implement SDWebImageSwiftUI - this framework allows the user to upload photos from their iphone. 

### User Posts
- 🎥: Show Profile & highlight adding posts 
- Another feature, is that a user can share posts. 
- Representing relationship between Users, Post, and Profile was a challenge, but I solved it by:
    - including a function that follows:
            - 1. makes sure userId is the current user 
            - 2. add to Firebase db 
            - 3. then add to posts collection and the corresponding documentId 
            - 4. this then should save to our firebase storage so that we can fetch it later
            
- 🎥: > show on profile on the second
- It was tricky to fetch all posts on profile, but I added a function onAppear to show users post 

### Search Users  
- 🎥: Search, results, and then go to their profile 
- Users will be able to search via username, and it was tricky to filter the results, but after trial and error, I came up with a solution to capture the users input in search bar and match to usernames array.

        ### MapKit 
        - 🎥: Showing MapKit 
        - I was able to implement MapKit and Corelocation, and get User's location. 
        - In the future, I'd like to tweak the MapKit to allow users to pop up based on a location. 

### FEATURES
- SwiftUI
- Firebase Database
- User Authentication
- Create User Profile
- SDWebImageSwiftUI 
- Post Photos 
- Search Users  
- MapKit


#### This concludes my ios app demo on LULUSPAWS. I hope you enjoyed my demo and please feel free to check out the Github repo. Thank you again for your time! 

