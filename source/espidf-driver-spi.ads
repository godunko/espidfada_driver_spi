--
--  Copyright (C) 2026, Vadim Godunko
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

pragma Extensions_Allowed (On);

package ESPIDF.Driver.SPI is

   type spi_bus_config_t is limited private;

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
