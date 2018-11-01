CREATE TABLE [dbo].[tbCXP_Rpt006] (
    [IdEmpresa]      INT           NOT NULL,
    [IdUsuario]      VARCHAR (20)  NOT NULL,
    [nom_pc]         VARCHAR (50)  NOT NULL,
    [nDoc]           VARCHAR (150) NOT NULL,
    [NAutorizacion]  VARCHAR (50)  NOT NULL,
    [Documento]      VARCHAR (150) NOT NULL,
    [IdProveedor]    NUMERIC (18)  NOT NULL,
    [IdCbte]         NUMERIC (18)  NOT NULL,
    [secuencia]      INT           IDENTITY (1, 1) NOT NULL,
    [Fecha_Transac]  DATETIME      NULL,
    [Fecha]          DATE          NULL,
    [FechaVence]     DATE          NULL,
    [pr_CedulaRuc]   VARCHAR (50)  NULL,
    [Proveedor]      VARCHAR (250) NULL,
    [Observacion]    VARCHAR (500) NULL,
    [SubtotalIva]    FLOAT (53)    NULL,
    [SubtotalSinIva] FLOAT (53)    NULL,
    [baseImponible]  FLOAT (53)    NULL,
    [Total]          FLOAT (53)    NULL,
    [FechaCbte]      DATE          NULL,
    CONSTRAINT [PK_tbCXP_Rpt006] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdUsuario] ASC, [nom_pc] ASC, [nDoc] ASC, [NAutorizacion] ASC, [Documento] ASC, [IdProveedor] ASC, [IdCbte] ASC, [secuencia] ASC)
);

