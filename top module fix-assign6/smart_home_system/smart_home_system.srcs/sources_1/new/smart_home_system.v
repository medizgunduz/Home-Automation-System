`timescale 1ns / 1ps

module smart_home_system (
    input wire [7:0] temperature,
    input wire [7:0] humidity,
    input wire livingroommotion_sensor,
    input wire bedroommotion_sensor,
    input wire kitchenmotion_sensor,
    input wire bathroommotion_sensor,
    input wire time_window,
    input wire indoor_light,
    input wire outdoor_light,
    input wire curtains,
    input wire reset,
    input wire clk,
    
    output wire z,
    output wire livingroom_lights,
    output wire bedroom_lights,
    output wire kitchen_lights,
    output wire bathroom_lights,
    output wire light_status,
    output wire curtain_1,
    output wire curtain_2
);

    // Climate Control Alt Modülü
    climate_control climate_ctrl (
        .temperature(temperature),
        .humidity(humidity),
        .clk(clk),
        .reset(reset),
        .z(z)
    );

    // Lights Control Alt Modülleri
    lights_control livingroom_ctrl (
        .motion_sensor(livingroommotion_sensor),
        .time_window(time_window),
        .clk(clk),
        .reset(reset),
        .light_output(livingroom_lights)
    );

    lights_control bedroom_ctrl (
        .motion_sensor(bedroommotion_sensor),
        .time_window(time_window),
        .clk(clk),
        .reset(reset),
        .light_output(bedroom_lights)
    );

    lights_control kitchen_ctrl (
        .motion_sensor(kitchenmotion_sensor),
        .time_window(time_window),
        .clk(clk),
        .reset(reset),
        .light_output(kitchen_lights)
    );

    lights_control bathroom_ctrl (
        .motion_sensor(bathroommotion_sensor),
        .time_window(time_window),
        .clk(clk),
        .reset(reset),
        .light_output(bathroom_lights)
    );

    // Curtains Control Alt Modülü
    curtains_control curtain_ctrl (
        .outdoor_light(outdoor_light),
        .curtains(curtains),
        .clk(clk),
        .reset(reset),
        .curtain_1(curtain_1),
        .curtain_2(curtain_2),
        .light_status(light_status)
    );

endmodule

