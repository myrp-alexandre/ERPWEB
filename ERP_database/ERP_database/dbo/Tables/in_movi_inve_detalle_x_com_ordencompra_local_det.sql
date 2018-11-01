CREATE TABLE [dbo].[in_movi_inve_detalle_x_com_ordencompra_local_det] (
    [mi_IdEmpresa]         INT          NOT NULL,
    [mi_IdSucursal]        INT          NOT NULL,
    [mi_IdBodega]          INT          NOT NULL,
    [mi_IdMovi_inven_tipo] INT          NOT NULL,
    [mi_IdNumMovi]         NUMERIC (18) NOT NULL,
    [mi_Secuencia]         INT          NOT NULL,
    [ocd_IdEmpresa]        INT          NOT NULL,
    [ocd_IdSucursal]       INT          NOT NULL,
    [ocd_IdOrdenCompra]    NUMERIC (18) NOT NULL,
    [ocd_Secuencia]        INT          NOT NULL,
    [observacion]          VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_in_movi_inve_detalle_] PRIMARY KEY CLUSTERED ([mi_IdEmpresa] ASC, [mi_IdSucursal] ASC, [mi_IdBodega] ASC, [mi_IdMovi_inven_tipo] ASC, [mi_IdNumMovi] ASC, [mi_Secuencia] ASC, [ocd_IdEmpresa] ASC, [ocd_IdSucursal] ASC, [ocd_IdOrdenCompra] ASC, [ocd_Secuencia] ASC),
    CONSTRAINT [FK_in_movi_inve_detalle_x_com_ordencompra_local_det_com_ordencompra_local_det] FOREIGN KEY ([ocd_IdEmpresa], [ocd_IdSucursal], [ocd_IdOrdenCompra], [ocd_Secuencia]) REFERENCES [dbo].[com_ordencompra_local_det] ([IdEmpresa], [IdSucursal], [IdOrdenCompra], [Secuencia]),
    CONSTRAINT [FK_in_movi_inve_detalle_x_com_ordencompra_local_det_in_movi_inve_detalle] FOREIGN KEY ([mi_IdEmpresa], [mi_IdSucursal], [mi_IdBodega], [mi_IdMovi_inven_tipo], [mi_IdNumMovi], [mi_Secuencia]) REFERENCES [dbo].[in_movi_inve_detalle] ([IdEmpresa], [IdSucursal], [IdBodega], [IdMovi_inven_tipo], [IdNumMovi], [Secuencia])
);

