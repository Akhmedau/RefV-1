//
//  ServiceRepository.swift
//  RefV-1
//
//

import Foundation

protocol ServiceRepositoryProtocol {

    typealias FetchNotesCompletion = (Result<[Notes],Error>) -> Void
    typealias OperationCompletion = (Result<Void, Error>) ->Void

    func fetchNotes(completion: @escaping FetchNotesCompletion)
    func saveData(note: Notes, completion: @escaping OperationCompletion)
    func removeData(note: Notes, completion: @escaping OperationCompletion)
    func updateNote(_ noteToUpdate: Notes, completion: @escaping OperationCompletion)
}

enum NoteServiceError: Error {
    case fileReadError(String)
    case fileWriteError(String)
    case notNoteFound(String)
}

final class ServiceRepository: ServiceRepositoryProtocol {
    func removeData(note: Notes, completion: @escaping OperationCompletion) {
        
    }
    
    func updateNote(_ noteToUpdate: Notes, completion: @escaping OperationCompletion) {
        
    }
    
    

    private let fileHandler: FileHandlerProtocol
    private var notesCache = [Notes]()

    init(fileHandler: FileHandlerProtocol) {
        self.fileHandler = fileHandler
    }

    func fetchNotes(completion: @escaping FetchNotesCompletion) {
        !notesCache.isEmpty ? completion(.success(notesCache)) : nil

        fileHandler.fetch(completion: { result in
            switch result {
            case .success(let dataContent):
                guard !dataContent.isEmpty else {
                    print("File is Empty")
                    completion(.success([]))
                    return
                }
            let propertyListDecoder = PropertyListDecoder()
                guard let notes = try? propertyListDecoder.decode([Notes].self, from: dataContent) else {
                    completion(.failure(NoteServiceError.fileReadError("Failed to decode data into notes array")))
                    return
                }
                self.notesCache = notes
                completion(.success(notes))
                case.failure(let error):
                completion(.failure(error))

            }
        })
    }

    func saveData(note: Notes, completion: @escaping OperationCompletion) {
        notesCache.append(note)

//        switch fileHandler.encodeNotes(notesCache) {
//        case .success(let data):
//            fileHandler.write(data, completion: completion)
//        case .failure(let error):
//            completion(.failure(error))
//        }
    }
//
//    func removeData(note: Notes, completion: @escaping OperationCompletion) {
//        guard let index = notesCache.firstIndex(where: { noteElement in
//            noteElement == note
//        }) else {
//            completion(.failure(NoteServiceError.notNoteFound("Could not find note")))
//            return
//        }
//        notesCache.remove(at: index)
//
//        switch fileHandler.encodeNotes(notesCache) {
//        case .success(let data):
//            fileHandler.write(data, completion: completion)
//        case .failure(let error):
//            completion(.failure(error))
//        }
//    }
//
//    func updateNote(_ note: Notes, completion: @escaping OperationCompletion) {
//            guard let index = notesCache.firstIndex(where: { noteElement in
//                noteElement == note                                     //Why 'noteToUpdate' doesn't works
//            }) else {
//                completion(.failure(NoteServiceError.notNoteFound("Could not find note")))
//                return
//            }
//                notesCache[index] = note                                     //Why 'noteToUpdate' doesn't works
//
//            switch fileHandler.encodeNotes(notesCache) {
//            case .success(let data):
//                fileHandler.write(data, completion: completion)
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
    }


