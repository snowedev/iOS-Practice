//
//  CounterViewReactor.swift
//  ReactorKit Test
//
//  Created by 60156673 on 2022/02/03.
//

import Foundation
import ReactorKit

class CounterViewReactor: Reactor {
    typealias Reactor = CounterViewReactor
    
    // 사용자 인터랙션을 표현
    // loading이 어떻게 시작되는지 뷰는 몰라도 돼서 Action은 건들지 않는다.
    enum Action {
        case increase
        case decrease
    }
    
    // 상태를 변경하는 가장 작은 단위
    // Action과 State와 달리 리액터 클래스 밖으로 노출되지 않음
    // 대신, 클래스 내부에서 Action과 State를 연결하는 역할 수행
    enum Mutation {
        case increaseValue
        case decreaseValue
        case setLoading(Bool)
    }
    
    // 뷰의 상태를 표현
    struct State {
        var value: Int = 0
        var isLoading: Bool = false
    }
    
    // 가장 첫 상태를 나타내는 initialState 필수
    let initialState = State()
    
    
    // Action 스트림을 Mutation 스트림으로 변환하는 역할
    // 네트워킹이나 비동기 로직 등의 사이드 이펙트 처리
    // return 값으로 Mutation을 방출하는데, 그 값이 reduce()로 전달된다.
    func mutate(action: Reactor.Action) -> Observable<Reactor.Mutation> {
        switch action {
        case .increase:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.increaseValue)
                    .delay(.seconds(1),scheduler: MainScheduler.instance),
                Observable.just(Mutation.setLoading(false))
            ])
        case .decrease:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.decreaseValue)
                    .delay(.seconds(1),scheduler: MainScheduler.instance),
                Observable.just(Mutation.setLoading(false))
            ])
        }
    }
    
    // 이전 상태와 Mutation을 받아서 변경된 상태를 반환한다.
    func reduce(state: Reactor.State, mutation: Reactor.Mutation) -> Reactor.State {
        var newState = state
        switch mutation {
        case .increaseValue:
            newState.value += 1
        case .decreaseValue:
            newState.value -= 1
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
            print(newState.isLoading)
        }
        
        return newState
    }
}
