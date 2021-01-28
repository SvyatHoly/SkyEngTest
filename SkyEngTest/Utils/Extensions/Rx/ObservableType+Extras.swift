//
//  ObservableType+Extras.swift
//  SkyEngTest
//
//  Created by Svyatoslav Ivanov on 27.01.2021.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType where Element: Collection {

    func mapMany<T>(_ transform: @escaping (Self.Element.Element) -> T) -> Observable<[T]> {
        return self.map { collection -> [T] in
            collection.map(transform)
        }
    }
}
