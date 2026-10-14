# UserFeedView

iOS Proof of Concept (POC) built using **SwiftUI** and structured under a decoupled **MVVM architecture**.


## 🛠️ Architecture & Directory Layout

The workspace is organized into feature-centric domains to maximize discoverability and scalability:

```text
UserFeedView/
├── Features/
│   ├── PostDetail/
│   │   ├── PostDetailView.swift       # Detail screen container
│   │   ├── PostDetailContentView.swift# Reusable editorial detailed card layout
│   │   └── PostDetailViewModel.swift  # Individual item business state
│   │
│   └── PostList/
│       ├── PostListView.swift         # Main feed dashboard view
│       ├── PostRowView.swift          # Custom layout for listing rows
│       ├── PostListViewModel.swift    # Feed processing & pagination state
│       └── AppErrorView.swift         # Backward-compatible custom error view
│
├── Services/
│   ├── NetworkManager.swift           # Native async/await API REST Client
│   └── JailbreakCheckService.swift    # Runtime safety & environment sandbox check
│
├── Models/
│   └── Post.swift                     # Structural Decodable model schemas
│
├── UserFeedViewApp.swift              # Application entrance pipeline configuration
└── Assets.xcassets                    # Graphical system branding assets
```

---

## 💻 Tech Stack & Environment

- **Language:** Swift 5.8+
- **UI Framework:** SwiftUI
- **Minimum Target Support:** iOS 16.0 / macOS Ventura 13.4
- **IDE:** Xcode 14.3.1

---

## App screens

<img width="300" height="600" alt="List" src="https://github.com/user-attachments/assets/943f3a88-6201-4f79-a8f2-0f79a645f9dd" />



<img width="200" height="600" alt="Detail" src="https://github.com/user-attachments/assets/18def374-a8d3-4e95-aa06-02876bb5d87b" />



