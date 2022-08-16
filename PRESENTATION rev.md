# WoofCommunity - Project Pitch 🦴🐶🐱🏡
// demo presentation notes
// https://fellowship.hackbrightacademy.com/materials/ios/resources/ios-ind-requirements/

// https://fellowship.hackbrightacademy.com/materials/wmt3/lectures/ios-demo-prep/ 

## Presentation Notes 

### ABOUT ME
Hello everyone, my name is Kathleen! 

    My passion for Software Engineering started when I built an e-commerce website for my business. I really enjoy developing projects through code and previously worked as a freelance web developer and am a full stack web development bootcamp grad. 
    
    software developer | entrepreneur  

### APP BACKGROUND
Today I'd like to share my app, LULUSPAWS Community. 

LULUSPAWS community is an app to allow users to connect & create a community with Pet Lovers through creating and sharing personal profiles and posts of their furry friends. 

##  REVIEW: TECH STACK & FEATURES
With this app, I used 
- SwiftUI. 

I wanted to take the challenge of learning databases with ios apps. 

I decided on FireBase as the database, because it allows real sync of data, quicker builds, thorough documentation, and made the Authentication process easier. 

### Firebase Database
- 🎥: Signup - when user signs up 
    - Users will be able to signup, signin, make profiles, and posts. 
    - To handle this, 
    - I created 2 view model files. 
        - 1. One being, StorageService - to save the firebase db to firebase storage 
        - 2. 2nd being AuthViewModel - this is the functions to create/sign in users to database and save it to Firestorage 
    
#### User Authentication
      - 🎥: SignIn - sign up, and press enter 
    - in the ViewModel, I created a function to allow users to be able to save username, email, and imageData to storage and database files:
                 Auth.auth().createUser 

            - 2. SignInViewModel
            - 🎥: SignIn - Sign in 
                - now that the user is created, let's sign in. 
            Firebase Database requires a collection & document id in order to save data. A challenge is making sure to match collection with the correct document id, 
                - I organized this by naming the collection: users & document after the userId which is uniquely auto generated. 
                          -   Firestore.firestore().collection("users).document(userId)
                - User will then be able to sign in if their userId goes through authentification process.
                    - Auth.auth().signIn() 
               
### User Profile 
- 🎥: Home Page > Show the profile, then cut to the new profile with user info
- From there a user will be able to edit their profile with their info 
    -  I made a ProfileViewModel: 
        - 1. There is a save/edit profile function
            -  they will be able to edit their info based from User model
        - Some challenges I faced with user profile:  
                - I took on challenge to read through learn and implement SDWebImageSwiftUI - SwiftUI Image Loading Framework to load photos 

### User Posts
- 🎥: Show Profile & Adding it here, Add a post and show on profile on the second 

- Another feature, is that a user can share posts about their pet. 

- Representing relationship between Users, Post, and Profile was a challenge, but I solved it by:
    - making a PostViewModel 
    - & creating a function
        - to make sure userId is current user 
        - then we follow the steps to:
            - 0. add to Firebase.firestore() db 
            - 1. add to posts collection 
            - 2. documentId 
            - 3. saves to our firebase storage
- Then posts should appear on our profile, because I added a loadUserPosts function onAppear to show users post 

### Search Users  
- 🎥: Search and then go to their profile 
- Users will be able to search via username 
- It was tricky to make a function to searchUser in the user collection in firebase. 
- A solution to this was to add whereField("username") is equal to users input in search bar 

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


#### This concludes my ios app demo on LULUSPAWS. Overall, I hope you enjoyed my demo and please feel free to check out the Github repo. 

