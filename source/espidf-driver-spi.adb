--
--  Copyright (C) 2026, Vadim Godunko
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

package body ESPIDF.Driver.SPI is

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize (Self : in out spi_bus_config_t) is

     procedure Imported (config : out spi_bus_config_t)
        with Import, Convention => C,
             External_Name => "__ada_INIT_spi_bus_config_t";

   begin
      Imported (Self);
   end Initialize;

end ESPIDF.Driver.SPI;
