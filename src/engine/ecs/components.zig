const std = @import("std");


const SparseSet = struct {
    dense_list: std.ArrayListUnmanaged(u8),
    sparse_list: std.ArrayListUnmanaged([5]usize),

    const Self = @This();

    fn init(comptime T: type) void{
        return SparseSet(){
            .dense_list = std.ArrayListUnmanaged([5]usize).init(),
            .sparse_list = std.ArrayListUnmanaged(T)
        };
    }
};