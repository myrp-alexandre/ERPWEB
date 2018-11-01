CREATE TABLE [dbo].[ba_Archivo_Transferencia_x_PreAviso_Cheq] (
    [IdEmpresa]                 INT             NOT NULL,
    [IdArchivo_preaviso_cheq]   NUMERIC (18)    NOT NULL,
    [cod_Archivo_preaviso_cheq] VARCHAR (50)    NOT NULL,
    [IdBanco]                   INT             NOT NULL,
    [Nom_Archivo]               VARCHAR (50)    NOT NULL,
    [Observacion]               VARCHAR (MAX)   NOT NULL,
    [Fecha]                     DATETIME        NOT NULL,
    [Estado]                    BIT             NOT NULL,
    [Fecha_Proceso]             DATETIME        NOT NULL,
    [Archivo]                   VARBINARY (MAX) NULL,
    [IdUsuario]                 VARCHAR (50)    NULL,
    [Fecha_Transac]             DATETIME        NULL,
    [IdUsuarioUltMod]           VARCHAR (50)    NULL,
    [Fecha_UltMod]              DATETIME        NULL,
    [IdUsuarioUltAnu]           VARCHAR (50)    NULL,
    [Fecha_UltAnu]              DATETIME        NULL,
    [Nom_pc]                    VARCHAR (50)    NULL,
    [Ip]                        VARCHAR (50)    NULL,
    [Motivo_anulacion]          VARCHAR (50)    NULL,
    CONSTRAINT [PK_ba_Archivo_Transferencia_x_PreAviso_Cheq] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdArchivo_preaviso_cheq] ASC),
    CONSTRAINT [FK_ba_Archivo_Transferencia_x_PreAviso_Cheq_ba_Banco_Cuenta] FOREIGN KEY ([IdEmpresa], [IdBanco]) REFERENCES [dbo].[ba_Banco_Cuenta] ([IdEmpresa], [IdBanco])
);

