CREATE TABLE [dbo].[tb_sis_Documento_Tipo_Reporte_x_Empresa] (
    [IdEmpresa]            INT             NOT NULL,
    [codDocumentoTipo]     VARCHAR (20)    NOT NULL,
    [File_Disenio_Reporte] VARBINARY (MAX) NULL,
    [IdUsuario]            VARCHAR (20)    NULL,
    [Fecha_Transac]        DATETIME        NULL,
    [IdUsuarioUltMod]      VARCHAR (20)    NULL,
    [Fecha_UltMod]         DATETIME        NULL,
    [IdUsuarioUltAnu]      VARCHAR (20)    NULL,
    [Fecha_UltAnu]         DATETIME        NULL,
    [MotivoAnula]          VARCHAR (100)   NULL,
    [nom_pc]               VARCHAR (50)    NULL,
    [ip]                   VARCHAR (25)    NULL,
    CONSTRAINT [PK_tb_sis_Documento_Tipo_Reporte_x_Empresa] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [codDocumentoTipo] ASC),
    CONSTRAINT [FK_tb_sis_Documento_Tipo_Reporte_x_Empresa_tb_sis_Documento_Tipo] FOREIGN KEY ([codDocumentoTipo]) REFERENCES [dbo].[tb_sis_Documento_Tipo] ([codDocumentoTipo])
);

