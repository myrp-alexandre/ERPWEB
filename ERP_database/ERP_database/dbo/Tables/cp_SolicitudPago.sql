CREATE TABLE [dbo].[cp_SolicitudPago] (
    [IdEmpresa]             INT            NOT NULL,
    [IdSolicitud]           NUMERIC (18)   NOT NULL,
    [Fecha]                 DATETIME       NOT NULL,
    [IdProveedor]           NUMERIC (18)   NOT NULL,
    [Concepto]              VARCHAR (MAX)  NOT NULL,
    [Estado]                BIT            NOT NULL,
    [Valor]                 FLOAT (53)     NOT NULL,
    [Solicitante]           VARCHAR (1000) NOT NULL,
    [IdUsuarioCreacion]     VARCHAR (50)   NULL,
    [FechaCreacion]         DATETIME       NULL,
    [IdUsuarioModificacion] VARCHAR (50)   NULL,
    [FechaModificacion]     DATETIME       NULL,
    [IdUsuarioAnulacion]    VARCHAR (50)   NULL,
    [FechaAnulacion]        DATETIME       NULL,
    [MotivoAnulacion]       VARCHAR (MAX)  NULL,
    CONSTRAINT [PK_cp_SolicitudPago] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSolicitud] ASC),
    CONSTRAINT [FK_cp_SolicitudPago_cp_proveedor] FOREIGN KEY ([IdEmpresa], [IdProveedor]) REFERENCES [dbo].[cp_proveedor] ([IdEmpresa], [IdProveedor])
);

