--
--  Copyright (C) 2026, Vadim Godunko
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

pragma Extensions_Allowed (On);

with ESPIDF.Driver.GPIO;

package ESPIDF.Driver.SPI is

   type spi_host_device_t is (SPI1_HOST, SPI2_HOST, SPI3_HOST)
   with Convention => C;
   for spi_host_device_t use (SPI1_HOST => 0, SPI2_HOST => 1, SPI3_HOST => 2);

   type spi_common_dma_t is
     (SPI_DMA_DISABLED, SPI_DMA_CH1, SPI_DMA_CH2, SPI_DMA_CH_AUTO)
   with Convention => C;
   for spi_common_dma_t use
     (SPI_DMA_DISABLED => 0,
      SPI_DMA_CH1      => 1,
      SPI_DMA_CH2      => 2,
      SPI_DMA_CH_AUTO  => 3);

   type spi_bus_config_t is limited private;
   --  Default initialization sets all GPIO pins to an invalid state. Application
   --  should set the appropriate pins using the provided procedures.

   procedure Set_mosi_io_num
     (Self : in out spi_bus_config_t; Io_Num : ESPIDF.Driver.GPIO.gpio_num_t)
   with
     Import,
     Convention    => C,
     External_Name => "__ada_SET_spi_bus_config_t_mosi_io_num";

   procedure Set_miso_io_num
     (Self : in out spi_bus_config_t; Io_Num : ESPIDF.Driver.GPIO.gpio_num_t)
   with
     Import,
     Convention    => C,
     External_Name => "__ada_SET_spi_bus_config_t_miso_io_num";

   procedure Set_sclk_io_num
     (Self : in out spi_bus_config_t; Io_Num : ESPIDF.Driver.GPIO.gpio_num_t)
   with
     Import,
     Convention    => C,
     External_Name => "__ada_SET_spi_bus_config_t_sclk_io_num";

private

   sizeof_spi_bus_config_t : constant int
   with
     Import,
     Convention    => C,
     External_Name => "__ada_SIZEOF_spi_bus_config_t";

   type spi_bus_config_t_Storage is
     new C_Object_Storage (1 .. sizeof_spi_bus_config_t)
   with Convention => C;

   procedure Initialize (Self : in out spi_bus_config_t);

   type spi_bus_config_t is limited record
      Storage : spi_bus_config_t_Storage;
   end record
   with
     Convention  => C,
     Finalizable => (Initialize => Initialize, Relaxed_Finalization => True);

   pragma Assert
     (spi_bus_config_t'Size
      = sizeof_spi_bus_config_t * C_Storage_Element'Size,
      "Size of spi_bus_config_t does not match expected size");

end ESPIDF.Driver.SPI;
