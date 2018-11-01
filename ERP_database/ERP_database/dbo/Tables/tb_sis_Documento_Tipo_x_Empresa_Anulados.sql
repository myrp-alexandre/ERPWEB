CREATE TABLE [dbo].[tb_sis_Documento_Tipo_x_Empresa_Anulados] (
    [IdEmpresa]        INT           NOT NULL,
    [codDocumentoTipo] VARCHAR (20)  NOT NULL,
    [IdTipoDocAnu]     NUMERIC (18)  NOT NULL,
    [Fecha]            DATETIME      NOT NULL,
    [Serie1]           VARCHAR (3)   NOT NULL,
    [Serie2]           VARCHAR (3)   NOT NULL,
    [Documento]        VARCHAR (50)  NOT NULL,
    [Autorizacion]     VARCHAR (50)  NOT NULL,
    [IdMotivoAnu]      INT           NOT NULL,
    [MotivoAnu]        VARCHAR (300) NULL,
    [nom_pc]           VARCHAR (50)  NULL,
    [ip]               VARCHAR (50)  NULL,
    [IdUsuarioUltAnu]  VARCHAR (50)  NULL,
    [Fecha_UltAnu]     DATETIME      NULL,
    CONSTRAINT [PK_tb_sis_Documento_Tipo_x_Empresa_Anulados] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [codDocumentoTipo] ASC, [IdTipoDocAnu] ASC)
);

