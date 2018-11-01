CREATE TABLE [dbo].[com_solicitud_compra_det_pre_aprobacion] (
    [IdEmpresa]           INT           NOT NULL,
    [IdSucursal_SC]       INT           NOT NULL,
    [IdSolicitudCompra]   NUMERIC (18)  NOT NULL,
    [Secuencia_SC]        INT           NOT NULL,
    [IdEstadoAprobacion]  VARCHAR (25)  NOT NULL,
    [IdUsuarioAprueba]    VARCHAR (25)  NULL,
    [FechaHoraAprobacion] DATETIME      NULL,
    [do_observacion]      VARCHAR (550) NULL,
    CONSTRAINT [PK_com_solicitud_compra_det_pre_aprobacion_1] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursal_SC] ASC, [IdSolicitudCompra] ASC, [Secuencia_SC] ASC),
    CONSTRAINT [FK_com_solicitud_compra_det_pre_aprobacion_com_catalogo] FOREIGN KEY ([IdEstadoAprobacion]) REFERENCES [dbo].[com_catalogo] ([IdCatalogocompra]),
    CONSTRAINT [FK_com_solicitud_compra_det_pre_aprobacion_com_solicitud_compra_det] FOREIGN KEY ([IdEmpresa], [IdSucursal_SC], [IdSolicitudCompra], [Secuencia_SC]) REFERENCES [dbo].[com_solicitud_compra_det] ([IdEmpresa], [IdSucursal], [IdSolicitudCompra], [Secuencia])
);

