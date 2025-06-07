module sync_8x8_fifo_tb;

  parameter DATA_WIDTH = 8;
  parameter DEPTH = 8;

  reg clk, rst;
  reg we, re;
  reg [DATA_WIDTH-1:0] w_data;
  wire [DATA_WIDTH-1:0] r_data;

  wire full, empty, almost_full, almost_empty;

  integer i;

  sync_8x8_fifo dut (
    .clk(clk),
    .rst(rst),
    .we(we),
    .re(re),
    .w_data(w_data),
    .r_data(r_data),
    .full(full),
    .empty(empty),
    .almost_full(almost_full),
    .almost_empty(almost_empty)
  );

  initial begin

    clk = 0;
    forever #5 clk = ~clk;

  end

  initial begin

    $dumpfile("test_fifo.vcd");
    $dumpvars(0, sync_8x8_fifo_tb);
    
    // monitoring everything
    $monitor("rst = %b | we = %b | re = %b | wp = %0b | rp = %0b | w_data = %b | r_data = %b | full = %b | empty = %b | almost_full = %b | almost_empty = %b | overrun = %b | underrun = %b |", rst, we, re, dut.wp, dut.rp, w_data, r_data, full, empty, almost_full, almost_empty, dut.overrun, dut.underrun);


    rst = 0; we = 0; re = 0; w_data = 0;
    #12 rst = 1;

    // first we make we = 1 and write the random 8 bit data to each slot of the fifo
    repeat (8) begin
      @(posedge clk);
      we = 1;
      w_data = $random;
    end


    @(posedge clk) we = 0;    
    
    
    // loop for viewing each slot data in FIFO after write and before read
    for(i=0; i < DEPTH; i = i + 1) begin
      $display("Data @%0b is %0b", i, dut.fifo[i]);
    end
    
    //@(posedge clk) rst = 0; // test reset inbetween
    
    // now data has been written into fifo. Make re = 1, and read data.
    repeat (8) begin
      @(posedge clk);
      re = 1;
    end

    @(posedge clk) re = 0;
    
    
    // when both we and re are high.
    /*
    repeat (5) begin
      @(posedge clk)
      we = 1;
      w_data = $random;
      re = 1;
    end
    
    @(posedge clk); we = 0; re = 0;
	*/
    
    
    #20;

    // loop for viewing each slot data in FIFO after read (all data will be consumed)
    for(i=0; i < DEPTH; i = i + 1) begin
      $display("Data @%0b is %0b", i, dut.fifo[i]);
    end

    #10;
    $finish;

  end


endmodule