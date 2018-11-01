CREATE TABLE [Grafinpren].[cxc_Comisiones_x_vendedor] (
    [IdEmpresa]    INT          NOT NULL,
    [IdSucursal]   INT          NOT NULL,
    [IdCobro]      NUMERIC (18) NOT NULL,
    [Secuencia]    INT          NOT NULL,
    [Porc_pagado]  FLOAT (53)   NOT NULL,
    [Valor_pagado] FLOAT (53)   NOT NULL,
    CONSTRAINT [PK_cxc_Comisiones_x_vendedor] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursal] ASC, [IdCobro] ASC, [Secuencia] ASC)
);

