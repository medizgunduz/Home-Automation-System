module climate_control (
    input wire [7:0] temperature,
    input wire [7:0] humidity,
    input wire clk,
    input wire reset,
    output reg z
);

    reg [1:0] current_state, next_state;
    wire condition_met;

    assign condition_met = 
        ((temperature < 18) | (temperature > 22)) & 
        ((humidity < 40) | (humidity > 60));

    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= 2'b00;
        else
            current_state <= next_state;
    end

    always @(*) begin
        case (current_state)
            2'b00: next_state = (condition_met) ? 2'b01 : 2'b00;
            2'b01: next_state = (!condition_met) ? 2'b00 : 2'b01;
            default: next_state = 2'b00;
        endcase
    end

    always @(*) begin
        case (current_state)
            2'b00: z = 0;
            2'b01: z = condition_met;
            default: z = 0;
        endcase
    end

endmodule
