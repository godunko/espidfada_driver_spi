//
//  Copyright (C) 2026, Vadim Godunko
//
//  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//

#include <driver/spi_common.h>
#include <driver/spi_master.h>

const int __ada_SIZEOF_spi_bus_config_t = sizeof(spi_bus_config_t);
const int __ada_SIZEOF_spi_device_interface_config_t =
    sizeof(spi_device_interface_config_t);

void __ada_INIT_spi_bus_config_t(spi_bus_config_t *config)
{
    //  GPIO pin configuration, set all to -1 (unassigned)
    *config = (spi_bus_config_t){.iocfg = {-1, -1, -1, -1, -1, -1, -1, -1, -1}};
}

void __ada_SET_spi_bus_config_t_mosi_io_num(spi_bus_config_t *config, int io_num)
{
    config->mosi_io_num = io_num;
}

void __ada_SET_spi_bus_config_t_miso_io_num(spi_bus_config_t *config, int io_num)
{
    config->miso_io_num = io_num;
}

void __ada_SET_spi_bus_config_t_sclk_io_num(spi_bus_config_t *config, int io_num)
{
    config->sclk_io_num = io_num;
}