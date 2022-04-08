const std = @import("std");

const Str = []const u8;

const aoc = struct {
    const day01 = @import("day01.zig");
};

const days = 1;

pub fn main() !void {
    const std_out = std.io.getStdOut();
    var bufw = std.io.bufferedWriter(std_out.writer());
    const writer = bufw.writer();

    var timer = try std.time.Timer.start();

    comptime var day: u4 = 0;
    inline while (day < days) : (day += 1) {
        comptime var buf: [5]u8 = undefined;
        const day_str = comptime try std.fmt.bufPrint(&buf, "day{d:0>2}", .{day+1});
        const input = @embedFile("../input/" ++ day_str ++ ".txt");
        const pre = timer.lap();
        const res = try @field(aoc, day_str).main(input);
        const post = timer.lap();
        try writer.print("Day 01:\t{d}us \t{d}\t{d}\n", .{ (post - pre) / 1000, res[0], res[1] });
    }

    try bufw.flush();
}
