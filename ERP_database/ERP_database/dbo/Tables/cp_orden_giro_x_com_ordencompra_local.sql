CREATE TABLE [dbo].[cp_orden_giro_x_com_ordencompra_local] (
    [og_IdEmpresa]           INT           NOT NULL,
    [og_IdCbteCble]          NUMERIC (18)  NOT NULL,
    [og_IdTipoCbte]          INT           NOT NULL,
    [com_IdEmpresa]          INT           NOT NULL,
    [com_IdSucursal]         INT           NOT NULL,
    [com_IdOrdenCompraLocal] NUMERIC (18)  NOT NULL,
    [og_Observacion]         VARCHAR (500) NULL,
    CONSTRAINT [PK_cp_orden_giro_x_com_ordencompra_local] PRIMARY KEY CLUSTERED ([og_IdEmpresa] ASC, [og_IdCbteCble] ASC, [og_IdTipoCbte] ASC, [com_IdEmpresa] ASC, [com_IdSucursal] ASC, [com_IdOrdenCompraLocal] ASC),
    CONSTRAINT [FK_cp_orden_giro_x_com_ordencompra_local_com_ordencompra_local] FOREIGN KEY ([com_IdEmpresa], [com_IdSucursal], [com_IdOrdenCompraLocal]) REFERENCES [dbo].[com_ordencompra_local] ([IdEmpresa], [IdSucursal], [IdOrdenCompra]),
    CONSTRAINT [FK_cp_orden_giro_x_com_ordencompra_local_cp_orden_giro] FOREIGN KEY ([og_IdEmpresa], [og_IdCbteCble], [og_IdTipoCbte]) REFERENCES [dbo].[cp_orden_giro] ([IdEmpresa], [IdCbteCble_Ogiro], [IdTipoCbte_Ogiro])
);

