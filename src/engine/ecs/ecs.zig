const ecs_world = @import("world.zig");
const entities = @import("entity.zig");
const components = @import("components.zig");
const systems = @import("system.zig");
const std = @import("std");


pub fn App() type{
    return struct {
        var world: ecs_world.World() = .{};

        allocator: std.mem.Allocator,

        const Self = @This();
        

        pub fn spawn_entity(self: *Self, World: ?*ecs_world.World()) u32{
            if(World == null){
                return entities.spawn_entity(&self.world, &self.allocator);
            }
            else {
                return entities.spawn_entity(World, &self.allocator);
            }
        }

        pub fn delete_entity(self: *Self, entity: u32, World: ?*ecs_world.World()) void{
            if(World == null){
                self.world.entities.unset(entity);
                std.debug.print("Deleting Entity {}", .{entity});
            }
            else {
                World.entities.unset(entity);
                std.debug.print("Deleting Entity {}", .{entity});
            }
        }

        pub fn init_component(self: *Self,comptime component: type, World: ?* ecs_world.World()) void{

            if(World == null){
                const comp = components.component(component){};
                world.component_set.put(self.allocator, @typeName(component), @constCast(&comp)) catch |err| std.debug.print("{}", .{err});
            }
            else {
                const comp = components.component(component){};
                World.?.component_set.put(self.allocator, @typeName(component), @constCast(&comp)) catch |err| std.debug.print("{}", .{err});
            }
        }

        pub fn get_component(self: *Self,comptime component_type: type, World: ?* ecs_world.World()) *components.component(component_type){
            _ = self;
            if(World == null){
                return @ptrCast(@alignCast(world.component_set.get(@typeName(component_type))));
            }
            else{
                return @ptrCast(@alignCast(world.component_set.get(@typeName(component_type))));
            }
            
        }

        pub fn add_system(self:*Self, schedule: *systems.Schedule() ,system: systems.Schedule().config) void{
            schedule.add_system(self.allocator, system);
        }
        //schedule definitions, these are variables so must be kept private
        var start = &world.Start;
        var input_update = &world.InputUpdate;
        var pre_update = &world.PreUpdate;
        var update = &world.Update;
        var post_update = &world.PostUpdate;
        var physics_update = &world.PhysicsUpdate;

        //instead they are accessed through dedictated functions
        pub fn Start(self: *Self) *systems.Schedule(){
            _ = self;
            return start;
        }

        pub fn InputUpdate(self: *Self) *systems.Schedule() {
        _ = self;
        return input_update;
        }

        pub fn PreUpdate(self: *Self) *systems.Schedule() {
            _ = self;
            return pre_update;
        }

        pub fn Update(self: *Self) *systems.Schedule() {
            _ = self;
            return &update;
        }

        pub fn PostUpdate(self: *Self) *systems.Schedule() {
            _ = self;
            return post_update;
        }

        pub fn PhysicsUpdate(self: *Self) *systems.Schedule() {
            _ = self;
            return &physics_update;
        }

        pub fn module(self: *Self, mod: type) void{
            mod.init(self);
        }

        pub fn progress(self: *Self, schedule: *systems.Schedule()) void{
            _ = self;
            schedule.progress();
        }
        
    };
}

