import UIKit
import Combine
import FarFarAway // We want to use the struct Model, but it's in another Module

class ViewController: UIViewController {
    @IBOutlet private weak var label: UILabel!
    /* Simple way to create AnyCancellable */
//    private var cancellable: AnyCancellable?
    
    /* Other way to create AnyCancellable */
    private var cancellables: Set<AnyCancellable> = Set()

    private let link = Link()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelSubscription().store(in: &cancellables)
    }
    
    private func labelSubscription() -> AnyCancellable {
        link.$contents
            /* .sink returns Anycancellable */
            .sink {[weak self] string in
                self?.label.text = string
            }
    }
    
    @IBAction private func next(_ sender: UIButton) {
        link.next()
    }
}
