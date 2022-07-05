//
//  DataProvider.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 20.06.2022.
//

import Foundation
import Combine
import Realm
import RealmSwift

class DataProvider {

    func objects<T: Object>(_ type: T.Type, predicate: NSPredicate? = nil) -> AnyPublisher<[T], Error> {
        guard let realm = try? Realm() else {
            return Fail(error: NSError(domain: "Realm is not enabled", code: -10001)).eraseToAnyPublisher()
        }
        realm.refresh()
        var objects = realm.objects(type)
        if let predicate = predicate {
            objects = objects.filter(predicate)
        }

        return objects.collectionPublisher
            .map { Array($0) }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }

    func add<T: Object>(_ data: [T]) throws {
        let realm = try Realm()
        realm.refresh()

        if realm.isInWriteTransaction {
            realm.add(data, update: .modified)
        } else {
            try? realm.write {
                realm.add(data, update: .modified)
            }
        }
    }

    func configure() {
        let config = RLMRealmConfiguration.default()
        config.deleteRealmIfMigrationNeeded = true
        RLMRealmConfiguration.setDefault(config)
    }
}
