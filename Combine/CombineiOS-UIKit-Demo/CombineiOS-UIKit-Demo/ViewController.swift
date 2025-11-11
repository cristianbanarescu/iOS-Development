//
//  ViewController.swift
//  CombineiOS-UIKit-Demo
//
//  Created by Cristian Banarescu on 11.11.2025.
//

import UIKit
import Combine

final class ViewController: UIViewController {

    // MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Combine Demo"
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let outputLabel: UILabel = {
        let label = UILabel()
        label.text = "Output will appear here"
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.backgroundColor = UIColor.secondarySystemBackground
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start Stream", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send Event", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Type text to send…"
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    // A subject is a manual source of values. Think of it as a pipe you can push values into.
    private let manualSubject = PassthroughSubject<String, Never>()

    // We'll also demonstrate a timer publisher for automatic events.
    private var timerPublisher: AnyPublisher<Int, Never>?

    // Keep subscriptions alive using AnyCancellable set.
    private var cancellables = Set<AnyCancellable>()

    // Keep reference to a timer subscription so we can stop it on Reset.
    private var timerCancellable: AnyCancellable?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        wireUpActions()
        setupManualStream()
    }
}

// MARK: - Private

private extension ViewController {
    func setupLayout() {
        let buttonsStack = UIStackView(arrangedSubviews: [startButton, sendButton, resetButton])
        buttonsStack.axis = .horizontal
        buttonsStack.spacing = 12
        buttonsStack.distribution = .fillEqually
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false

        let mainStack = UIStackView(arrangedSubviews: [titleLabel, textField, buttonsStack, outputLabel])
        mainStack.axis = .vertical
        mainStack.spacing = 16
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(mainStack)

        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            mainStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            outputLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 120)
        ])
    }

    func wireUpActions() {
        startButton.addTarget(self, action: #selector(startStreamTapped), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(sendTapped), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetTapped), for: .touchUpInside)
    }

    func setupManualStream() {
        // This creates a pipeline of operators that react to values sent into manualSubject.
        // We'll showcase a few fundamental operators and UI-thread delivery.
        manualSubject
            // 1) map: transform the input string into an annotated string
            .map { input in
                // Add a timestamp so we can see when the value was processed
                let time = Self.timeString()
                return "[map @ \(time)] input=\(input)"
            }
            // 2) filter: only pass values longer than 2 characters
            .filter { $0.count > 2 }
            // 3) removeDuplicates: if the same string arrives consecutively, drop it
            .removeDuplicates()
            // 4) debounce: if values arrive rapidly, only emit the latest after 300ms of inactivity
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            // 5) scan: keep a running count of messages and build a multi-line log
            .scan("") { log, newValue in
                let count = log.split(separator: "\n").count + (log.isEmpty ? 0 : 1)
                return log + (log.isEmpty ? "" : "\n") + "#\(count + 1): \(newValue)"
            }
            // Always deliver UI updates on the main thread
            .receive(on: RunLoop.main)
            // 6) sink: subscribe to receive values and update UI
            .sink { [weak self] value in
                // Update the label with the accumulated log
                self?.outputLabel.text = value
            }
            .store(in: &cancellables)

        // Also demonstrate completion handling using a separate subscriber.
        manualSubject
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.appendToOutput("[completion] subject finished")
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
    }

    func startTimerStream() {
        // A timer that ticks every second and publishes an increasing Int.
        // We convert to AnyPublisher to keep the stored type simple.
        timerPublisher = Timer
            .publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .scan(0) { acc, _ in acc + 1 } // count the ticks
            .eraseToAnyPublisher()

        // Subscribe and update the UI with each tick.
        timerCancellable = timerPublisher?
            .map { "[timer] tick #\($0)" }
            .sink(receiveValue: { [weak self] text in
                self?.appendToOutput(text)
            })
    }

    @objc func startStreamTapped() {
        // Start (or restart) the timer stream.
        appendToOutput("Starting timer stream…")
        timerCancellable?.cancel()
        startTimerStream()
    }

    @objc func sendTapped() {
        // Send whatever is in the text field into the manual subject.
        // Empty text is ignored for clarity.
        guard let text = textField.text, !text.isEmpty else { return }
        manualSubject.send(text)
    }

    @objc func resetTapped() {
        // Cancel subscriptions and clear UI.
        appendToOutput("Resetting…")
        timerCancellable?.cancel()
        timerCancellable = nil
        // Finish the subject to demonstrate completion.
        manualSubject.send(completion: .finished)

        // Dispose of all other subscriptions and start over.
        cancellables.removeAll()
        outputLabel.text = "Output will appear here"
        // Re-create the manual stream pipeline so the demo can continue after reset.
        setupManualStream()
    }

    func appendToOutput(_ line: String) {
        let existing = outputLabel.text ?? ""
        outputLabel.text = existing.isEmpty || existing == "Output will appear here" ? line : existing + "\n" + line
    }

    static func timeString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSS"
        return formatter.string(from: Date())
    }
}
