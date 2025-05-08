import SnapshotTesting

public extension Async {
    init(run: @escaping () async -> Value) {
        self.init { complete in
            Task {
                let value = await run()
                complete(value)
            }
        }
    }

    func run() async -> Value {
        await withCheckedContinuation { continuation in
            run { value in
                continuation.resume(returning: value)
            }
        }
    }
}
