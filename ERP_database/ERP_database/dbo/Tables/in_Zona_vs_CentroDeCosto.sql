CREATE TABLE [dbo].[in_Zona_vs_CentroDeCosto] (
    [IdEmpresaIdZona]     INT          NOT NULL,
    [IdZona]              INT          NOT NULL,
    [IdEmpresaCentrCosot] INT          NOT NULL,
    [IdCentroCosto]       DECIMAL (18) NOT NULL,
    [IdSubZona]           INT          NOT NULL,
    [CodigoZN]            VARCHAR (50) NULL,
    [IdCtaCbleZona]       VARCHAR (20) NULL,
    CONSTRAINT [PK_in_Zona_vs_CentroDeCosto] PRIMARY KEY CLUSTERED ([IdEmpresaIdZona] ASC, [IdZona] ASC, [IdEmpresaCentrCosot] ASC, [IdCentroCosto] ASC, [IdSubZona] ASC)
);

