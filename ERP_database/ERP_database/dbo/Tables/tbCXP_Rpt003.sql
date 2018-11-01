CREATE TABLE [dbo].[tbCXP_Rpt003] (
    [IdEmpresa]       INT           NOT NULL,
    [IdUsuario]       VARCHAR (20)  NOT NULL,
    [Fecha_Transac]   DATETIME      NULL,
    [nom_pc]          VARCHAR (50)  NOT NULL,
    [saldoProveedor]  FLOAT (53)    NULL,
    [nombreProveedor] VARCHAR (150) NULL,
    [IdProveedor]     NUMERIC (18)  NOT NULL,
    CONSTRAINT [PK_tbCXP_Rpt003] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdUsuario] ASC, [nom_pc] ASC, [IdProveedor] ASC)
);

