module thruwire(input sw1_btn, output ledg, output ledr);
    assign ledg = ~sw1_btn;
    assign ledr = sw1_btn;
endmodule