//
//  FileHandler.swift
//  RefV-1
//
//

import Foundation

protocol FileHandlerProtocol {
    
    typealias FetchCompletion = (Result<Data, Error>) -> Void
    typealias WriteCompletion = (Result<Data, Error>) -> Void
    typealias EncodeResult = Result<Data, Error>
    
    func fetch(completion: @escaping FetchCompletion)
    func write(_ data: Data, completion: @escaping WriteCompletion)

}
class FileHandler: FileHandlerProtocol {
    func write(_ data: Data, completion: @escaping FileHandler.WriteCompletion) {
        
    }
    
    
    private var url: URL  // save and retrieve data
    init() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!  //path located
        url = documentsDirectory.appendingPathComponent("todo").appendingPathExtension("plist")
        
        if !FileManager.default.fileExists(atPath: url.path) {
            FileManager.default.createFile(atPath: url.path, contents: nil)
        }
        }
    
    func fetch(completion: @escaping (Result<Data, Error>) -> Void) {
        do {
            let data = try Data(contentsOf: url)
            completion(.success(data))
        } catch  {
            completion(.failure(error))
        }
    }
    
    func write(_ data: Data, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try data.write(to: url)
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
    func encodeNotes(_ notes: [Notes]) -> EncodeResult {
        let propertyListEncoder = PropertyListEncoder()
        if let encodeList = try? propertyListEncoder.encode(notes) {
            return .success(encodeList)
        } else {
            return .failure(NoteServiceError.fileWriteError("Failed to encode array to type DATA"))
        }
    }
}

