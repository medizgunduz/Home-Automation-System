module lights_control (
    input wire motion_sensor,
    input wire time_window,
    input wire clk,
    input wire reset,
    output reg light_output
);

    reg state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 0;
        else if (motion_sensor && time_window)
            state <= 1;
        else
            state <= 0;
    end

    always @(*) begin
        light_output = state;
    end

endmodule

