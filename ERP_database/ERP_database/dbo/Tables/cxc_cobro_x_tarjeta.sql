CREATE TABLE [dbo].[cxc_cobro_x_tarjeta] (
    [IdEmpresa]             INT          NOT NULL,
    [IdSucursal]            INT          NOT NULL,
    [IdCobro]               NUMERIC (18) NOT NULL,
    [IdCobro_tipo]          VARCHAR (15) NOT NULL,
    [IdCobro_Aplicado]      NUMERIC (18) NOT NULL,
    [IdCobro_tipo_Aplicado] VARCHAR (15) NOT NULL,
    [IdCbte_vta_aplicado]   NUMERIC (18) NOT NULL,
    CONSTRAINT [PK_cxc_cobro_x_tarjeta] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursal] ASC, [IdCobro] ASC, [IdCobro_tipo] ASC, [IdCobro_Aplicado] ASC, [IdCobro_tipo_Aplicado] ASC, [IdCbte_vta_aplicado] ASC),
    CONSTRAINT [FK_cxc_cobro_x_tarjeta_cxc_cobro] FOREIGN KEY ([IdEmpresa], [IdSucursal], [IdCobro]) REFERENCES [dbo].[cxc_cobro] ([IdEmpresa], [IdSucursal], [IdCobro])
);

