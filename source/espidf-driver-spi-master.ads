--
--  Copyright (C) 2026, Vadim Godunko
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

pragma Extensions_Allowed (On);

with System;

package ESPIDF.Driver.SPI.Master is

   SPI_DEVICE_TXBIT_LSBFIRST   : constant uint32_t := 2#0_0000_0001#;
   SPI_DEVICE_RXBIT_LSBFIRST   : constant uint32_t := 2#0_0000_0010#;
   SPI_DEVICE_BIT_LSBFIRST     : constant uint32_t :=
     (SPI_DEVICE_TXBIT_LSBFIRST or SPI_DEVICE_RXBIT_LSBFIRST);
   SPI_DEVICE_3WIRE            : constant uint32_t := 2#0_0000_0100#;
   SPI_DEVICE_POSITIVE_CS      : constant uint32_t := 2#0_0000_1000#;
   SPI_DEVICE_HALFDUPLEX       : constant uint32_t := 2#0_0001_0000#;
   SPI_DEVICE_CLK_AS_CS        : constant uint32_t := 2#0_0010_0000#;
   SPI_DEVICE_NO_DUMMY         : constant uint32_t := 2#0_0100_0000#;
   SPI_DEVICE_DDRCLK           : constant uint32_t := 2#0_1000_0000#;
   SPI_DEVICE_NO_RETURN_RESULT : constant uint32_t := 2#1_0000_0000#;

   SPI_TRANS_MODE_DIO         : constant uint32_t := 2#0000_0000_0000_0001#;
   SPI_TRANS_MODE_QIO         : constant uint32_t := 2#0000_0000_0000_0010#;
   SPI_TRANS_USE_RXDATA       : constant uint32_t := 2#0000_0000_0000_0100#;
   SPI_TRANS_USE_TXDATA       : constant uint32_t := 2#0000_0000_0000_1000#;
   SPI_TRANS_MODE_DIOQIO_ADDR : constant uint32_t := 2#0000_0000_0001_0000#;
   SPI_TRANS_VARIABLE_CMD     : constant uint32_t := 2#0000_0000_0010_0000#;
   SPI_TRANS_VARIABLE_ADDR    : constant uint32_t := 2#0000_0000_0100_0000#;
   SPI_TRANS_VARIABLE_DUMMY   : constant uint32_t := 2#0000_0000_1000_0000#;
   SPI_TRANS_CS_KEEP_ACTIVE   : constant uint32_t := 2#0000_0001_0000_0000#;
   SPI_TRANS_MULTILINE_CMD    : constant uint32_t := 2#0000_0010_0000_0000#;
   SPI_TRANS_MODE_OCT         : constant uint32_t := 2#0000_0100_0000_0000#;
   SPI_TRANS_MULTILINE_ADDR   : constant uint32_t :=
     SPI_TRANS_MODE_DIOQIO_ADDR;
   SPI_TRANS_DMA_BUFFER_ALIGN_MANUAL : constant uint32_t :=
     2#0000_1000_0000_0000#;
   SPI_TRANS_DMA_USE_PSRAM    : constant uint32_t := 2#0001_0000_0000_0000#;

   SPI_TRANS_DMA_RX_FAIL : constant uint32_t :=
     2#0100_0000_0000_0000_0000_0000_0000_0000#;
   SPI_TRANS_DMA_TX_FAIL : constant uint32_t :=
     2#1000_0000_0000_0000_0000_0000_0000_0000#;

   type spi_device_t is limited private;

   type spi_device_handle_t is access spi_device_t with Convention => C;

   type spi_device_interface_config_t is limited private;
   --  Default initialization sets spics_io_num to -1 and all other fields to zero.

   type spi_transaction_t is limited private;

   type transaction_cb_t is access procedure (Trans : in out spi_transaction_t)
   with Convention => C;

   -----------------------------------
   -- spi_device_interface_config_t --
   -----------------------------------

   procedure Set_clock_speed_hz
     (Self : in out spi_device_interface_config_t; Clock_Speed_Hz : int)
   with
     Import,
     Convention    => C,
     External_Name => "__ada_SET_spi_device_interface_config_t_clock_speed_hz";

   procedure Set_flags
     (Self : in out spi_device_interface_config_t; Flags : uint32_t)
   with
     Import,
     Convention    => C,
     External_Name => "__ada_SET_spi_device_interface_config_t_flags";

   procedure Set_post_cb
     (Self : in out spi_device_interface_config_t; Post_Cb : transaction_cb_t)
   with
     Import,
     Convention    => C,
     External_Name => "__ada_SET_spi_device_interface_config_t_post_cb";

   procedure Set_pre_cb
     (Self : in out spi_device_interface_config_t; Pre_Cb : transaction_cb_t)
   with
     Import,
     Convention    => C,
     External_Name => "__ada_SET_spi_device_interface_config_t_pre_cb";

   procedure Set_queue_size
     (Self : in out spi_device_interface_config_t; Queue_Size : int)
   with
     Import,
     Convention    => C,
     External_Name => "__ada_SET_spi_device_interface_config_t_queue_size";

   procedure Set_spics_io_num
     (Self         : in out spi_device_interface_config_t;
      Spics_Io_Num : ESPIDF.Driver.GPIO.gpio_num_t)
   with
     Import,
     Convention    => C,
     External_Name => "__ada_SET_spi_device_interface_config_t_spics_io_num";

   -----------------------
   -- spi_transaction_t --
   -----------------------

   procedure Set_flags (Self : in out spi_transaction_t; Flags : uint32_t)
   with
     Import,
     Convention    => C,
     External_Name => "__ada_SET_spi_transaction_t_flags";

   procedure Set_length (Self : in out spi_transaction_t; Length : size_t)
   with
     Import,
     Convention    => C,
     External_Name => "__ada_SET_spi_transaction_t_length";

   procedure Set_tx_buffer
     (Self : in out spi_transaction_t; Tx_Buffer : System.Address)
   with
     Import,
     Convention    => C,
     External_Name => "__ada_SET_spi_transaction_t_tx_buffer";

   --------------------
   -- SPI Master API --
   --------------------

   function spi_bus_initialize
     (host_id    : spi_host_device_t;
      bus_config : spi_bus_config_t;
      dma_chan   : spi_common_dma_t) return esp_err_t
   with Import, Convention => C, External_Name => "spi_bus_initialize";

   procedure spi_bus_initialize
     (host_id    : spi_host_device_t;
      bus_config : spi_bus_config_t;
      dma_chan   : spi_common_dma_t);

   function spi_bus_add_device
     (host_id    : spi_host_device_t;
      dev_config : spi_device_interface_config_t;
      handle     : out spi_device_handle_t) return esp_err_t
   with Import, Convention => C, External_Name => "spi_bus_add_device";

   procedure spi_bus_add_device
     (host_id    : spi_host_device_t;
      dev_config : spi_device_interface_config_t;
      handle     : out spi_device_handle_t);

   function spi_device_acquire_bus
     (device : spi_device_handle_t) return esp_err_t
   with
     Import,
     Convention    => C,
     External_Name => "__ada_spi_device_acquire_bus";

   procedure spi_device_acquire_bus (device : spi_device_handle_t);

private

   sizeof_spi_device_interface_config_t : constant int
   with
     Import,
     Convention    => C,
     External_Name => "__ada_SIZEOF_spi_device_interface_config_t";
   sizeof_spi_transaction_t             : constant int
   with
     Import,
     Convention    => C,
     External_Name => "__ada_SIZEOF_spi_transaction_t";

   type spi_device_interface_config_t_Storage is
     new C_Object_Storage (1 .. sizeof_spi_device_interface_config_t)
   with Convention => C;

   procedure Initialize (Self : in out spi_device_interface_config_t);

   type spi_device_interface_config_t is limited record
      Storage : spi_device_interface_config_t_Storage;
   end record
   with
     Convention  => C,
     Finalizable => (Initialize => Initialize, Relaxed_Finalization => True);

   pragma Assert
     (spi_device_interface_config_t'Size
      = sizeof_spi_device_interface_config_t * C_Storage_Element'Size,
      "Size of spi_device_interface_config_t does not match expected size");

   type spi_device_t is limited null record with Convention => C;

   type spi_transaction_t is new C_Object_Storage (1 .. sizeof_spi_transaction_t)
     with Convention              => C,
          Default_Component_Value => 0;

end ESPIDF.Driver.SPI.Master;
