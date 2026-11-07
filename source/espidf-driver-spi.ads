--
--  Copyright (C) 2026, Vadim Godunko
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

package ESPIDF.Driver.SPI is

   type spi_bus_config_t is limited private;

private

   sizeof_spi_bus_config_t : constant int
   with
     Import,
     Convention    => C,
     External_Name => "__ada_SIZEOF_spi_bus_config_t";

   type spi_bus_config_t is new C_Object_Storage (1 .. sizeof_spi_bus_config_t)
   with Convention => C, Default_Component_Value => 0;

end ESPIDF.Driver.SPI;
