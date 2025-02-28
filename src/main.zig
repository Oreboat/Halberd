//This is the main file, while currently it is used for testing, as of the current roadmap this will be what's used for the main editor logic
//as the engine itself is handled by root.zig
const std = @import("std");
const ecs = @import("ecs");
const renderer = @import("modules/wgpu/wgpu.zig");
pub fn main() !void {
    const alloc = std.heap.page_allocator;
    var app = ecs.App(){.allocator = alloc};
    const window = app.get_component(renderer.Window, null);
    _ = window;
    app.module(renderer);
    app.progress(app.Start());
}

const foo =  struct {
    x: u32
};

pub fn testInsert() !void 
{

}


pub fn testSystem() void {
    std.debug.print("system running", .{});
}