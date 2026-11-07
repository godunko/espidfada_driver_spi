--
--  Copyright (C) 2026, Vadim Godunko
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

with ESPIDF.Ada_ESP_Check_Error;

package body ESPIDF.Driver.SPI.Master is

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize (Self : in out spi_device_interface_config_t) is

     procedure Imported (config : out spi_device_interface_config_t)
        with Import, Convention => C,
             External_Name => "__ada_INIT_spi_device_interface_config_t";

   begin
      Imported (Self);
   end Initialize;

   ------------------------
   -- spi_bus_add_device --
   ------------------------

   procedure spi_bus_add_device
     (host_id    : spi_host_device_t;
      dev_config : spi_device_interface_config_t;
      handle     : out spi_device_handle_t) is
   begin
      ESPIDF.Ada_ESP_Check_Error
        (spi_bus_add_device (host_id, dev_config, handle));
   end spi_bus_add_device;

   ------------------------
   -- spi_bus_initialize --
   ------------------------

   procedure spi_bus_initialize
     (host_id    : spi_host_device_t;
      bus_config : spi_bus_config_t;
      dma_chan   : spi_common_dma_t) is
   begin
      ESPIDF.Ada_ESP_Check_Error
        (spi_bus_initialize (host_id, bus_config, dma_chan));
   end spi_bus_initialize;

end ESPIDF.Driver.SPI.Master;
