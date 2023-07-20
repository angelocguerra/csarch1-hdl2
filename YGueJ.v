// GUERRA, Jose Maria Angelo C. (S17)

`timescale 1ns / 1ps

/*
    Structural Modeling
    Structural Function: 2x4 Positive Output, Positive Enable Decoder
    Boolean Function: F = A (CD + B) + BC'
*/

module dec_2x4_behav(i,en,m);
    // Define input and output
    output reg [0:3] m;
    input [1:0] i, en;

    // Define decoder structure
    always @*
    begin
        if(en) // en = 1 : the decoder will be enabled
            begin
                m[0] = ~i[1] & ~i[0]; // 00
                m[1] = ~i[1] & i[0]; // 01
                m[2] = i[1] & ~i[0]; // 10
                m[3] = i[1] & i[0]; // 11
            end
        else // en = 0 : the decoder will be disabled
            // values will be set to 0 as default
            {m[0,m[1],m[2],m[3]]} = 4'b0000
    end
endmodule

/*
    Sum of Minterm of Boolean Function:
    S_m = {4,5,11,12,13,14,15}
*/
module som_dec_2x4_pope_behav(F,A,B,C,D,E);
    // Define input and output
    output reg F;
    input A,B,C,D,E;

    // Define decoder structure
    wire [0:3] d; // Minterms 0-3 for Decoders 1-4
                  // Decoders 1-4 for inputs C and D
    wire [0:15] m; // Minterms 0-15

    // Call and assign decoder functions
    dec_2x4_behav(A,B,en,d[0],d[1],d[2],d[3]); // Decoder 0 for inputs A and B
    dec_2x4_behav(C,D,d[0],m[0],m[1],m[2],m[3]); // Decoder 1
    dec_2x4_behav(C,D,d[1],m[4],m[5],m[6],m[7]); // Decoder 2
    dec_2x4_behav(C,D,d[2],m[8],m[9],m[10],m[11]); // Decoder 3
    dec_2x4_behav(C,D,d[3],m[12],m[13],m[14],m[15]); // Decoder 4

    always @*
    begin
        if(en) // If en = 1, decoder is enabled
            F = m[4] | m[5] | m[11] | m[12] | m[13] | m[14] | m[15];
        else // en = 0, decoder is disabled
            F = 1'bZ;
    end

endmodule