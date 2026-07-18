# 🏦 Ganapathi Bank

A modern iOS banking application built with **SwiftUI**, **Swift Concurrency**, **Clean Architecture**, and **Test-Driven Development (TDD)**.

Ganapathi Bank is an enterprise-inspired learning project focused on building production-quality iOS applications using modern Apple technologies and software engineering best practices. Rather than concentrating only on features, the project emphasizes architecture, maintainability, scalability, and testability.

---

## ⭐ Highlights

- Modern SwiftUI Application
- Clean Architecture
- Repository Pattern
- Dependency Injection
- SOLID Principles
- Swift Concurrency (async/await)
- Generic Networking Layer
- Test-Driven Development (TDD)
- SwiftData (Offline Persistence)
- Enterprise Project Structure
- Highly Testable Design
- Scalable Architecture

---

## 📱 Screenshots

> Screenshots will be added as the project evolves.

---

# 🎯 Project Goals

The primary objective of Ganapathi Bank is to understand how enterprise iOS applications are designed and built.

The project focuses on:

- Building scalable architecture
- Applying SOLID principles
- Writing maintainable and testable code
- Understanding modern SwiftUI
- Learning Swift Concurrency
- Implementing offline persistence
- Practicing Test-Driven Development
- Exploring production-ready design patterns

---

# 🏗️ Architecture

The application follows a layered architecture where every layer has a single responsibility.

```text
                SwiftUI View
                     │
                     ▼
                ViewModel
                     │
                     ▼
            AccountsRepository
                     │
          DefaultAccountsRepository
             ▲                  ▲
             │                  │
RemoteDataSource        LocalDataSource
             │                  │
             ▼                  ▼
      REST API             SwiftData
```

Each layer communicates only through abstractions, making the application modular, testable, and easy to extend.

---

# 📂 Project Structure

```
GanapathiBank
│
├── Presentation
│   ├── Views
│   ├── ViewModels
│
├── Domain
│   ├── Entities
│   ├── Repositories
│   ├── DataSources
│
├── Infrastructure
│   ├── Networking
│   ├── Persistence
│
├── Resources
│
└── Tests
    ├── ViewModelTests
    ├── RepositoryTests
    ├── NetworkingTests
```

---

# 🧩 Features

## Networking

- Generic API Client
- Endpoint Abstraction
- Async/Await
- URLSession
- DTO Mapping
- Error Handling
- Dependency Injection

---

## Persistence *(Work In Progress)*

- SwiftData
- Local Data Source
- Entity Mapping
- Offline Cache
- Repository Coordination

---

## User Interface

- SwiftUI
- Observation Framework
- NavigationStack
- Loading States
- Error States
- Async Data Loading

---

## Testing

- XCTest
- Mock API Client
- Mock URLProtocol
- ViewModel Tests
- Repository Tests
- API Client Tests

---

# 🛠 Technologies

- Swift 6
- SwiftUI
- Swift Concurrency
- Observation Framework
- SwiftData
- URLSession
- XCTest

---

# 📐 Software Engineering Principles

The project follows modern software engineering practices including:

- SOLID Principles
- Clean Architecture
- Dependency Injection
- Separation of Concerns
- Repository Pattern
- Composition over Inheritance
- Protocol-Oriented Programming
- Testable Design

---

# 🌐 Networking Flow

```
SwiftUI View

        │

        ▼

 ViewModel

        │

        ▼

AccountsRepository

        │

        ▼

RemoteDataSource

        │

        ▼

APIClient

        │

        ▼

REST API
```

---

# 💾 Persistence Flow

```
SwiftUI View

        │

        ▼

 ViewModel

        │

        ▼

AccountsRepository

        │

        ▼

LocalDataSource

        │

        ▼

SwiftData
```

---

# 🧪 Testing Philosophy

The project follows a behavior-driven testing approach.

Every layer is tested independently using dependency injection and test doubles.

Current test coverage includes:

- ViewModel behavior
- Repository behavior
- API Client
- Network error handling
- DTO mapping
- URLSession mocking using URLProtocol

---

# 🚀 Current Progress

| Module | Status |
|---------|--------|
| Generic Networking Layer | ✅ Completed |
| API Client | ✅ Completed |
| Endpoint Abstraction | ✅ Completed |
| Repository Pattern | ✅ Completed |
| Dependency Injection | ✅ Completed |
| Unit Testing | ✅ Completed |
| URLProtocol Mocking | ✅ Completed |
| SwiftData Integration | 🚧 In Progress |
| Offline First Architecture | 🚧 Planned |
| GraphQL | ⏳ Planned |
| Pagination | ⏳ Planned |
| Push Notifications | ⏳ Planned |
| Feature Flags | ⏳ Planned |

---

# 📚 Roadmap

The project will continue evolving with enterprise-level features including:

- SwiftData Persistence
- Offline First Architecture
- GraphQL Integration
- Pagination
- Secure Keychain Storage
- Biometric Authentication
- Feature Flags
- Push Notifications
- Modular Architecture using Swift Package Manager
- Performance Optimization
- Analytics

---

# 🎓 Learning Objectives

Ganapathi Bank is intentionally built as a long-term engineering project to gain hands-on experience with:

- Modern SwiftUI
- Swift Concurrency
- Clean Architecture
- Repository Pattern
- SwiftData
- GraphQL
- Unit Testing
- Software Design Patterns
- Enterprise iOS Development

---

# 🤝 Acknowledgements

This project represents my continuous journey toward mastering modern iOS development and software architecture.

Every module is built with a strong emphasis on understanding the reasoning behind architectural decisions rather than simply implementing features.

The goal is to write code that is scalable, maintainable, testable, and aligned with production-grade engineering practices.

---

# 📄 License

This project is intended for educational and learning purposes.
