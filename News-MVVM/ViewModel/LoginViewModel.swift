//
//  LoginViewModel.swift
//  News-MVVM
//
//  Created by Mohamed Shaat on 7/28/19.
//  Copyright © 2019 shaat. All rights reserved.
//

import RxSwift

class LoginViewModel: ViewModelProtocol {
    
    struct Input {
        let userName: AnyObserver<String>
        let password: AnyObserver<String>
        let signInDidTap: AnyObserver<Void>
    }
    
    struct Output {
        let rx_isLoading: Observable<Bool>
        let loginResultObservable: Observable<User>
        let serverErrorsObservable: Observable<String>
        let validationErrorsObservable: Observable<ErrorResponse>
    }
    
    // MARK: - Public properties
    let input: Input
    let output: Output
    
    // MARK: - Private properties
    private let rx_isLoadingSubject = PublishSubject<Bool>()
    private let userNameSubject = PublishSubject<String>()
    private let passwordSubject = PublishSubject<String>()
    private let signInDidTapSubject = PublishSubject<Void>()
    private let loginResultSubject = PublishSubject<User>()
    private let serverErrorsSubject = PublishSubject<String>()
    private let validationErrorsSubject = PublishSubject<ErrorResponse>()
    private let disposeBag = DisposeBag()
    
    private var credentialsObservable: Observable<Credentials> {
        return Observable.combineLatest(userNameSubject.asObservable(), passwordSubject.asObservable()) { (userName, password) in
            return Credentials(userName: userName, password: password)
        }
    }
    
    
    init(_ loginService: LoginServiceProtocol) {
        
        input = Input(userName: userNameSubject.asObserver(),
                      password: passwordSubject.asObserver(),
                      signInDidTap: signInDidTapSubject.asObserver())
        
        output = Output(rx_isLoading: rx_isLoadingSubject.asObservable(), loginResultObservable: loginResultSubject.asObservable(),
                        serverErrorsObservable: serverErrorsSubject.asObservable(), validationErrorsObservable: validationErrorsSubject.asObservable())
        
        signInDidTapSubject
            .withLatestFrom(credentialsObservable).filter { credentials in
                
                return self.validateLoginTextFields(credentials:credentials)
            }
            .flatMapLatest { credentials in
                return loginService.signIn(with: credentials).materialize()
            }.subscribe(onNext: { [weak self] event in
                self?.rx_isLoadingSubject.onNext(false)
                switch event {
                case .next(let user):
                    if user.token != nil {
                     self?.loginResultSubject.onNext(user)
                    } else {
                     self?.serverErrorsSubject.onNext(user.message ?? "")
                    }
                case .error(let error):
            self?.serverErrorsSubject.onNext(error.localizedDescription)
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
    
    func validateLoginTextFields(credentials: Credentials) -> Bool {
        var valid = true
        let error = ErrorResponse(JSON:[:])
        if  credentials.userName.isBlank {
            valid = false
            error?.name = "please enter user name".localized()
        }
        if  !credentials.password.isBlank {
            if !credentials.password.isPasswordMoreThaneightCharacters {
                error?.password = "password must be more than eight characters".localized()
                valid = false
            }
        }else {
            error?.password   = "please enter your password".localized()
            valid = false
        }
        
        if valid == false {
            self.validationErrorsSubject.onNext(error!)
        } else {
            self.rx_isLoadingSubject.onNext(true)
        }
        
        return valid
    }
    
}
