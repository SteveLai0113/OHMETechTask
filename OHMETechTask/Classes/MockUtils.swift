//
//  OTUtils.swift
//  OHMETechTask
//
//  Created by Steve Lai on 23/9/2021.
//

import Foundation
import RxSwift
import HandyJSON

class MockUtils {
    static let delay = 5 //5seconds
    
    static func loadModel<T : HandyJSON>(fileName: String, fileExt: String, type: T.Type) -> T? {
        let bundle = Bundle(for: self)
        if let filepath = bundle.path(forResource: fileName, ofType: fileExt) {
            do {
                let contents = try String(contentsOfFile: filepath)
                let response = T.deserialize(from: contents)
                return response
            } catch {
                // contents could not be loaded
                assertionFailure("Mock Utils load model \(type.self) failed with fileName \(fileName)")
            }
        } else {
            assertionFailure("Mock Utils model file not exist")
        }
        return nil
    }
    
    static func rxLoadModel<T : HandyJSON>(fileName: String, fileExt: String, type: T.Type) -> Observable<T> {
        let model = MockUtils.loadModel(fileName: fileName, fileExt: fileExt, type: type)
        return Observable.create { (observer) -> Disposable in
            if let model = model {
                observer.onNext(model)
                observer.onCompleted()
            } else {
                observer.onError(NSError(domain: "OTUtils", code: 404, userInfo: nil))
            }
            return Disposables.create()
        }.delay(.milliseconds(delay), scheduler: MainScheduler.instance)
    }
}
