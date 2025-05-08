import SnapshotTesting

public extension Snapshotting {
    init(
        pathExtension: String?,
        diffing: Diffing<Format>,
        snapshot: @escaping (Value) async -> Format
    ) {
        self.init(
            pathExtension: pathExtension,
            diffing: diffing,
            asyncSnapshot: { value in
                Async {
                    await snapshot(value)
                }
            }
        )
    }

    func pullback<NewValue>(_ transform: @escaping (NewValue) async -> Value) -> Snapshotting<NewValue, Format> {
        asyncPullback { value in
            Async {
                await transform(value)
            }
        }
    }
}
