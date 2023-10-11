module displayLogic(input logic [3:0] dispNum, output logic [6:0] dispOut);//input logic set,
always_comb
	begin
		case (dispNum)
			4'd0: dispOut<=7'b1000000;//0
			
			4'd1: dispOut<=7'b1111001;//1
			
			4'd2: dispOut<=7'b0100100;//2
			
			4'd3: dispOut<=7'b0110000;//3
			
			4'd4: dispOut<=7'b0011001;//4
			
			4'd5: dispOut<=7'b0010010;//5
			
			4'd6: dispOut<=7'b0000010;//6
			
			4'd7: dispOut<=7'b1111000;//7
			
			4'd8: dispOut<=7'b0000000;//8
			
			4'd9: dispOut<=7'b0011000;//9
			
			4'd15: dispOut<=7'b0111111;//Plus
			
			default: dispOut<=7'b0111111;//15 error state
		endcase
	end

endmodule