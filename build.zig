const std = @import("std");

const days = 25;
const cpp_flags = &[_][]const u8{"-std=c++20"};

pub fn build(b: *std.build.Builder) void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{});

    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable("aoc2021", null);

    var day: u8 = 1;
    while (day <= days) : (day += 1) {
        const dayString = b.fmt("day{:0>2}", .{day});
        const cppFile = b.fmt("src/{s}.cpp", .{dayString});

        exe.addCSourceFile(cppFile, cpp_flags);
    }

    exe.addCSourceFile("src/main.cpp", cpp_flags);
    exe.linkLibCpp();
    exe.setTarget(target);
    exe.setBuildMode(mode);
    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run all solver");
    run_step.dependOn(&run_cmd.step);
}
