module curtains_control (
    input wire outdoor_light,
    input wire curtains,
    input wire clk,
    input wire reset,
    output reg curtain_1,
    output reg curtain_2,
    output reg light_status
);

    reg [1:0] curtain_state, next_curtain_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            curtain_state <= 2'b00;
        else
            curtain_state <= next_curtain_state;
    end

    always @(*) begin
        next_curtain_state = curtain_state;
        curtain_1 = 0;
        curtain_2 = 0;
        light_status = 0;

        case (curtain_state)
            2'b00: if (outdoor_light && !curtains) begin
                next_curtain_state = 2'b01;
                curtain_1 = 1;
                curtain_2 = 1;
            end
            2'b01: if (!outdoor_light && curtains) begin
                next_curtain_state = 2'b10;
                curtain_1 = 0;
                curtain_2 = 0;
                light_status = 1;
            end else begin
                light_status = 0;
            end
            2'b10: if (!outdoor_light && !curtains) begin
                next_curtain_state = 2'b11;
                light_status = 1;
            end
            2'b11: if (outdoor_light && !curtains) begin
                next_curtain_state = 2'b00;
                curtain_1 = 1;
                curtain_2 = 1;
            end
            default: next_curtain_state = 2'b00;
        endcase
    end

endmodule
