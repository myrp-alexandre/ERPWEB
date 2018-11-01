CREATE TABLE [dbo].[tbCXP_Rpt004] (
    [IdEmpresa]        INT           NOT NULL,
    [IdUsuario]        VARCHAR (20)  NOT NULL,
    [NRetencion]       VARCHAR (50)  NOT NULL,
    [nom_pc]           VARCHAR (50)  NOT NULL,
    [IdSecuenciaReten] INT           IDENTITY (1, 1) NOT NULL,
    [TipoRetencion]    VARCHAR (5)   NOT NULL,
    [NDocumento]       VARCHAR (50)  NOT NULL,
    [Fecha_Transac]    DATETIME      NOT NULL,
    [fechaRetencion]   DATE          NOT NULL,
    [Proveedor]        VARCHAR (150) NOT NULL,
    [BaseRetencion]    FLOAT (53)    NOT NULL,
    [ValorRetencion]   FLOAT (53)    NOT NULL,
    [CodigoSRI]        VARCHAR (50)  NOT NULL,
    CONSTRAINT [PK_tbCXP_Rpt004] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdUsuario] ASC, [NRetencion] ASC, [nom_pc] ASC, [IdSecuenciaReten] ASC, [TipoRetencion] ASC, [NDocumento] ASC)
);

