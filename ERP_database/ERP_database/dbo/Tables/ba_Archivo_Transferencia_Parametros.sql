CREATE TABLE [dbo].[ba_Archivo_Transferencia_Parametros] (
    [IdEmpresa] INT          NOT NULL,
    [IdBanco]   INT          NOT NULL,
    [cod_banco] VARCHAR (20) NOT NULL,
    CONSTRAINT [PK_ba_Archivo_Transferencia_Parametros] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdBanco] ASC)
);

