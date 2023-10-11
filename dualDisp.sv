module dualDisp(input logic [5:0] inputValue, output logic [6:0] disp1, disp2);
logic [3:0] inDisp1, inDisp2;
logic [5:0] inValue=6'b000000;
always_comb
begin
	
		if(inputValue[5]==1) begin//if negative
		
			inValue <= (inputValue ^ 6'b111111) + 6'b000001;//invert bits and add one for twos comp
			
		end else begin
			inValue <= inputValue;//else set value in
			
		end
end
always_comb 
begin
		if(inValue>=6'd10) begin//if greater than or equal to 10, seperate digits
			
			inDisp2 <= inValue % 4'd10;
			inDisp1 <= inValue/(4'd10);
			
		end else begin//else set first digit
		
			inDisp1<=0;
			inDisp2<=inValue;
			
		end
end
displayLogic display1(.dispNum(inDisp1),.dispOut(disp1));
displayLogic display2(.dispNum(inDisp2),.dispOut(disp2));
endmodule