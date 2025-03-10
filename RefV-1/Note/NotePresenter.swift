//
//  NotePresenter.swift
//  RefV-1
//
//  Created by АХМЕДОВ НИКОЛАЙ on 14/09/2023.
//  Copyright © 2023 Ahmedov Nikolay. All rights reserved.
//

import Foundation

protocol NotePresentorProtocol {
    func loadAndUpdateDisplayData()
    func addNote(note: Notes)
    func deleteNote(at index: Int)
    func numberOfNotes() -> Int
    func noteAt(index: Int) -> Notes
    func getImage(for isComplete: Bool) -> String
    func isToggleNote(for index: Int)
    }
    
class NotePresenter: NotePresentorProtocol {
    
    private weak var view: NoteViewProtocol?
    private var dataRepository:ServiceRepositoryProtocol
    private var notes: [Notes] = []
    
    init (view: NoteViewProtocol, dataRepository: ServiceRepositoryProtocol) {
        self.view = view
        self.dataRepository = dataRepository
    }
    
    
    func loadAndUpdateDisplayData() {
        view?.showLoading()
        dataRepository.fetchNotes(completion: {[ weak self] result in
            switch result {
            case .success(let notes):
                self?.notes = notes.sorted(by: { $0.date > $1.date })
                self?.view?.reloadData()
                self?.view?.hideLoading()
            case .failure(let error):
                self?.view?.showError(title: "Error", message: error.localizedDescription)
                self?.view?.hideLoading()
            }
        })
    }
    
    func addNote(note: Notes) {
        view?.showLoading()
        dataRepository.saveData(note: note, completion: {[ weak self] result in
            switch result {
            case .success:
                self?.notes = self?.notes.sorted(by: { $0.date > $1.date }) ?? []
                self?.view?.didInsertRow(at: 0)
                self?.view?.hideLoading()
            case .failure(let error):
                self?.view?.hideLoading()
                self?.view?.showError(title: "Error", message: error.localizedDescription)
            }
        })
    }
    
    func deleteNote(at index: Int) {
        let note = notes[index]
        dataRepository.removeData(note: note, completion: {[ weak self] result in
            switch result {
            case .success:
                self?.notes.remove(at: index)
                self?.view?.didDeleteRow(at: index)
            case .failure(let error):
                self?.view?.showError(title: "Error", message: error.localizedDescription)
            }
        })
    }
    
    func numberOfNotes() -> Int {
        return notes.count
    }
    
    func noteAt(index: Int) -> Notes {
        return notes[index]
    }
    
    func getImage(for isComplete: Bool) -> String {
        return isComplete ? "checkmark.circle.fill" : "circle"
    }
    
    func isToggleNote(for index: Int) {
        var note = notes[index]
        note.isComplete.toggle()
        
        dataRepository.updateNote(note, completion: { result in
            switch result {
            case.success:
                self.notes[index] = note
                self.view?.reloadRow(at: index)
            case .failure(let error):
                self.view?.showError(title: "Error", message: error.localizedDescription)
            }
        
    })
  }
}
