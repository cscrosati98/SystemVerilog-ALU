module reset(input logic clk, rst,
					output logic rstSync);
					
	logic intRst;
	
	always_ff@(posedge clk or negedge rst) begin
		if(~rst) begin
			intRst<=1'b0;
			rstSync<=1'b0;
		end else begin
			intRst<=1'b1;
			rstSync<=intRst;
		end
	end

endmodule