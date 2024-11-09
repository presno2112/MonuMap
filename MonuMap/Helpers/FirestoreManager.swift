//
//  FirestoreManager.swift
//  MonuMap
//
//  Created by Sebastian Presno on 09/11/24.
//

import FirebaseFirestore
import FirebaseFirestore

class FirestoreManager {
    private let db = Firestore.firestore()

    // MARK: - User Operations

    func createUser(user: User, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            let _ = try db.collection("users").addDocument(from: user, completion: { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            })
        } catch let error {
            completion(.failure(error))
        }
    }

    func fetchUser(withId id: String, completion: @escaping (Result<User, Error>) -> Void) {
        db.collection("users").document(id).getDocument { document, error in
            if let document = document, document.exists {
                let result = Result { try document.data(as: User.self) }
                completion(result)
            } else {
                completion(.failure(error ?? NSError(domain: "", code: -1, userInfo: nil)))
            }
        }
    }

    // MARK: - Monument Operations

    func createMonument(monument: Monument, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            let _ = try db.collection("monuments").addDocument(from: monument, completion: { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            })
        } catch let error {
            completion(.failure(error))
        }
    }

    func fetchMonument(withId id: String, completion: @escaping (Result<Monument, Error>) -> Void) {
        db.collection("monuments").document(id).getDocument { document, error in
            if let document = document, document.exists {
                let result = Result { try document.data(as: Monument.self) }
                completion(result)
            } else {
                completion(.failure(error ?? NSError(domain: "", code: -1, userInfo: nil)))
            }
        }
    }

    // MARK: - Badge Operations

    func createBadge(badge: Badge, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            let _ = try db.collection("badges").addDocument(from: badge, completion: { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            })
        } catch let error {
            completion(.failure(error))
        }
    }

    func fetchBadge(withId id: String, completion: @escaping (Result<Badge, Error>) -> Void) {
        db.collection("badges").document(id).getDocument { document, error in
            if let document = document, document.exists {
                let result = Result { try document.data(as: Badge.self) }
                completion(result)
            } else {
                completion(.failure(error ?? NSError(domain: "", code: -1, userInfo: nil)))
            }
        }
    }
}
