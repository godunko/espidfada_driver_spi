--
--  Copyright (C) 2026, Vadim Godunko
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

package ESPIDF.Driver.SPI.Master is

   type spi_device_interface_config_t is limited private;

   type spi_device_t is limited private;

   type spi_device_handle_t is access spi_device_t with Convention => C;

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

private

   sizeof_spi_device_interface_config_t : constant int
   with
     Import,
     Convention    => C,
     External_Name => "__ada_SIZEOF_spi_device_interface_config_t";

   type spi_device_interface_config_t is
     new C_Object_Storage (1 .. sizeof_spi_device_interface_config_t)
   with Convention => C, Default_Component_Value => 0;

   type spi_device_t is limited null record with Convention => C;

end ESPIDF.Driver.SPI.Master;