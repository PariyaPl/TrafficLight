module TLS(
input clk,
input rst,
output reg [2:0] LA, //G:100 - Y:010 - R:001
output reg [2:0] LB
);
reg [2:0] c = 'b0;
reg d=0;
always @(posedge clk or negedge clk) begin
	if(~rst) begin
		{c,LA,LB}<=9'b000001100;
	end 
	else begin
		if (c==5) begin
			if({LA,LB}==6'b001100)begin //RG
			{LA,LB}<=6'b001010; //RY
			end
			if({LA,LB}==6'b100001)begin //GR
			{LA,LB}<=6'b010001; //YR
			end
		end
	
		if (c==6)begin
			{LA,LB}<=6'b001001; //RR
			if({LA,LB}==6'b001010)begin //RY
			d<=0;
			end
			if({LA,LB}==6'b010001)begin //YR
			d<=1;
			end
		end

		if (c==7) begin
			if(d==0)begin //RR
			{LA,LB}<=6'b100001; //GR
			end
			if(d==1)begin //RR
			{LA,LB}<=6'b001100; //RG
			end
		end
	c<=c+1'b1;
	end
end
endmodule