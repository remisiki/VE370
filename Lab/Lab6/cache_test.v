`timescale 1ns / 1ps

module tb_cache;
    reg          clock;
    
    // interface between cache and CPU
    wire         read_write_cache; /* 1 if write, 0 if read */
    wire [9:0]   address_cache;
    wire [31:0]  write_data_cache;
    // interface between cache and main memory
    wire [31:0]  read_data_mem_db, read_data_cache_db, write_data_mem_db;
    wire [9:0]   address_mem_db;
    
    direct_back_cache   cache_db(read_write_cache, address_cache, write_data_cache, read_data_mem_db, done, read_data_cache_db, hit_miss_db, read_write_mem_db, address_mem_db, write_data_mem_db);
    main_mem            mem_db(read_write_mem_db, address_mem_db, write_data_mem_db, read_data_mem_db, done);
    CPU                 CPU_db(hit_miss_db, clock, read_write_cache, address_cache, write_data_cache);
    always #5 clock = ~clock;
    
    initial begin
        clock = 0;
        #80 $stop;
    end
endmodule
