const components = @import("./engine/ecs/components.zig");
const std = @import("std");
pub fn main() !void {
    try testInsert();
}

const foo =  struct {};

pub fn testInsert() !void 
{
    const alloc = std.heap.page_allocator;

    var testComp : components.SparseSet(foo) = .empty;
    try testComp.add(0, foo{}, alloc);


}
