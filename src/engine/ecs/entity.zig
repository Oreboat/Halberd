const ecs_world = @import("world.zig");
const std = @import("std");

pub fn spawn_entity(world: *ecs_world.World, allocator: *std.mem.Allocator) u32 {
    if(world.entities.bit_length != 0){
            var i: u32 = 0;
        while(i < world.entities.bit_length){
                std.debug.print("Iter at {}\n", .{i});
                if(!world.entities.isSet(i)){
                    world.entities.set(i);
                    std.debug.print("Spawning Entity {}\n", .{i});
                    return @intCast(i);
                }
                    i += 1;
            }
                world.entities.resize(allocator, world.entities.bit_length + 1, true) catch |err| { 
                    std.debug.print("ERROR: {}\n", .{err});
                } ;
                std.debug.print("Spawning Entity {}\n", .{world.entities.bit_length - 1});
                return @intCast(world.entities.bit_length - 1);
        }
            else{
                world.entities.resize(allocator, 1, true) catch |err| {
                    std.debug.print("ERROR: {}\n", .{err});
                } ;
                std.debug.print("Spawning Entity {}\n", .{0});
                return 0;
            }
}