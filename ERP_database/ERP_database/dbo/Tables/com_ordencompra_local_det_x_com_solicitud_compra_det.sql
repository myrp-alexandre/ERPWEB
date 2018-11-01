CREATE TABLE [dbo].[com_ordencompra_local_det_x_com_solicitud_compra_det] (
    [ocd_IdEmpresa]         INT          NOT NULL,
    [ocd_IdSucursal]        INT          NOT NULL,
    [ocd_IdOrdenCompra]     NUMERIC (18) NOT NULL,
    [ocd_Secuencia]         INT          NOT NULL,
    [scd_IdEmpresa]         INT          NOT NULL,
    [scd_IdSucursal]        INT          NOT NULL,
    [scd_IdSolicitudCompra] NUMERIC (18) NOT NULL,
    [scd_Secuencia]         INT          NOT NULL,
    [observacion]           VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_com_ordencompra_local_det_x_com_solicitud_compra_det] PRIMARY KEY CLUSTERED ([ocd_IdEmpresa] ASC, [ocd_IdSucursal] ASC, [ocd_IdOrdenCompra] ASC, [ocd_Secuencia] ASC, [scd_IdEmpresa] ASC, [scd_IdSucursal] ASC, [scd_IdSolicitudCompra] ASC, [scd_Secuencia] ASC),
    CONSTRAINT [FK_com_ordencompra_local_det_x_com_solicitud_compra_det_com_ordencompra_local_det] FOREIGN KEY ([ocd_IdEmpresa], [ocd_IdSucursal], [ocd_IdOrdenCompra], [ocd_Secuencia]) REFERENCES [dbo].[com_ordencompra_local_det] ([IdEmpresa], [IdSucursal], [IdOrdenCompra], [Secuencia]),
    CONSTRAINT [FK_com_ordencompra_local_det_x_com_solicitud_compra_det_com_solicitud_compra_det] FOREIGN KEY ([scd_IdEmpresa], [scd_IdSucursal], [scd_IdSolicitudCompra], [scd_Secuencia]) REFERENCES [dbo].[com_solicitud_compra_det] ([IdEmpresa], [IdSucursal], [IdSolicitudCompra], [Secuencia])
);

