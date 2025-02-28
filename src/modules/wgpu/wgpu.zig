const ecs = @import("ecs");
const glfw = @import("zglfw");
const std = @import("std");

pub const Window = struct {
    win_instance: *glfw.Window
};

pub fn init(app: *ecs.App()) void {
    app.init_component(Window, null);
    app.add_system(app.Start(), .{.system = &create_window});    

}

pub fn create_window() void {
    glfw.init() catch |err| std.debug.print("{}", .{err});
    defer glfw.terminate();
    std.debug.print("GLFW Init Succeeded.\n", .{});

    const window = glfw.createWindow(1280, 720, "Halberd", null) catch |err| {
        std.debug.print("Error creating window: {}\n", .{err});
        return;  
    };

    while (!glfw.windowShouldClose(window)) {
        glfw.pollEvents();
    }
}
