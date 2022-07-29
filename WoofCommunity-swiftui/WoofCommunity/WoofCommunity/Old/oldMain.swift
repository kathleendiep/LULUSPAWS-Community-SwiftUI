//struct MainFeed : View {
//    
//    // MARK: - Properties
//    @EnvironmentObject var session: SessionStore
//    @ObservedObject var postCardViewModel = PostCardViewModel()
//    @ObservedObject var postViewModel = PostViewModel()
//    @StateObject var mainViewModel = MainViewModel()
//    // append the user fetch here
//    @State var users: [User] = []
//    @State var posts: [Post] = []
//    
//    func loadAllUsers() {
//        // fetchUser
//        MainViewModel.fetchUser() {
//            
//            (users) in
//            
//            self.users = users
//            
//        }
//    }
//    
//    func getAllPosts() {
//        let db = Firestore.firestore()
//        
//        db.collection("allPosts").getDocuments() { (querySnapshot, error) in
//            if let error = error {
//                print("Error getting documents: \(error)")
//            } else {
//                for document in querySnapshot!.documents {
//                    print(" these are the posts \(document.documentID): \(document.data())")
//                    
//                    //                    self.posts.append(document.data())
//                    
//                    let dict = document.data()
//                    
//                    guard let decoder = try? Post.init(fromDictionary: dict) else {return}
//                    
//                    self.posts.append(decoder)
//                    
//                }
//            }
//        }
//    }
//    
//    
//    var body: some View{
//        ScrollView{
//            Text("Woof Community 🦴🏡")
//                .font(.headline)
//            VStack {
//                Text("Checkout some users! 🦴🏡")
//                    .font(.headline)
//                ForEach(self.users, id: \.id) {
//                    (user) in
//                    HStack{
//                        WebImage(url: URL(string: user.profileImageUrl)!)
//                            .resizable()
//                            .scaledToFit()
//                            .clipShape(Circle())
//                            .frame(width:100,height:100, alignment: .leading)
//                        
//                        Text("\(user.username)")
//                            .font(.caption)
//                        Text("\(user.humanName) ||\(user.petName) ")
//                            .font(.caption2)
//                    }
//                }
//                
//                Text("This is the posts")
//                ForEach(self.posts, id: \.id) {
//                    (post) in
//                    HStack{
//                        Text("This is the posts")
//                        Text("\(post.caption)")
//                            .font(.caption)
//                        PostCardImage(post: post)
//                        PostCard(post: post)
//                    }
//                }
//                
//            }
//            .navigationTitle("")
//            .navigationBarHidden(true)
//            .onAppear{
//                
//                //                self.loadAllPosts()
//                self.loadAllUsers()
//                
//            }
//        }
//    }
//    init() {
//        getAllPosts()
//        
//    }
//    
//    
//}
