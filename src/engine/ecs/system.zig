const std = @import("std");


pub fn Schedule() type {
    return struct {
        systems: std.ArrayListUnmanaged(*const fn () void) = .empty,



        pub const config = struct {
            before: ?*const fn () void = null,
            system: *const fn () void,
            after: ?*const fn() void = null
        };

        pub const empty: Self = .{
            .systems = .empty
        };

        const Self = @This();

        pub fn add_system(self: *Self, allocator: std.mem.Allocator, system: config) void{
            if (system.before != null) {
                for (self.systems.items, 0..) |existing, i| {
                    if (existing == system.before) {
                        _ = self.systems.insert(allocator, i, system.system) catch |err| std.debug.print("{}", .{err});
                        return;
                    }
                }
            }

            if (system.after != null) {
                for (self.systems.items, 0..) |existing, i| {
                    if (existing == system.after) {
                        _ = self.systems.insert(allocator, i + 1, system.system) catch |err| std.debug.print("{}", .{err});
                        return;
                    }
                }
            }

            _ = self.systems.append(allocator, system.system) catch |err| std.debug.print("{}", .{err});
        }

        pub fn progress(self: *Self) void{
            var i:usize = 0;
            std.debug.print("number of systems in schedule: {} \n", .{self.systems.items.len});

            while (i < self.systems.items.len) {
                self.systems.items[i]();
                i+=1;
            }
            

        }
    };
}