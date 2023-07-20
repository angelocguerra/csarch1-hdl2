// GUERRA, Jose Maria Angelo C. (S17)

`timescale 1ns / 1ps

/*
    Structural Modeling
    Structural Function: 2x4 Positive Output, Positive Enable Decoder
    Boolean Function: F = A (CD + B) + BC'
*/

module som_dec_2x4_pope_behav_tb();

    // Declare local reg and wire identifiers
    reg[3:0] t_input;
    reg t_E;
    wire t_F;
    integer i;

    // Instantiate the design module under test
    //som_dec_2x4_pope_behav dut(t_F, t_input[3], t_input[2], t_input[1], t_input[0],t_E);
    main dut(t_F, t_input[3], t_input[2], t_input[1], t_input[0],t_E);

    // Generate stimulus using initial statements
    initial
        begin
            // Enable = 1 (Positive)
            t_input = 4'b0000;
            t_E = 1;
            for(i = 1; i <= 17; i++)
                #10 t_input = i; // Every 10ns, value 0000 becomes 0001 and so on until it goes back to 0000

            $display(""); // line break

            // Enable = 0 (Negative)
            t_input = 4'b0000;
            t_E = 0;
            for(i = 1; i <= 17; i++)
                #10 t_input = i; // Every 10ns, value 0000 becomes 0001 and so on until it goes back to 0000

        end

    // Display the output response (text or graphics (or both))
    initial
    begin
        $display("Written by Jose Maria Angelo Guerra (S17)");
        $display("F = A (CD + B) + BC'");
        $display("2x4 Positive Output, Positive Enable Decoder");

        $monitor("Time = %03d | A = %b B = %b C = %b D = %b | E = %b | Output_F = %b",
                 $time, t_input[3], t_input[2], t_input[1], t_input[0], t_E, t_F);
        $dumpfile("YGueJ_dump.vcd");
        $dumpvars();
    end

endmodule
