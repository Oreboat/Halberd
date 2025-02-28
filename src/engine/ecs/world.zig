const std = @import("std");
const components = @import("components.zig");
const systems = @import("system.zig");

pub fn World() type {
    return struct {
        entities: std.DynamicBitSetUnmanaged = std.DynamicBitSetUnmanaged{},

        component_set: std.StringArrayHashMapUnmanaged(*anyopaque) = .empty,
        

        Start: systems.Schedule() = systems.Schedule(){},
        InputUpdate: systems.Schedule() = systems.Schedule(){},
        PreUpdate: systems.Schedule() = systems.Schedule(){},
        Update: systems.Schedule() = systems.Schedule(){},
        PostUpdate: systems.Schedule() = systems.Schedule(){},
        PhysicsUpdate: systems.Schedule() = systems.Schedule(){},

        const Self = @This();
        
    };
}
