////
////  FirestoreManager.swift
////  MonuMap
////
////  Created by Sebastian Presno on 09/11/24.
////
//
//import FirebaseAuth
//import FirebaseFirestore
//import Foundation
//
//class FirestoreManager {
//    private let db = Firestore.firestore()
//
//    // MARK: - User Operations
//
//    /// Registers a new user with Firebase Authentication and stores additional user data in Firestore.
//    func registerUser(email: String, password: String, username: String, name: String, surname: String, completion: @escaping (Result<Void, Error>) -> Void) {
//        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            guard let userID = authResult?.user.uid else {
//                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User ID not found."])))
//                return
//            }
//
//            let user = User(username: username, email: email, name: name, surname: surname)
//
//            do {
//                try self.db.collection("users").document(userID).setData(from: user) { error in
//                    if let error = error {
//                        completion(.failure(error))
//                    } else {
//                        completion(.success(()))
//                    }
//                }
//            } catch let error {
//                completion(.failure(error))
//            }
//        }
//    }
//
//    /// Fetches a user by their Firestore document ID.
//    func fetchUser(withId id: String, completion: @escaping (Result<User, Error>) -> Void) {
//        db.collection("users").document(id).getDocument { document, error in
//            if let document = document, document.exists {
//                let result = Result { try document.data(as: User.self) }
//                completion(result)
//            } else {
//                completion(.failure(error ?? NSError(domain: "", code: -1, userInfo: nil)))
//            }
//        }
//    }
//
//    // MARK: - Monument Operations
//
//    /// Creates a new monument document in Firestore.
//    func createMonument(monument: Monument, completion: @escaping (Result<Void, Error>) -> Void) {
//        do {
//            let _ = try db.collection("monuments").addDocument(from: monument) { error in
//                if let error = error {
//                    completion(.failure(error))
//                } else {
//                    completion(.success(()))
//                }
//            }
//        } catch let error {
//            completion(.failure(error))
//        }
//    }
//
//    /// Fetches a monument by its Firestore document ID.
//    func fetchMonument(withId id: String, completion: @escaping (Result<Monument, Error>) -> Void) {
//        db.collection("monuments").document(id).getDocument { document, error in
//            if let document = document, document.exists {
//                let result = Result { try document.data(as: Monument.self) }
//                completion(result)
//            } else {
//                completion(.failure(error ?? NSError(domain: "", code: -1, userInfo: nil)))
//            }
//        }
//    }
//
//    // MARK: - Badge Operations
//
//    /// Creates a new badge document in Firestore.
//    func createBadge(badge: Badge, completion: @escaping (Result<Void, Error>) -> Void) {
//        do {
//            let _ = try db.collection("badges").addDocument(from: badge) { error in
//                if let error = error {
//                    completion(.failure(error))
//                } else {
//                    completion(.success(()))
//                }
//            }
//        } catch let error {
//            completion(.failure(error))
//        }
//    }
//
//    /// Fetches a badge by its Firestore document ID.
//    func fetchBadge(withId id: String, completion: @escaping (Result<Badge, Error>) -> Void) {
//        db.collection("badges").document(id).getDocument { document, error in
//            if let document = document, document.exists {
//                let result = Result { try document.data(as: Badge.self) }
//                completion(result)
//            } else {
//                completion(.failure(error ?? NSError(domain: "", code: -1, userInfo: nil)))
//            }
//        }
//    }
//}
