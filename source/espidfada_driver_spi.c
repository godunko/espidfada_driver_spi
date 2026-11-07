//
//  Copyright (C) 2026, Vadim Godunko
//
//  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//

#include <driver/spi_common.h>

const int __ada_SIZEOF_spi_bus_config_t = sizeof(spi_bus_config_t);

void __ada_INIT_spi_bus_config_t(spi_bus_config_t *config)
{
    //  GPIO pin configuration, set all to -1 (unassigned)
    *config = (spi_bus_config_t){.iocfg = {-1, -1, -1, -1, -1, -1, -1, -1, -1}};
}