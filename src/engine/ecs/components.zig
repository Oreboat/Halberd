const std = @import("std");


pub fn SparseSet(comptime T: type) type {
    return struct {
        dense_list : std.ArrayListUnmanaged(T) = .empty,
        sparse_list : std.ArrayListUnmanaged([5]usize) = .empty,

        const Self = @This();

        const data_type = T;

        pub const empty: Self = .{
            .dense_list = .empty,
            .sparse_list = .empty
        };

        pub fn add(self: *Self, id: usize, data: data_type, allocator: std.mem.Allocator) !void{
            const pageNumber: usize = id/5;
            const i: usize = id%5;
            try self.dense_list.append(allocator, data);

            // Ensure sparse_list has enough pages
            if (self.sparse_list.items.len <= pageNumber) {
                try self.sparse_list.append(allocator, [_]usize{std.math.maxInt(usize)} ** 5);
            }

            // Store the index of the newly added item in the dense_list
            self.sparse_list.items[pageNumber][i] = self.dense_list.items.len - 1;

        }

        pub fn get(self: *Self, id: usize) data_type{
            const pageNumber: usize = id/5;
            const i: usize = id%5;

            return self.dense_list.items[self.sparse_list.items[pageNumber[i]]];
        }
        
    };
}

