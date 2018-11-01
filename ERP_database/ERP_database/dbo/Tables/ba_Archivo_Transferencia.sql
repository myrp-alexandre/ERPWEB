CREATE TABLE [dbo].[ba_Archivo_Transferencia] (
    [IdEmpresa]           INT             NOT NULL,
    [IdArchivo]           NUMERIC (18)    NOT NULL,
    [cod_archivo]         VARCHAR (50)    NULL,
    [IdBanco]             INT             NOT NULL,
    [IdOrden_Bancaria]    VARCHAR (50)    NULL,
    [IdProceso_bancario]  VARCHAR (25)    NOT NULL,
    [Origen_Archivo]      VARCHAR (50)    NOT NULL,
    [Cod_Empresa]         VARCHAR (30)    NOT NULL,
    [Nom_Archivo]         VARCHAR (200)   NOT NULL,
    [Fecha]               DATETIME        NOT NULL,
    [Archivo]             VARBINARY (MAX) NOT NULL,
    [Estado]              BIT             NOT NULL,
    [IdEstadoArchivo_cat] VARCHAR (50)    NOT NULL,
    [IdMotivoArchivo_cat] VARCHAR (50)    NULL,
    [IdUsuario]           VARCHAR (20)    NULL,
    [Fecha_Transac]       DATETIME        NULL,
    [Observacion]         VARCHAR (200)   NOT NULL,
    [IdUsuarioUltMod]     VARCHAR (20)    NULL,
    [Fecha_UltMod]        DATETIME        NULL,
    [IdUsuarioUltAnu]     VARCHAR (20)    NULL,
    [Fecha_UltAnu]        DATETIME        NULL,
    [Nom_pc]              VARCHAR (50)    NULL,
    [Ip]                  VARCHAR (25)    NULL,
    [Motivo_anulacion]    VARCHAR (100)   NULL,
    [Fecha_Proceso]       DATETIME        NULL,
    [Contabilizado]       BIT             NULL,
    CONSTRAINT [PK_ba_Archivo_Transferencia] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdArchivo] ASC),
    CONSTRAINT [FK_ba_Archivo_Transferencia_ba_Banco_Cuenta] FOREIGN KEY ([IdEmpresa], [IdBanco]) REFERENCES [dbo].[ba_Banco_Cuenta] ([IdEmpresa], [IdBanco]),
    CONSTRAINT [FK_ba_Archivo_Transferencia_ba_Catalogo] FOREIGN KEY ([IdEstadoArchivo_cat]) REFERENCES [dbo].[ba_Catalogo] ([IdCatalogo]),
    CONSTRAINT [FK_ba_Archivo_Transferencia_ba_Catalogo1] FOREIGN KEY ([IdMotivoArchivo_cat]) REFERENCES [dbo].[ba_Catalogo] ([IdCatalogo]),
    CONSTRAINT [FK_ba_Archivo_Transferencia_tb_banco_procesos_bancarios_tipo] FOREIGN KEY ([IdProceso_bancario]) REFERENCES [dbo].[tb_banco_procesos_bancarios_tipo] ([IdProceso_bancario_tipo])
);


GO
CREATE NONCLUSTERED INDEX [IX_ba_Archivo_Transferencia]
    ON [dbo].[ba_Archivo_Transferencia]([IdEmpresa] ASC, [IdArchivo] ASC, [IdBanco] ASC, [IdProceso_bancario] ASC);

