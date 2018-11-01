CREATE TABLE [dbo].[tb_sis_Documento_Registros_x_Talonario] (
    [IdEmpresa]              INT           NOT NULL,
    [IdDocumentoTalonario]   VARCHAR (150) NOT NULL,
    [CodDocumentoTipo]       VARCHAR (20)  NOT NULL,
    [Serie1]                 VARCHAR (3)   NOT NULL,
    [Serie2]                 VARCHAR (3)   NOT NULL,
    [NumDocumento]           VARCHAR (50)  NOT NULL,
    [NumAutorizacion]        VARCHAR (150) NOT NULL,
    [NumDocIni]              VARCHAR (50)  NOT NULL,
    [NumDocFin]              VARCHAR (50)  NOT NULL,
    [Utilizado]              CHAR (1)      NOT NULL,
    [Estado]                 CHAR (1)      NOT NULL,
    [TransaccionRelacionada] VARCHAR (250) NULL,
    CONSTRAINT [PK_tb_sis_Documento_Tipo_Talonario] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdDocumentoTalonario] ASC)
);

