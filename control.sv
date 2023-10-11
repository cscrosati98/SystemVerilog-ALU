module control(input logic iclk, set, rst, oFin,
					input logic [5:0] a,b,z,
					output logic [6:0] aDisp1,aDisp2,
					output logic [6:0] bDisp1,bDisp2,
					output logic [6:0] zDisp1,zDisp2,
					output logic oFout,aNeg,bNeg,zNeg);
	
	logic rstSync, setSync;
	logic [5:0] aDisp,bDisp,zDisp;
	synchronizer sync(.clock(iclk),.signal(set), .fallEdge(setSync));	
	
	reset	res(.clk(iclk), .rst(rst), .rstSync(rstSync));
	
	dualDisp dispA(.inputValue(aDisp),.disp1(aDisp1),.disp2(aDisp2));
	dualDisp dispB(.inputValue(bDisp),.disp1(bDisp1),.disp2(bDisp2));
	dualDisp dispZ(.inputValue(zDisp),.disp1(zDisp1),.disp2(zDisp2));
	
	always_ff@(posedge iclk or negedge rstSync) begin
		if (~rstSync) begin//if reset not active
			aDisp<=5'd0;
			bDisp<=5'd0;
			zDisp<=5'd0;
			oFout<=1'b0;
			aNeg<=1'b0;
			bNeg<=1'b0;
			zNeg<=1'b1;
		end else if(setSync) begin//else assign all inputs and outputs!
			aDisp<=a;
			bDisp<=b;
			zDisp<=z;
			oFout<=oFin;
			aNeg<=a[5];
			bNeg<=b[5];
			zNeg<=~z[5];
		end
	end

	
	
endmodule