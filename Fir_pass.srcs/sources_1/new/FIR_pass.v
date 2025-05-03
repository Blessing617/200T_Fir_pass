`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/02/20 16:23:08
// Design Name: 
// Module Name: FIR_pass
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module FIR_pass(
                input           clk_50M,
                input           rst_n,
                input  [9:0]    adc_value,
                output [13:0]   dac_value,
                output          adc_clk,
                output          dac_clk
);


PLL_ADC_DAC u_PLL_ADC_DAC(
    .adc_clk        (adc_clk    ),
    .dac_clk        (dac_clk    ),
    .clk_50M        (clk_50M    )
);

FIR u_FIR(
    .clk            (clk_50M    ),
    .rst_n          (rst_n      ),
    .adc_value      (adc_value  ),
    .fir_data       (dac_value  )
);

endmodule
