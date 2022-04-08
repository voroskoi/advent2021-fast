const std = @import("std");

// Use a 3*InputType sized integer as a FIFO of InputType integers
const InputType = u14; // maximum input size
const shift_size = 14;
const FIFOType = u42; // 3*InputType

pub fn main(input: []const u8) ![2]usize {
    var lines = std.mem.tokenize(u8, input, "\n");

    var part1: FIFOType = 0;
    var part2: FIFOType = 0;

    var previous: FIFOType = std.math.maxInt(FIFOType);
    var n: InputType = undefined;

    while (lines.next()) |line| {
        n = try std.fmt.parseUnsigned(InputType, line, 10);

        if (n > @truncate(InputType, previous)) part1 += 1;
        if (n > @truncate(InputType, previous >> 2 * shift_size)) part2 += 1;

        var result: FIFOType = undefined;
        _ = @shlWithOverflow(FIFOType, previous, shift_size, &result);
        previous = result + n;
    }

    return [2]usize{ part1, part2 };
}
