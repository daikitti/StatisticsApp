import Foundation
import RxSwift

class MenuController {

    private let menuView: MenuView
    private let disposeBag = DisposeBag()

    init(menuView: MenuView) {
        self.menuView = menuView
        self.menuView.controller = self
    }


}
