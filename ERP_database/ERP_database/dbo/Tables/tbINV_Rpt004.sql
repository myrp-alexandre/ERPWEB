CREATE TABLE [dbo].[tbINV_Rpt004] (
    [IdEmpresa]         INT           NOT NULL,
    [IdUsuario]         VARCHAR (20)  NOT NULL,
    [Fecha_Transac]     DATETIME      NOT NULL,
    [nom_pc]            VARCHAR (20)  NULL,
    [pe_cedulaRuc]      VARCHAR (50)  NOT NULL,
    [pe_nombreCompleto] VARCHAR (200) NOT NULL,
    CONSTRAINT [PK_tbINV_Rpt004] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdUsuario] ASC, [Fecha_Transac] ASC)
);

