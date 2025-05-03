`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/02/20 16:20:53
// Design Name: 
// Module Name: FIR
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


module FIR(
	input                  clk,
	input                  rst_n,
    input        [9:0]     adc_value,
	output  reg  [13:0]	   fir_data
);

localparam Fre = 10_000_000;
localparam CNT_DIV = (50_000_000 / Fre) - 1;

reg	[31:0] cnt;
reg		  fir_clk;

always @ (posedge clk or negedge rst_n)
begin
	if(!rst_n)
		cnt <= 31'd0;
	else if(cnt == CNT_DIV)
		cnt <= 31'd0;
	else
		cnt <= cnt + 1'b1;
end

always @ (posedge clk or negedge rst_n)
begin
	if(!rst_n)
		fir_clk <= 1'b0;
	else if(cnt == CNT_DIV)
		fir_clk <= 1'b1;
	else
		fir_clk <= 1'b0;
end

wire	[31:0]	fir_data_t;

fir_compiler fir_10k_lowpass(
  .aclk                         (clk                    ),                             
  .s_axis_data_tvalid           (fir_clk                ),                 
  .s_axis_data_tready           (s_axis_data_tready     ),     
  .s_axis_data_tdata            ({6'b000_000,adc_value} ),  
  .m_axis_data_tvalid           (m_axis_data_tvalid     ),    
  .m_axis_data_tdata            (fir_data_t             )              
);

always @ (posedge clk or negedge rst_n)
begin
	if(!rst_n)
		fir_data <= 14'b0;
	else if(fir_clk == 1'b1)
		fir_data <= {fir_data_t[31],fir_data_t[27:15]}+14'b10_000_000_000_000;            //在valid信号有效的时候才输出数据
end

endmodule
