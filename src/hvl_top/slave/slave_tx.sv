`ifndef SLAVE_TX_INCLUDED_
`define SLAVE_TX_INCLUDED_

`define cs_length 2
`define DW 2**`SIZE
`define SIZE 3
//--------------------------------------------------------------------------------------------
// Class: slave_tx
// Description: this class holds the data items required to drive stimulus to duv
//--------------------------------------------------------------------------------------------
class slave_tx extends uvm_sequence_item;

  // factory registration
  `uvm_object_utils(slave_tx)

  //input signals
  rand bit [`DW-1:0]master_in_slave_out[$];
       bit [`cs_length-1:0] cs;

       bit [`DW-1:0] master_out_slave_in[$];

//--------------------------------------------------------------------------------------------
// Constraints for SPI
//--------------------------------------------------------------------------------------------

constraint miso{master_in_slave_out.size()>0 && master_in_slave_out.size()<8;}

//-------------------------------------------------------
// Externally defined Tasks and Functions
//-------------------------------------------------------
  extern function new(string name = "slave_tx");
  extern function void do_copy(uvm_object rhs);
  extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
  extern function void do_print(uvm_printer printer);

endclass : slave_tx

//--------------------------------------------------------------------------------------------
// Construct: new
// initializes the class object
// Parameters: 
// instance name of the slave template
//--------------------------------------------------------------------------------------------
function slave_tx::new(string name = "slave_tx");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// do_copy method
//--------------------------------------------------------------------------------------------

function void slave_tx::do_copy (uvm_object rhs);
  slave_tx rhs_;

  if(!$cast(rhs_,rhs)) begin
  `uvm_fatal("do_copy","cast of the rhs object failed")
  end
  super.do_copy(rhs);
  cs= rhs_.cs;
  foreach(master_in_slave_out[i])
  master_in_slave_out[i]= rhs_.master_in_slave_out[i];
  foreach(master_out_slave_in[i])
  master_out_slave_in[i]= rhs_.master_out_slave_in[i];
endfunction:do_copy


//--------------------------------------------------------------------------------------------
// do_compare method
//--------------------------------------------------------------------------------------------
function bit  slave_tx::do_compare (uvm_object rhs,uvm_comparer comparer);
  slave_tx rhs_;

  if(!$cast(rhs_,rhs)) begin
  `uvm_fatal("do_compare","cast of the rhs object failed")
  return 0;
  end

  return super.do_compare(rhs,comparer) &&
  master_in_slave_out== rhs_.master_in_slave_out &&
  master_out_slave_in== rhs_.master_out_slave_in;
endfunction:do_compare


//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//--------------------------------------------------------------------------------------------
function void slave_tx::do_print(uvm_printer printer);
  super.do_print(printer);
       printer.print_field( "cs", cs , 2,UVM_DEC);
       foreach(master_in_slave_out[i])
       printer.print_field($sformatf("master_in_slave_out[%0d]",i),this.master_in_slave_out[i],8,UVM_HEX);
       foreach(master_out_slave_in[i])
       printer.print_field($sformatf("master_out_slave_in[%0d]",i),this.master_out_slave_in[i],8,UVM_HEX);
endfunction:do_print

`endif

