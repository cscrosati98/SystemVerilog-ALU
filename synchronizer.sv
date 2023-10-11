module synchronizer(input logic clock, signal, rst,
							output logic syncSignal, fallEdge, riseEdge);
		logic sFF1, sFF2;
		always_ff@(posedge clock or negedge rst)//Sync signal using FF's
		begin
		if(~rst)begin
			sFF1<=1'b0;
			syncSignal<=1'b0;
			sFF2<=1'b0;
		end else begin
			sFF1<=signal;
			syncSignal<=sFF1;
			sFF2<=syncSignal;
		end
		end
		// 0 1 Falling edge
		assign fallEdge = (~syncSignal && sFF2);
		// 1 0 Rising Edge
		assign riseEdge = (syncSignal && ~sFF2);
endmodule