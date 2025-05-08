import Foundation
import SnapshotTesting

public func assertAsyncSnapshot<Value, Format>(
    of value: @autoclosure () throws -> Value,
    as asyncSnapshotting: AsyncSnapshotting<Value, Format>,
    named name: String? = nil,
    record recording: Bool? = nil,
    timeout: TimeInterval = 5,
    fileID: StaticString = #fileID,
    file filePath: StaticString = #filePath,
    testName: String = #function,
    line: UInt = #line,
    column: UInt = #column
) async {
    assertSnapshot(
        of: try value(),
        as: asyncSnapshotting.snapshotting,
        named: name,
        record: recording,
        timeout: timeout,
        fileID: fileID,
        file: filePath,
        testName: testName,
        line: line,
        column: column
    )
}

public struct AsyncSnapshotting<Value, Format> {
    let snapshotting: Snapshotting<Value, Format>

    private init(snapshotting: Snapshotting<Value, Format>) {
        self.snapshotting = snapshotting
    }

    public init(
        pathExtension: String?,
        diffing: Diffing<Format>,
        snapshot: @escaping (Value) async -> Format
    ) {
        self.init(
            snapshotting: Snapshotting(
                pathExtension: pathExtension,
                diffing: diffing,
                asyncSnapshot: { value in
                    Async {
                        await snapshot(value)
                    }
                }
            )
        )
    }

    func pullback<NewValue>(_ transform: @escaping (NewValue) async -> Value) -> AsyncSnapshotting<NewValue, Format> {
        AsyncSnapshotting<NewValue, Format>(
            snapshotting: snapshotting.asyncPullback { value in
                Async {
                    await transform(value)
                }
            }
        )
    }
}
