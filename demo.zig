// Top-level definitions are order independent.
const assert = std.debug.assert;
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Hi {}!\n", .{"there"});
    try stdout.print("stdout: {}\n", .{@typeName(@TypeOf(stdout))});
    // greetWithC();
}

// Use C if wanted.

// This is also available as `std.c.printf`.
extern "c" fn printf(format: [*:0]const u8, ...) c_int;

fn greetWithC() void {
    const message = "Hi there!\n";
    _ = printf(message);
    // const nonterminated_message: [*]const u8 = message[0..];
    // _ = printf(nonterminated_message);
}

// Union and unit test.

const Payload = union(enum) {
    Int: i64,
    Float: f64,
};

test "access union" {
    const payload = Payload{ .Int = 2 };
    assert(payload.Float == 2);
    const result = switch (payload) {
        Payload.Int => |value| -1 * value,
        Payload.Float => 0,
    };
    assert(result == -2);
}
