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

        pub fn get(self: *Self, id: usize) ?*data_type {
            const pageNumber: usize = id / 5;
            const i: usize = id % 5;

            // Ensure pageNumber is within bounds
            if (pageNumber >= self.sparse_list.items.len) {
                return null;
            }

            const dense_index = self.sparse_list.items[pageNumber][i];

            // If the index is invalid, return null
            if (dense_index == std.math.maxInt(usize)) {
                return null;
            }

            return &self.dense_list.items[dense_index];
        }

        pub fn remove(self: *Self, id: usize) !void {
            const pageNumber: usize = id / 5;
            const i: usize = id % 5;

         // Get the index of the item in the dense_list
        const dense_index = self.sparse_list.items[pageNumber][i];

        // If the element is already invalid, return
        if (dense_index == std.math.maxInt(usize)) {
            return;
        }

        // Get the last element's index in the dense list
        const last_index = self.dense_list.items.len - 1;

        // Swap the current element with the last element in dense_list
        self.dense_list.items[dense_index] = self.dense_list.items[last_index];

        // Find which ID was stored at the last index and update its sparse_list entry
        var found_page: usize = 0;
        var found_i: usize = 0;
        for (0..self.sparse_list.items.len) |p| {
            for (0..5) |j| {
                if (self.sparse_list.items[p][j] == last_index) {
                    found_page = p;
                    found_i = j;
                    break;
                }
            }
        }
        self.sparse_list.items[found_page][found_i] = dense_index;

        // Invalidate the sparse_list entry for the removed element
        self.sparse_list.items[pageNumber][i] = std.math.maxInt(usize);

        // Shrink dense_list
        _ = self.dense_list.pop();
    }


        pub fn deinit(self: *Self, allocator: std.mem.Allocator) void{
            self.dense_list.deinit(allocator);
            self.sparse_list.deinit(allocator);
        }
        
    };
}

pub fn component(comptime t: type) type {
    return struct {
        sparse_set: SparseSet(t) = .empty,
    };
}

