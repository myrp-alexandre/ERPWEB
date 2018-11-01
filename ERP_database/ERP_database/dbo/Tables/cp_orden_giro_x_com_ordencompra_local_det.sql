CREATE TABLE [dbo].[cp_orden_giro_x_com_ordencompra_local_det] (
    [IdEmpresa_Ogiro]  INT           NOT NULL,
    [IdCbteCble_Ogiro] NUMERIC (18)  NOT NULL,
    [IdTipoCbte_Ogiro] INT           NOT NULL,
    [IdEmpresa_OC]     INT           NOT NULL,
    [IdSucursal_OC]    INT           NOT NULL,
    [IdOrdenCompra]    NUMERIC (18)  NOT NULL,
    [Secuencia_OC]     INT           NOT NULL,
    [Secuencia_reg]    INT           NOT NULL,
    [Observacion]      VARCHAR (250) NOT NULL,
    CONSTRAINT [PK_cp_orden_giro_x_com_ordencompra_local_det] PRIMARY KEY CLUSTERED ([IdEmpresa_Ogiro] ASC, [IdCbteCble_Ogiro] ASC, [IdTipoCbte_Ogiro] ASC, [IdEmpresa_OC] ASC, [IdSucursal_OC] ASC, [IdOrdenCompra] ASC, [Secuencia_OC] ASC, [Secuencia_reg] ASC),
    CONSTRAINT [FK_cp_orden_giro_x_com_ordencompra_local_det_com_ordencompra_local_det] FOREIGN KEY ([IdEmpresa_OC], [IdSucursal_OC], [IdOrdenCompra], [Secuencia_OC]) REFERENCES [dbo].[com_ordencompra_local_det] ([IdEmpresa], [IdSucursal], [IdOrdenCompra], [Secuencia]),
    CONSTRAINT [FK_cp_orden_giro_x_com_ordencompra_local_det_cp_orden_giro] FOREIGN KEY ([IdEmpresa_Ogiro], [IdCbteCble_Ogiro], [IdTipoCbte_Ogiro]) REFERENCES [dbo].[cp_orden_giro] ([IdEmpresa], [IdCbteCble_Ogiro], [IdTipoCbte_Ogiro])
);

