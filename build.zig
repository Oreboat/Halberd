const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Create only a library (no static lib)
    const lib = b.addSharedLibrary(.{
        .name = "HalberdRuntime",
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    b.installArtifact(lib);

    // Create executable
    const exe = b.addExecutable(.{
        .name = "HalberdEngine",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    // Add ECS module
    const ecs_module = b.createModule(.{ .root_source_file = b.path("src/engine/ecs/ecs.zig") });
    // Link the module to the executable
    exe.root_module.addImport("ecs", ecs_module);

    // Link the module to the
    lib.root_module.addImport("ecs", ecs_module);


    const zglfw = b.dependency("zglfw", .{});
    lib.root_module.addImport("zglfw", zglfw.module("root"));

    exe.root_module.addImport("zglfw", zglfw.module("root"));
    if (target.result.os.tag != .emscripten) {
        exe.linkLibrary(zglfw.artifact("glfw"));
    }

    const wgpu_native_dep = b.dependency("wgpu-native-zig", .{});
    // Or, add to your lib similarly:
    lib.root_module.addImport("wgpu", wgpu_native_dep.module("wgpu"));

    //instal exe artifact
    b.installArtifact(exe);

    // Ensure it links dynamically
    exe.linkLibrary(lib);

}
