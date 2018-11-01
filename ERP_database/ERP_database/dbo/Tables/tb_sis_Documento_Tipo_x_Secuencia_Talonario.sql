CREATE TABLE [dbo].[tb_sis_Documento_Tipo_x_Secuencia_Talonario] (
    [IdEmpresa]        INT          NOT NULL,
    [IdSucursal]       INT          NOT NULL,
    [IdBodega]         INT          NOT NULL,
    [CodDocumentoTipo] VARCHAR (20) NOT NULL,
    [Secuencia]        INT          NOT NULL,
    [Serie1]           VARCHAR (5)  NOT NULL,
    [Serie2]           VARCHAR (5)  NOT NULL,
    [FechaCaducidad]   DATETIME     NOT NULL,
    [NAutorizacion]    VARCHAR (50) NOT NULL,
    [DocInicial]       VARCHAR (50) NOT NULL,
    [DocFinal]         VARCHAR (50) NOT NULL,
    [DocActual]        VARCHAR (50) NOT NULL,
    [Estado]           CHAR (1)     NOT NULL,
    CONSTRAINT [PK_fa_Documento_Tipo_x_Secuencia_Talonario_1] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursal] ASC, [IdBodega] ASC, [CodDocumentoTipo] ASC, [Secuencia] ASC)
);

