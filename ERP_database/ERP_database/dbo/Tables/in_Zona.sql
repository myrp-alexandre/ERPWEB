CREATE TABLE [dbo].[in_Zona] (
    [IdEmpresa]  INT           NOT NULL,
    [IdZona]     NCHAR (10)    NOT NULL,
    [Zona]       VARCHAR (200) NULL,
    [IdTipoZona] VARCHAR (10)  NULL,
    CONSTRAINT [PK_in_Zona] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdZona] ASC)
);

